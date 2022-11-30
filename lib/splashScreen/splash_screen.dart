import 'dart:async';

import 'package:flutter/material.dart';
import 'package:foodpanda_sellers_app/authentication/auth_screen.dart';
import 'package:foodpanda_sellers_app/global/global.dart';
import 'package:foodpanda_sellers_app/mainScreens/home_screen.dart';

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({Key? key}) : super(key: key);

  @override
  State<MySplashScreen> createState() => _MySplashScreenState();
}



class _MySplashScreenState extends State<MySplashScreen>
{
  
  startTimer()
  {
    Timer(const Duration(seconds: 2), () async
    {
      //If seller is loggedin already
      if(firebaseAuth.currentUser != null)
      {
        Navigator.push(context, MaterialPageRoute(builder: (c)=> const HomeScreen() ));

      }
      //If seller is NOT loggedin already
      else
      {
        Navigator.push(context, MaterialPageRoute(builder: (c)=> const AuthScreen() ));

      }
    });
  }
 //chức năng này được gọi tự động bất cứ khi nào người dùng đến màn hình của họ.
  @override
  void initState() {

    super.initState();
    startTimer();
  }

  @override

  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.white30,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,  // các widget con của column sẽ được đặt sát nhau từ vị trí trung tâm
            children: [
              Image.asset("images/food-delivery-business.png"),
              const SizedBox(height: 10,),

             const Padding(
               padding: EdgeInsets.all(10.0),
               child: Text(
                 "Foody cho bữa ăn ngon hơn !!",
                 textAlign: TextAlign.center,
                 style: TextStyle(
                   color: Colors.black,
                   fontSize: 26,
                   fontFamily: "Lobster",
                   letterSpacing: 2,
                 ),
               ),
             ),

            ],
          ),
        ),
      ),
    );
  }
}
