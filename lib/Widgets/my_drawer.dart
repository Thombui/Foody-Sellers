import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodpanda_sellers_app/authentication/auth_screen.dart';
import 'package:foodpanda_sellers_app/global/global.dart';
import 'package:foodpanda_sellers_app/mainScreens/earnings_screen.dart';
import 'package:foodpanda_sellers_app/mainScreens/history_screen.dart';
import 'package:foodpanda_sellers_app/mainScreens/home_screen.dart';
import 'package:foodpanda_sellers_app/mainScreens/new_orders_screen.dart';


class MyDrawer extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          //header drawer
          Container(
            padding: const EdgeInsets.only(top: 25, bottom: 10),
            child: Column(
              children: [
                Material(
                  borderRadius: const BorderRadius.all(Radius.circular(80)),
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Container(
                      height: 160,
                      width: 160,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                          sharedPreferences!.getString("photoUrl")!
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                Text(
                    sharedPreferences!.getString("name")!,
                  style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 25, fontFamily: "TrainOne"),
                )
              ],
            ),
          ),

          const SizedBox(height: 12,),
          //body drawer
          Container(
            padding: const EdgeInsets.only(top: 1.0),
            child: Column(
              children:  [
                  const Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 2,
                ),
                ListTile(
                  leading:const Icon(Icons.home, color: Colors.black,),
                  title:const Text(
                    "Trang ch???",
                    style: TextStyle(color: Colors.black),
                  ),
                  onTap: ()
                  {
                    Navigator.push(context, MaterialPageRoute(builder: (c)=> const HomeScreen()));

                  },
                ),
                const Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 2,
                ),

                ListTile(
                  leading:const Icon(Icons.reorder, color: Colors.black,),
                  title:const Text(
                    "????n h??ng m???i",
                    style: TextStyle(color: Colors.black),
                  ),
                  onTap: ()
                  {
                    Navigator.push(context, MaterialPageRoute(builder: (c)=> NewOrdersScreen()));

                  },
                ),

                const Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 2,
                ),
                ListTile(
                  leading:const Icon(Icons.local_shipping, color: Colors.black,),
                  title:const Text(
                    "L???ch s??? ????n h??ng",
                    style: TextStyle(color: Colors.black),
                  ),
                  onTap: ()
                  {
                    Navigator.push(context, MaterialPageRoute(builder: (c)=> HistoryScreen()));
                  },
                ),
                const Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 2,
                ),
                ListTile(
                  leading:const Icon(Icons.monetization_on, color: Colors.black,),
                  title:const Text(
                    "Doanh thu",
                    style: TextStyle(color: Colors.black),
                  ),
                  onTap: ()
                  {
                    Navigator.push(context, MaterialPageRoute(builder: (c)=> EarningsScreen()));
                  },
                ),
                const Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 2,
                ),
                ListTile(
                  leading:const Icon(Icons.exit_to_app, color: Colors.black,),
                  title:const Text(
                    "????ng xu???t",
                    style: TextStyle(color: Colors.black),
                  ),
                  onTap: ()
                  {
                  firebaseAuth.signOut().then((value){
                  Navigator.push(context, MaterialPageRoute(builder: (c)=> const AuthScreen()));
                  Fluttertoast.showToast(msg: "????ng xu???t th??nh c??ng");
                  }
                );

                }
                ),
                  const Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 2,
                  )
                  ],

          ),
          )],
      ),
    );
  }
}
