import 'package:intel/bottomnavbar/bottomnavbar.dart';
import 'package:intel/bottomnavbar/profile.dart';
import 'package:intel/bottomnavbar/addItem.dart';
import 'package:intel/bottomnavbar/shoppingcart.dart';
import 'package:intel/bottomnavbar/sign.dart';
import 'package:intel/bottomnavbar/profile/wishlist.dart';
import 'package:intel/bottomnavbar/trackOrder.dart';
import 'package:flutter/material.dart';


class DrawerList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [

          // Start header 
          UserAccountsDrawerHeader(
            accountName: Text(
              'Hussein Al-Zomar',
              style: TextStyle(fontSize: 18,fontFamily: 'MontserratSemiBold'),
            ),
            accountEmail: Text('hussein6190@gmail.com',
            style: TextStyle(color: Colors.white,fontSize: 12, fontStyle: FontStyle.italic,)
            ),
            currentAccountPicture: GestureDetector(
              child: Image(image: AssetImage('assets/hussein.jpg')),
            ),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: ExactAssetImage('assets/pp.jpg'),
                fit: BoxFit.cover
              ),
            ),
          ),
                //end Header


                //Start Body

          InkWell(
            onTap: () {
              Navigator.push(context, 
              MaterialPageRoute(builder: (context) => BottomNavBar()));
            },

            child: ListTile(
              title: Text('Home',
              style: TextStyle(color: Color(0xffE74C3C),fontFamily: 'Montserrat')),
              leading: Icon(Icons.home,color: Color(0xffE74C3C)),
            ),
          ),

            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Profile()));
              },

              child: ListTile(
                title: Text('Profile',
                style: TextStyle(color: Color(0xffE74C3C),fontFamily: 'Montserrat')),
                leading: Icon(Icons.person_pin_rounded,color: Color(0xffE74C3C)),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Wishlist()));
              },

              child: ListTile(
                title: Text('Wishlist',
                style: TextStyle(color: Color(0xffE74C3C),fontFamily: 'Montserrat')),
                leading: Icon(Icons.favorite,color: Color(0xffE74C3C)),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Sell()));
              },

              child: ListTile(
                title: Text('Add Items',
                style: TextStyle(color: Color(0xffE74C3C),fontFamily: 'Montserrat')),
                leading: Icon(Icons.shopping_bag, color: Color(0xffE74C3C)),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ShoppingCart()));
              },

              child: ListTile(
                title:  Text('Shopping Cart',
                style: TextStyle(color: Color(0xffE74C3C),fontFamily: 'Montserrat')),
                leading: Icon(Icons.shopping_cart,color: Color(0xffE74C3C)),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Map()));
              },

              child: ListTile(
                title: Text('Track your order',
                style: TextStyle(color: Color(0xffE74C3C),fontFamily: 'Montserrat')),
                leading: Icon(Icons.delivery_dining,color: Color(0xffE74C3C)),
              ),
            ),

            Divider(),
            InkWell(
              onTap: (){},
              child: ListTile(
                title: Text('About',
                style: TextStyle(color: Colors.black54)),
                  leading: Icon(
                    Icons.info_outline),
              ),
            ),
            InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Sing()),
              );
            },
            child: ListTile(
              title: Text('Sign Out', style: TextStyle(color: Colors.black54)),
              leading: Icon(
                Icons.exit_to_app,
              ),
            ),
          ),
                    // end the body

        ],
      ),
    );
  }
}