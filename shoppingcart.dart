import 'dart:ui';

import 'package:firebase/firebase.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intel/widgets/item.dart';
import 'package:intel/bottomnavbar/homapage.dart';

class ShoppingCart extends StatefulWidget {
  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {

  List<String> itemName = ['BeoPlay Speaker', 'Leather Wristwatch','Chair ','Lamp' ,'Home','Office'];
  List<String> itemImage = ['assets/speaker.png', 'assets/watch.png', 'assets/chair.jpg', 'assets/lamp.jpg', 'assets/home.jpg', 'assets/office.jpg'];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color(0xffE74C3C),

        title: InkWell(
          child: Text(
            'Shopping Cart',
            style: TextStyle(fontFamily: 'Montserrat'),
          ),
        ),
        centerTitle: true,

        actions: [
          IconButton(
            icon: Icon(Icons.search,color: Colors.white,),
            onPressed: (){},
          ),
        ],
      ),


      backgroundColor: Colors.white,

      body: Container(
        margin: EdgeInsets.fromLTRB(0.0, 5.0, 15.0, 5.0),

        // need revision.

        child: GridView.builder(
          padding: EdgeInsets.only(top: 20.0),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(

            crossAxisCount: 2,
            mainAxisSpacing: 5.0,
            childAspectRatio: 0.57
          ),

          scrollDirection: Axis.vertical,

          itemCount: itemName.length,
          itemBuilder: (context,index){
            return Item(itemImage[index], itemName[index],'description','hdf','!order',200.0);
          },
        ),
      ),

      bottomNavigationBar: Container(
        child: Row(
          children: [
            Expanded(
              child: ListTile(
                title: Text(
                  'Total',style: TextStyle(
                    color: Color(0xffE74C3C),fontSize: 17.5,fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),

            Expanded(
              child: MaterialButton(
                onPressed: () {},
                child: Text(
                  'Buy',
                  style: TextStyle(color: Colors.white),
                ),
                color: Color(0xffE74C3C),
              ),
            )
          ],
        ),
      ),
    );
  }
}