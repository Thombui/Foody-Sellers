import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodpanda_sellers_app/mainScreens/home_screen.dart';
import 'package:foodpanda_sellers_app/model/orders.dart';


import '../global/global.dart';


class ConfirmOrders extends StatefulWidget {
  final Orders? model;
  //BuildContext? context;
  ConfirmOrders({this.model});

  @override
  State<ConfirmOrders> createState() => _ConfirmOrdersState();
}

class _ConfirmOrdersState extends State<ConfirmOrders>
{
  //Xác nhận đã chuẩn bị xong đơn hàng
  confirmOrder(String getOrderID,String userID)
  {

    FirebaseFirestore.instance.collection("users")
        .doc(userID)
        .collection("orders")
        .doc(getOrderID).update({
      "status": "Đã chuẩn bị hàng",
    }).then((value)
    {
      FirebaseFirestore.instance
          .collection("orders")
          .doc(getOrderID)
          .update({
        "status": "Đã chuẩn bị hàng",
      });

    });
    // send rider to shipmentScreen
  }



  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: InkWell(
              onTap: ()
              {
                confirmOrder(widget.model!.orderId!, widget.model!.orderBy!);
                Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
                Fluttertoast.showToast(msg: "Xác nhận đã chuẩn bị xong đơn hàng");
              },
              child: Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.cyan,
                        Colors.amber,
                      ],
                      begin:  FractionalOffset((0.0), 0.0),
                      end:  FractionalOffset(1.0, 0.0),
                      stops: [0.0,1.0],
                      tileMode: TileMode.clamp,
                    )
                ),
                width: MediaQuery.of(context).size.width -40,
                height: 50,
                child: const Center(
                  child: Text(
                    "Đóng gói đơn hàng - Đã xong",
                    style:TextStyle(color: Colors.white, fontSize: 15.0),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
