import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodpanda_sellers_app/global/global.dart';
import 'package:foodpanda_sellers_app/model/address.dart';
import 'package:foodpanda_sellers_app/model/orders.dart';
import 'package:foodpanda_sellers_app/splashScreen/splash_screen.dart';


class ShipmentAddressDesign extends StatefulWidget
{
  final Address? model;
  final Orders? models;
  final String? orderStatus;
  final String? orderId;
  final String? sellerId;
  final String? orderByUser;

  ShipmentAddressDesign({
    this.model,
    this.models,
    this.orderStatus,
    this.orderId,
    this.sellerId,
    this.orderByUser,
  });


  @override
  State<ShipmentAddressDesign> createState() => _ShipmentAddressDesignState();
}

class _ShipmentAddressDesignState extends State<ShipmentAddressDesign> {



  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            'Thông tin khách hàng: ',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        const SizedBox(
          height: 6.0,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 5),
          width: MediaQuery.of(context).size.width,
          child: Table(
            children: [
              TableRow(
                children: [
                  const Text(
                    "Tên khách hàng: ",
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  Text(widget.model!.name!),
                ],
              ),
              TableRow(
                children: [
                  const Text(
                    "Số điện thoại: ",
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  Text(widget.model!.phoneNumber!),
                ],
              ),
              TableRow(
                children: [
                  const Text(
                    "Địa chỉ: ",
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  Text(widget.model!.fullAddress!),
                ],
              ),

            ],
          ),
        ),
        // const SizedBox(
        //   height: 20,
        // ),




        const SizedBox(height: 20,),

      ],
    );
  }
}


