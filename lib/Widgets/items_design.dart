import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodpanda_sellers_app/global/global.dart';
import 'package:foodpanda_sellers_app/mainScreens/item_detail_screen.dart';
import 'package:foodpanda_sellers_app/model/items.dart';



class ItemsDesgnWidget extends StatefulWidget {

  Items? model;
  BuildContext? context;

  ItemsDesgnWidget({this.model, this.context});


  @override
  State<ItemsDesgnWidget> createState() => _ItemsDesgnWidgetState();
}

class _ItemsDesgnWidgetState extends State<ItemsDesgnWidget>
{

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()
      {
        Navigator.push(context, MaterialPageRoute(builder: (c)=> ItemDetailsScreen(model: widget.model)));
      },
      splashColor: Colors.amber,
      child: SingleChildScrollView(
        child:  Padding(
          padding: const EdgeInsets.all(5.0),
          child: Container(
            height: 300,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Divider(
                  height: 4,
                  thickness: 3,
                  color: Colors.grey[300],
                ),
                Image.network(
                  widget.model!.thumbnaiUrl!,
                  height: 220.0,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 1.0,),


                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.model!.title!,
                      style: const TextStyle(
                        color: Colors.cyan,
                        fontSize: 20,
                        fontFamily: "TrainOne",
                      ),
                    ),

                  ],
                ),


                Text(
                  widget.model!.shortInfo!,
                  style: const TextStyle(
                    color: Colors.grey,

                    fontSize: 14,
                  ),
                ),


                Divider(
                  height: 4,
                  thickness: 3,
                  color: Colors.grey[300],
                ),

              ],
            ),
          ),
        ),
      )


      );

  }
}
