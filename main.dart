import 'package:flutter/material.dart';
import 'package:intel/bottomnavbar/homapage.dart';
import 'package:intel/models/item/itemcontroller.dart';
import 'package:intel/bottomnavbar/sign.dart';
import 'package:intel/bottomnavbar/splashscreen.dart';
import 'package:intel/models/item/itemcontroller.dart';
import 'package:intel/bottomnavbar/profile/order.dart';
import 'package:intel/bottomnavbar/bottomBar.dart';
import 'package:scoped_model/scoped_model.dart';



void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: ItemController(),

      child: MaterialApp(
      title: 'Hussein AL-zomar intel',
      theme: ThemeData(
        primarySwatch:Colors.teal, 
        fontFamily: 'MontserratMedium',
      ),
      
      debugShowCheckedModeBanner: false,
      home: Sing(),
      routes: {
        'order' : (context) => Order(),
      },
      )
    );
  }
}