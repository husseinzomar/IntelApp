import 'package:intel/bottomnavbar/profile/wishlist.dart';
import 'package:intel/bottomnavbar/sign.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intel/bottomnavbar/trackOrder.dart';
import 'package:flutter/material.dart';
import 'dart:io';


class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  File pickedImage;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color(0xffE74C3C),

        title: Text(
          'Profile',
          style: TextStyle(color: Colors.white,fontFamily: 'Montserrat'),
        ),
        centerTitle: true,

      ),

      backgroundColor: Colors.white,

      body: Container(
        margin: EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 0.0),

        child: ListView(
          scrollDirection: Axis.vertical,

          children: [
            Container(
              height: MediaQuery.of(context).size.height/6,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(bottom: 20.0),

              child: Row(
                children: [
                  Container(
                   width: MediaQuery.of(context).size.width/3,
                   margin: EdgeInsets.only(right: 15.0),

                   decoration: BoxDecoration(
                     image: DecorationImage(
                       image: AssetImage('assets/hussein.jpg'),
                       fit: BoxFit.fill
                     ),
                     shape: BoxShape.circle
                   ),
                   alignment: Alignment.center,

                   child: IconButton(
                     icon: Icon(Icons.add_a_photo),
                     color: Colors.white,

                     onPressed: (){
                       showModalBottomSheet(context: context, 
                       backgroundColor: Colors.white,
                       builder: (BuildContext context){
                         return Container(
                           margin: EdgeInsets.all(10.0),
                           child: Column(
                             children: [
                               ListTile(
                                 title: Text(
                                   'Camera',
                                 ),
                                 trailing: Icon(Icons.camera,color: Colors.black,size: 20.0,),
                                 onTap: (){
                                   pickImage(ImageSource.camera);
                                 },
                               ),
                               ListTile(
                                 title: Text(
                                   'Gallery'
                                 ),
                                 trailing: Icon(Icons.photo_album,color: Colors.black,size: 20.0,),
                                 onTap: (){
                                   pickImage(ImageSource.gallery);
                                 },
                               )
                             ],
                           ),
                         );
                       }
                       );
                     },
                   ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hussein Zomar',
                        style: TextStyle(
                          color: Color(0xffE74C3C),
                          fontSize: 19.0,
                          fontFamily: 'MontserratSemiBold'
                        ),
                      ),
                      Text(
                        'hussein6190@gmail.com',
                        style: TextStyle(
                          color: Color(0xffE74C3C),
                          fontSize: 14.5,
                          fontStyle: FontStyle.italic
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),


            item('Wishlist',Icons.favorite ,() {
              Navigator.push(context, MaterialPageRoute(builder: (_) {return Wishlist();}));
            } ),
            item('Order History',Icons.shopping_basket,() {
              Navigator.pushNamed(context, 'order');
            }),
            item('Tracking',Icons.delivery_dining,() {
              Navigator.push(context, MaterialPageRoute(builder: (_){return Map();}));
            }),
            item('Contact',Icons.mail,(){}),
            item('Settings', Icons.settings, () {}),
            item('LogOut', Icons.exit_to_app, () {
                Navigator.push(context, MaterialPageRoute(builder: (_) {return Sing();}));
              }),
          ],
        ),
      ),
    );
  }

  item(String title, IconData leading, Function onTop){
    return ListTile(
      title: Text(
        title, style: TextStyle(
          color: Color(0xffE74C3C),fontSize: 20.0,fontFamily: 'Montserrat'
        ),
      ),
      leading: Icon(
        leading,
        color: Color(0xffE74C3C),size: 20.0,
      ),
      trailing: title != 'LogOut' ? Icon(
        Icons.navigate_next,
        color: Colors.grey,
        size: 20.0,
      ): null,
      onTap: onTop,
    );
  }

  pickImage(ImageSource source) async {
    var _pickedImage = await ImagePicker.pickImage(source: source);
    setState(() {
      pickedImage = _pickedImage;
    });
  }
}