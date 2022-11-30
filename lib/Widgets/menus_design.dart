import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodpanda_sellers_app/global/global.dart';
import 'package:foodpanda_sellers_app/mainScreens/itemsScreen.dart';
import 'package:foodpanda_sellers_app/model/menus.dart';


class InfoDesgnWidget extends StatefulWidget
{

  Menus? model;
  BuildContext? context;

  InfoDesgnWidget({this.model, this.context});


  @override
  State<InfoDesgnWidget> createState() => _InfoDesgnWidgetState();
}

class _InfoDesgnWidgetState extends State<InfoDesgnWidget>
{
  deleteMenu(String menuID)
  {
    FirebaseFirestore.instance.collection("sellers")
        .doc(sharedPreferences!.getString("uid"))
        .collection("menus")
        .doc(menuID)
        .delete();

    print(menuID);
    Fluttertoast.showToast(msg: "Xóa Menu thành công");
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()
      {
        Navigator.push(context, MaterialPageRoute(builder: (c)=> ItemsScreen(model: widget.model)));
      },
      splashColor: Colors.amber,
      child: Padding(
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
                    widget.model!.menuTitle!,
                    style: const TextStyle(
                      color: Colors.cyan,
                      fontSize: 20,
                      fontFamily: "TrainOne",
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.delete_sweep,
                      color: Colors.pinkAccent,
                    ),
                    onPressed: ()
                    {
                      // delete Menu
                      deleteMenu(widget.model!.menuID!);
                      Fluttertoast.showToast(msg: "Xóa menu thành công");
                    },
                  )
                ],
              ),
              Text(
                widget.model!.menuInfo!,
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
    );
  }
}
