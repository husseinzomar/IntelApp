import 'package:flutter/material.dart';
import 'package:intel/models/item/itemcontroller.dart';
import 'package:scoped_model/scoped_model.dart';



class Item extends StatefulWidget {
  //Final to make no change 

  final String className;
  final String itemImage;
  final String itemName;
  final String description;
  final double price;
  final String id;

  Item(this.className,this.description,this.id,this.itemImage,this.itemName,this.price);

  @override
  _ItemState createState() => _ItemState();
}

class _ItemState extends State<Item> {

  //to move between pages by Bottom Bar
  bool pressed = false;


  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ItemController>(
      builder: (context,child , ItemController item){
        return InkWell(
          onLongPress: () {
            item.getSelectedItem(widget.id);
            item.deleteItem(item.selectedItemId);
          },

          child: Container(
            height: widget.className == 'order' ? MediaQuery.of(context).size.height/2.2 : null,
            width: MediaQuery.of(context).size.width/2.4,
            margin: EdgeInsets.fromLTRB(15.0, 5.0, 0.0, 5.0),


            child: Column(
              children: [
                Container(
                  height: 200.0,

                  //Drawing the pic 

                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(widget.itemImage),
                      fit: BoxFit.fill
                    )
                  ),

                  //Favorite Icons

                  alignment: Alignment.topRight,
                  child: IconButton(
                    color: Colors.red,iconSize: 20.0,


                    // To change icon when pressed
                    icon: Icon(pressed == false ? Icons.favorite_border: Icons.favorite),
                    onPressed: () {
                      setState(() {
                        pressed == !pressed;
                      });
                    },
                  ),
                ),


                //Title, Cost and Subtitle under the pictures
                ListTile(
                  title: Text(widget.itemName,
                  style: TextStyle(
                    color: Color(0xffE74C3C),
                    fontSize: 16.0,
                    fontFamily: 'MontserratSemiBold'
                  ),
                 ),

                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.description, textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey, fontSize: 12.0
                        ),
                      ),

                      Text(widget.price.toString()+'\$', textAlign: TextAlign.center,
                      style: TextStyle(color: Color(0xffE74C3C),fontSize: 16.0,fontFamily: 'MontserratSemiBold'),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}