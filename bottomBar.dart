import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:intel/models/item/itemcontroller.dart';
import 'package:intel/bottomnavbar/shoppingcart.dart';
import 'package:intel/bottomnavbar/profile.dart';
import 'package:intel/bottomnavbar/addItem.dart';
import 'package:intel/bottomnavbar/homapage.dart';
import 'package:intel/Drawer.dart';
import 'package:intel/bottomnavbar/trackOrder.dart';
import 'package:intel/bottomnavbar/search.dart';



class BottomBar extends StatefulWidget {
  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {


  int _page = 2;
  GlobalKey _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 2,
        height: 50.0,
        items: <Widget> [
          Icon(Icons.pin_drop,size: 25,color: Colors.white,),
          Icon(Icons.shopping_cart,size: 25,color: Colors.white,),
          Icon(Icons.home,size: 25,color: Colors.white,),
          Icon(Icons.add_shopping_cart,size: 25,color: Colors.white,),
          Icon(Icons.person,size: 25,color: Colors.white,)
        ],
        color: Color(0xffE74C3C),
        buttonBackgroundColor: Color(0xffE74C3C),
        backgroundColor: Colors.white,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 600),
        onTap: (index){
          setState(() {
            _page = index;
          });
        },
      ),


      body: ScopedModelDescendant<ItemController>(
        builder: (context,child,ItemController item) {
          if(_page == 0){
            return Map();
          }else if(_page == 1){
            return ShoppingCart();
          }else if(_page == 2){
            return HomePage(item);
          }else if(_page == 3){
            return Sell();
          }else{
            return Profile();
          }
        },
      ),
    );
  }
}