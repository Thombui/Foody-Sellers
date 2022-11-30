import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodpanda_sellers_app/global/global.dart';
import 'package:foodpanda_sellers_app/splashScreen/splash_screen.dart';

class EarningsScreen extends StatefulWidget
{


  @override
  State<EarningsScreen> createState() => _EarningsScreenState();
}

class _EarningsScreenState extends State<EarningsScreen>
{
  double sellerTotalEarnings = 0;
  retrieveSellerEarnings() async
  {
    await FirebaseFirestore.instance
        .collection("sellers")
        .doc(sharedPreferences!.getString("uid"))
        .get().then((snap)
    {
      setState(() {
        sellerTotalEarnings = double.parse(snap.data()!["earnings"].toString());
      });

    });

  }

  @override
  void initState() {
    super.initState();

    retrieveSellerEarnings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
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
        ),
        title: Text(
          sharedPreferences!.getString("name")!,
          style: const TextStyle(fontSize: 30, fontFamily: "Lobster"),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,

      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Text(
                "${sellerTotalEarnings} Đ",
                style: const TextStyle(
                  fontSize: 80,
                  color: Colors.black,
                  fontFamily: "Signatra"
                ),
              ),

              const Text(
                "Doanh thu cửa hàng: ",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.red,
                    letterSpacing: 3,
                    //fontFamily:"Signatra",
                    fontWeight: FontWeight.bold,
                ),
              ),



              const SizedBox(
                height: 20,
                width: 200,
                child: Divider(
                  color: Colors.amber,
                  thickness: 1.5,
                ),
              ),
              const SizedBox(height: 40.0,),

              GestureDetector(
                onTap: ()
                {
                  Navigator.push(context, MaterialPageRoute(builder: (c)=>const MySplashScreen()));

                },
                child: const Card(
                  color: Colors.cyan,
                  margin: EdgeInsets.symmetric(vertical: 60, horizontal: 100),
                  child: ListTile(
                    leading: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    title: Text(
                      "Quay lại",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
