import 'package:flutter/material.dart';
import 'package:floating_search_bar/floating_search_bar.dart';

import 'dart:io'show Platform;

class SearchRR extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<SearchRR> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,


      home: FloatingSearchBar.builder(
        pinned: true,
        itemCount: 100,
        padding: EdgeInsets.only(top: 10.0),
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: Text(index.toString()),
          );
        },
        leading: IconButton(
          icon: Icon(Icons.search),
        ),

        decoration: InputDecoration.collapsed(hintText: "search..."),
      ),
    );
  }
}