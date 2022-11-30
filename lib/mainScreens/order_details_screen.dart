import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodpanda_sellers_app/Widgets/cancel_or_confirm_orders_design.dart';
import 'package:foodpanda_sellers_app/Widgets/confirm_order_design.dart';
import 'package:foodpanda_sellers_app/Widgets/delete_history_design.dart';
import 'package:foodpanda_sellers_app/Widgets/progress_bar.dart';
import 'package:foodpanda_sellers_app/Widgets/return_design.dart';
import 'package:foodpanda_sellers_app/Widgets/shipment_address_design.dart';
import 'package:foodpanda_sellers_app/model/address.dart';
import 'package:foodpanda_sellers_app/model/orders.dart';

import 'package:intl/intl.dart';

import '../Widgets/status_banner.dart';

class OrderDetailsScreen extends StatefulWidget
{

  final String? orderID;

  OrderDetailsScreen({this.orderID});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen>
{

  String orderStatus = "";
  String orderByUser = "";
  String sellerId = "";


  getOrderInfo()
  {
    FirebaseFirestore.instance
        .collection("orders")
        .doc(widget.orderID).get().then((DocumentSnapshot)
    {
      orderStatus = DocumentSnapshot.data()!["status"].toString();
      orderByUser = DocumentSnapshot.data()!["orderBy"].toString();
      sellerId = DocumentSnapshot.data()!["sellerUID"].toString();
    });
  }

  @override
  void initState() {

    super.initState();

    getOrderInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance
              .collection("orders")
              .doc(widget.orderID)
              .get(),
          builder: (c, snapshot)
          {
            Map? dataMap;
            if(snapshot.hasData)
            {
              dataMap = snapshot.data!.data()! as Map<String, dynamic>;
              orderStatus = dataMap["status"].toString();
            }
            return snapshot.hasData
                ? Container(
                      child: Column(
                        children: [
                          StatusBanner(
                            status: dataMap!["isSuccess"],
                            orderStatus: orderStatus,
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Tổng tiền đơn hàng: ${dataMap["totalAmount"]} Đ",
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Mã vận đơn = ${widget.orderID!}",
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Thời gian đặt hàng: ${DateFormat("dd MMMM, yyyy -  hh:mm aa")
                                  .format(DateTime.fromMillisecondsSinceEpoch(int.parse(dataMap["orderTime"])))}",
                              style: const TextStyle(fontSize: 16, color: Colors.black87),
                            ),
                          ),
                          orderStatus == "Giao thành công"
                          ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Thời gian giao hàng: ${DateFormat("dd MMMM, yyyy -  hh:mm aa")
                                  .format(DateTime.fromMillisecondsSinceEpoch(int.parse(dataMap["endedTime"])))}",
                              style: const TextStyle(fontSize: 16, color: Colors.black87),
                            ),
                          )
                          : Text(" "),

                          const Divider(thickness: 4,),
                          orderStatus != "Giao thành công"
                              ? Image.asset("images/packing.png")
                              : Image.asset("images/delivered.jpg"),
                          const Divider(thickness: 4,),
                          FutureBuilder<DocumentSnapshot>(
                            future: FirebaseFirestore.instance
                                .collection("users")
                                .doc(orderByUser)
                                .collection("userAddress")
                                .doc(dataMap["addressID"])
                                .get(),
                            builder: (c, snapshot)
                            {
                              return snapshot.hasData
                                  ? ShipmentAddressDesign(
                                model: Address.fromJson(snapshot.data!.data()! as Map<String, dynamic>,
                                ),
                                orderStatus: orderStatus,
                                orderId: widget.orderID,
                                sellerId: sellerId,
                                orderByUser: orderByUser,
                              ) : Center(child: circularProgress(),);
                            },
                          ),

                          SizedBox(height: 1,),

                          orderStatus == "Giao thành công" ?
                              ReturnDesign()
                          :
                          FutureBuilder<DocumentSnapshot>(
                                    future: FirebaseFirestore.instance
                                        .collection("users")
                                        .doc(orderByUser)
                                        .collection("orders")
                                        .doc(dataMap["orderId"])
                                        .get(),
                                    builder: (c, snapshot)
                                    {
                                      return snapshot.hasData
                                          ? CancelOrConfirmOrdersDesign(
                                        model: Orders.fromJson(
                                            snapshot.data!.data()! as Map<String, dynamic>
                                        ),

                                      ) : Center(child: circularProgress(),);
                                    },
                                  ),


                        ]
                      ),

            )
                : Center(child: circularProgress(),);

          },
        ),
      ),
    );
  }
}
