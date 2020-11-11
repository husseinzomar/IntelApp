import 'package:intel/bottomnavbar/bottomBar.dart';
import 'package:intel/bottomnavbar/bottomnavbar.dart';
import 'package:intel/bottomnavbar/sign.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashscreen/splashscreen.dart';




class SplashScreens extends StatefulWidget {
  @override
  _SplashScreensState createState() => _SplashScreensState();
}

class _SplashScreensState extends State<SplashScreens> {

  String email;

  check() async{
    SharedPreferences _date = await SharedPreferences.getInstance();
    setState(() {
      email = _date.getString('email');
    });
  }

  @override
  void initState(){
    check();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 3,
      navigateAfterSeconds: email == null ? BottomBar() : Sing(),
      title: Text('Welcome', style: TextStyle(color: Colors.white,fontSize: 20.0),
      ),

      // image: Image.assets('assets/chair.jpg),
      photoSize: 100.0,


      backgroundColor: Color(0xffE74C3C),
      loaderColor: Colors.white, 
    );
  }
}