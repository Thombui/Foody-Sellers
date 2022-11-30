import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodpanda_sellers_app/Widgets/error_dialog.dart';
import 'package:foodpanda_sellers_app/mainScreens/home_screen.dart';
import 'package:foodpanda_sellers_app/mainScreens/new_orders_screen.dart';
import 'package:foodpanda_sellers_app/model/orders.dart';


import '../global/global.dart';


class CancelOrConfirmOrdersDesign extends StatefulWidget {
  final Orders? model;
  //BuildContext? context;
  CancelOrConfirmOrdersDesign({this.model});

  @override
  State<CancelOrConfirmOrdersDesign> createState() => _CancelOrConfirmOrdersDesignState();
}

class _CancelOrConfirmOrdersDesignState extends State<CancelOrConfirmOrdersDesign>
{
  //Xác nhận hủy
  cancelOrder(String getOrderID,String userID)
  {
    FirebaseFirestore.instance.collection("users")
        .doc(userID)
        .collection("orders")
        .doc(getOrderID)
        .get().then((snapshot)
    {
      if(snapshot.data()!["status"] == "Chờ xác nhận")
      {
        FirebaseFirestore.instance.collection("users")
            .doc(userID)
            .collection("orders")
            .doc(getOrderID)
            .update({
          "status": "Người bán hủy đơn",
        })
            .then((snapshot)
        {
          FirebaseFirestore.instance
              .collection("orders")
              .doc(getOrderID)
              .update({
            "status": "Người bán hủy đơn",
          });

          Navigator.pop(context);
          Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
          Fluttertoast.showToast(msg: "Đơn hàng đã được hủy");
        }
        );

    }
      else
      {
        showDialog(
            context: context,
            builder: (c)
            {
              return ErrorDialog(
                message: "Không thể hủy đơn",
              );
            }
        );
      }
    }
    );
    // send rider to shipmentScreen
  }

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
          padding: const EdgeInsets.all(5.0),
          child: Center(
            child: InkWell(
              onTap: () {
                cancelOrder(widget.model!.orderId!, widget.model!.orderBy!);
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (c) => HomeScreen()));
                Fluttertoast.showToast(msg: "Hủy đơn hàng thành công");
              },
              child: Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.cyan,
                        Colors.amber,
                      ],
                      begin: FractionalOffset((0.0), 0.0),
                      end: FractionalOffset(1.0, 0.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp,
                    )),
                width: MediaQuery.of(context).size.width - 40,
                height: 50,
                child: const Center(
                  child: Text(
                    "Hủy đơn hàng",
                    style: TextStyle(color: Colors.white, fontSize: 15.0),
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Center(
            child: InkWell(
              onTap: () {
                confirmOrder(widget.model!.orderId!, widget.model!.orderBy!);
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (c) => NewOrdersScreen()));
                Fluttertoast.showToast(msg: "Chuẩn bị đơn hàng thành công");
              },
              child: Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.cyan,
                        Colors.amber,
                      ],
                      begin: FractionalOffset((0.0), 0.0),
                      end: FractionalOffset(1.0, 0.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp,
                    )),
                width: MediaQuery.of(context).size.width - 40,
                height: 50,
                child: const Center(
                  child: Text(
                    "Đóng gói hoàn thành - xác nhận",
                    style: TextStyle(color: Colors.white, fontSize: 15.0),
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
