import 'package:flutter/material.dart';
import 'package:intel/widgets/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:intel/models/item/itemcontroller.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';



class Sell extends StatefulWidget {
  @override
  _SellState createState() => _SellState();
}

class _SellState extends State<Sell> {

  File pickedImage;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final GlobalKey<FormFieldState<String>> nameKey = GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> priceKey = GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> descriptionKey = GlobalKey<FormFieldState<String>>();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,


      body: Container(
        margin: EdgeInsets.all(30.0),
        child: Form(
          key: _formKey,

          child: ListView(
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.only(top: 50.0),

            children: [
              Container(
                width: MediaQuery.of(context).size.width/4,
                height: MediaQuery.of(context).size.height/4,

                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: pickedImage == null ? AssetImage('assets/tealColor.jpg') : FileImage(pickedImage),
                    fit: BoxFit.fill
                  ),
                ),

                alignment: Alignment.center,
                child: IconButton(
                  icon: Icon(Icons.add_a_photo),color: Colors.white,iconSize: 30.0,
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.white,
                      builder: (BuildContext context){
                        return Container(
                          margin: EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              ListTile(
                                title: Text('Camera'),
                                trailing: Icon(Icons.camera,size: 20.0,color: Colors.white,),
                                onTap: () {
                                  pickImage(ImageSource.camera);
                                },
                              ),

                              ListTile(
                                title: Text('Gallery'),
                                trailing: Icon(Icons.photo_album,color: Colors.white,size: 20.0,),
                                onTap: () {
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
                margin: EdgeInsets.only(bottom: 33.0),
              ),
            field('Item Name', nameController, nameKey, TextInputType.text),
            field('Item Price', priceController, priceKey, TextInputType.number),
            field('Item Description', descriptionController, descriptionKey, TextInputType.text),

            Container(padding: EdgeInsets.only(top: 25.0)),

            Column(
              children: [
                ScopedModelDescendant<ItemController>(
                  builder: (context, child, ItemController item) {

                    return FlatButton(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                      color: Color(0xffE74C3C),
                      child: item.isProductLoading == true ? Center(child: Loading()) : Text('Add Item',style: TextStyle(
                        color: Colors.white,fontSize: 20.0,fontWeight: FontWeight.normal
                      ),),
                      

                      onPressed: () async {
                        if(_formKey.currentState.validate() ) {
                          bool _valid = await item.addItem(nameController.text, double.parse(priceController.text), descriptionController.text);
                          if(_valid == true){
                            return Scaffold.of(context).showSnackBar(snack('Item has been added sucessfully!'));
                          }
                          else{
                            return Scaffold.of(context).showSnackBar(snack('Error try again!'));
                          }
                        }
                        else{
                            return Scaffold.of(context).showSnackBar(snack('Some fields are required!')); 
                          }
                      },
                    );
                  },
                )
              ],
            )
            ],
          ),
        ),
      ),
    );
  }

  snack(String content){
    return SnackBar(
      content: Text(
        content, style: TextStyle(color: Colors.white,fontSize: 20.0,fontWeight: FontWeight.normal), 
      ),
      backgroundColor: Color(0xffE74C3C),
      duration: Duration(seconds: 3),
    );
  }


  field(String label,TextEditingController controller, Key key,TextInputType type) {
    return Container(
      margin: EdgeInsets.all(10.0),
      child: TextFormField(
        key: key,
        validator: (value) {
          if(value.isEmpty){
            return 'This field is required!';
          }
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(color: Colors.grey, width: 0.75),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(color: Color(0xff01848E), width: 0.75),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(color: Colors.red, width: 0.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(color: Color(0xff01848E), width: 1.5),
          ),
          labelText: label,
          labelStyle: TextStyle(color: Color(0xff01848E), fontSize: 13.3, fontFamily: 'Montserrat'),
        ),
        textInputAction: TextInputAction.done,
        controller: controller,
      ),
    );
  }

  pickImage(ImageSource source) async {
    var _pickedImage = await ImagePicker.pickImage(source: source);
    setState(() {
      pickedImage = _pickedImage;
    });
  }
}