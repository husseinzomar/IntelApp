import 'package:flutter/material.dart';


class Wishlist extends StatefulWidget {
  @override
  _WishlistState createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: Text(
          'Wishlist',
          style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold)
        ),
        iconTheme: IconThemeData(color: Colors.black, size: 20.0),
      ),
      backgroundColor: Colors.grey[100],
    );
  }
}