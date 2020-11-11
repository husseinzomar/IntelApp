import 'package:intel/bottomnavbar/shoppingcart.dart';
import 'package:intel/bottomnavbar/homapage.dart';
import 'package:intel/bottomnavbar/profile.dart';
import 'package:intel/bottomnavbar/addItem.dart';
import 'package:intel/Drawer.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:intel/models/item/itemcontroller.dart';
import 'package:flutter/material.dart';


class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {


  int current = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerList(),

      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem( 
            icon: Icon(Icons.home),
            label: 'Home'
          ),
          BottomNavigationBarItem( 
            icon: Icon(Icons.shopping_cart),
            label: 'Shopping Cart'
          ),
          BottomNavigationBarItem( 
            icon: Icon(Icons.shopping_bag),
            label: 'Add Items'
          ),
          BottomNavigationBarItem( 
            icon: Icon(Icons.person),
            label: 'Profile'
          ),
        ],


        selectedItemColor: Color(0xffE74C3C),
        unselectedItemColor: Colors.grey,

        currentIndex: current,
        onTap: (index){
          setState(() {
            current = index;
          });
        },
      ),


      body: ScopedModelDescendant<ItemController>(
          builder: (context, child, ItemController item) {
            if (current == 0) {
              return HomePage(item);
            } else if (current == 1) {
              return ShoppingCart();
            } else if (current == 2) {
              return Sell();
            } else {
              return Profile();
            }
          }
      ),
    );
  }
}