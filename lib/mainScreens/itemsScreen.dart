import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:foodpanda_sellers_app/Widgets/menus_design.dart';
import 'package:foodpanda_sellers_app/Widgets/items_design.dart';
import 'package:foodpanda_sellers_app/Widgets/my_drawer.dart';
import 'package:foodpanda_sellers_app/Widgets/progress_bar.dart';
import 'package:foodpanda_sellers_app/Widgets/text_widget_header.dart';
import 'package:foodpanda_sellers_app/global/global.dart';
import 'package:foodpanda_sellers_app/model/items.dart';
import 'package:foodpanda_sellers_app/model/menus.dart';
import 'package:foodpanda_sellers_app/uploadScreens/items_upload_screen.dart';
import 'package:foodpanda_sellers_app/uploadScreens/menus_upload_screen.dart';

class ItemsScreen extends StatefulWidget
{
  final Menus? model;
  ItemsScreen({ this.model});



  @override
  State<ItemsScreen> createState() => _ItemsScreenState();
}

class _ItemsScreenState extends State<ItemsScreen>
{

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
        actions: [
          IconButton(
            icon: const Icon(Icons.library_add, color: Colors.cyan,),
            onPressed: ()
            {
              Navigator.push(context, MaterialPageRoute(builder: (c)=> ItemsUpLoadScreen(model: widget.model)));
            },
          ),
        ],
      ),
      drawer: MyDrawer(),
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(pinned: true, delegate: TextWidgetHeader(title: "${widget.model!.menuTitle}")),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("sellers")
                .doc(sharedPreferences!.getString("uid"))
                .collection("menus")
                .doc(widget.model!.menuID)
                .collection("items")
                .orderBy("publishedDate", descending: true)
                .snapshots(),
            builder: (context, snapshot)
            {
              return !snapshot.hasData
                  ? SliverToBoxAdapter(
                  child: Center(child: circularProgress(),),
              )
                  : SliverStaggeredGrid.countBuilder(
                  crossAxisCount: 1,
                   staggeredTileBuilder: (c) => const StaggeredTile.fit(1),
                  itemBuilder: (context, index)
                  {
                  Items model = Items.fromJson(
                    snapshot.data!.docs[index].data()! as Map<String, dynamic>,
                  );
                  return ItemsDesgnWidget(
                    model: model,
                    context: context,
                  );
                },
                itemCount: snapshot.data!.docs.length,
              );
            },
          ),

        ],
      ),
    );
  }
}
