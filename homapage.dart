import 'package:intel/models/item/itemcontroller.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:floating_search_bar/floating_search_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:io' show Platform;
import 'package:intel/bottomnavbar/shoppingcart.dart';
import 'package:intel/bottomnavbar/seeAll.dart';
import 'package:intel/widgets/loading.dart';
import 'package:intel/widgets/item.dart';





class HomePage extends StatefulWidget {

  final ItemController item;
  HomePage(this.item);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<String>categoryName = ['Man','Woman','Devices','Gadgets','Gaming'];
  List<String>bastSellName = ['Beo Speker','Wristwatch','Lamp','Office'];
  List<String>bastSellImage = ['assets/speaker.png','assets/watch.png','assets/lamp.jpg','assets/chair.jpg'];
  List<String>bestSellingDesc = ['Ban&olu', 'Make Wrist, Smart','Office Lamp','Full office'];
  List<double> bestSellingPrice=[199.9, 499.9, 99.9, 2000.0];
  List<String>itemIcons = ['assets/men.png', 'assets/women.png', 'assets/devices.png', 'assets/gadgets.png', 'assets/gaming.png'];
  List<String>itemPics = ['assets/speaker.png','assets/watch.png'];
  List<String>newArrialName = ['Home','Lamp','Chair','Office',];
  List<String>newArrialImage = ['assets/home.jpg','assets/lamp.jpg','assets/chair.jpg','assets/office.jpg'];


  @override
  void iniState(){
    widget.item.getItems();
    super.initState();
  }

    File pickedImage;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: ListView(
          padding: EdgeInsets.only(top: 40.0),

          scrollDirection: Axis.vertical,

          children: [
            ListTile(
              //starting search bar 
              title: Container(
                padding: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 10.0),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(50.0),
                ),

                alignment: Alignment.centerLeft,
                child: Icon(
                  Icons.search,
                  color: Color(0xffE74C3C),
                  size: 22.0,
                ),
              ),

              // drawing the circle behind cameraicon
              trailing: DecoratedBox(
                decoration: BoxDecoration(
                  color: Color(0xffE74C3C),
                  shape: BoxShape.circle,// draw circle
                ),

                  child: IconButton(
                    icon: Icon(
                      Icons.camera_alt,
                      size: 20.0,
                    ),
                    onPressed: (){
                      showModalBottomSheet(
                        context: context,
                        backgroundColor: Colors.white,
                        builder: (BuildContext context){

                          return Container(
                            margin: EdgeInsets.all(10.0),
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,

                            child: Column(
                              children: [
                                ListTile(
                                  title: Text(
                                    'Camera',
                                    style: TextStyle(color: Color(0xffE74C3C),
                                    fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  trailing: Icon(Icons.camera_alt,color: Color(0xffE74C3C),size: 20.0,),
                                  onTap: (){
                                    pickImage(ImageSource.gallery);
                                  }
                                )
                              ],
                            ),
                          );
                        }
                      );
                    },
                  ), 
                ),
            ),
            //end of the saerch bar 

            ListTile(
              title: Text(
                'Categories',
                style: TextStyle(
                  color: Color(0xffE74C3C),
                  fontSize: 20.0,
                  fontFamily: 'MontserratSemiBold'
                ),
              ),
              trailing: Text(
                'See All',
                style: TextStyle(
                  color: Color(0xffE74C3C),
                  fontSize: 15.0,
                  fontWeight: FontWeight.normal
                ),
              ),
            ),
            //categories icons 

            Container(
              height: 67.0,
              child: ListView.builder(//important
                scrollDirection: Axis.horizontal,
                itemCount: itemIcons.length,
                itemBuilder: (context, index) {
                  return Container(
                     width: 80.0,
                     child: ListTile(
                       title: Image.asset(itemIcons[index]),
                       subtitle: Text(
                         categoryName[index],
                         textAlign: TextAlign.center,
                         style: TextStyle(
                           color: Color(0xffE74C3C),
                           fontSize: 11.2,
                           fontFamily: 'Montserrat'
                         ),
                       ),
                     ),
                  );
                },
              ),
            ),


            ListTile(
              title: Text(
                'Bast Selling',
                style: TextStyle(
                  color: Color(0xffE74C3C),
                  fontSize: 20.0,
                  fontFamily : 'MontserratSemiBold'
                ),
              ),
              trailing: Text(
                'See All',
                style: TextStyle(
                  color: Color(0xffE74C3C),
                  fontSize: 15.0,
                  fontFamily: 'MontserratSemiBold',
                ),
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) {return SearchResult('Best Selling');}));
              },
            ),


            Container(
              height: MediaQuery.of(context).size.height/2.6,
              child: bastSellingItem(),
            ),

            ListTile(
              title: Text(
                'Featured Brands',
                style: TextStyle(color: Color(0xffE74C3C),
                  fontSize: 20.0,
                    fontFamily: 'MontserratSemiBold'
                ),
              ),
            ),
           
           Container(
             height: 50.0,
             decoration: BoxDecoration(
               image: DecorationImage(
                 image: AssetImage('assets/brands.png'),
                 fit: BoxFit.cover
               ),
             ),
           ),


           Container(
             margin: EdgeInsets.only(top: 20.0),
             height: 200.0,
             decoration: BoxDecoration(
               image: DecorationImage(
                 image: AssetImage('assets/mobheader.png')
               )
             ),
           ),

           Container(
             padding: EdgeInsets.only(top: 20.0),
           ),


           ListTile(
             title: Text(
               'Recommended',
               style: TextStyle(
                 color: Color(0xffE74C3C),
                 fontSize: 20.0,
                 fontFamily: 'MontserratSemiBold'
               ),
             ),
             trailing: Text(
               'See All',
               style: TextStyle(
                 color: Color(0xffE74C3C),
                 fontSize: 15.0,
                 fontWeight: FontWeight.normal
               ),
             ),
             onTap: (){
               Navigator.push(context, MaterialPageRoute(builder: (_) {return SearchResult('New Arrival');}));
             },
           ),


           Row(children: [
             Container(
               margin: EdgeInsets.fromLTRB(15, 0, 15, 10),
               height: MediaQuery.of(context).size.height/3,
               width: MediaQuery.of(context).size.width/2.3,

               decoration: BoxDecoration(
                 image: DecorationImage(
                   image: AssetImage('hussein.jpg'),
                   fit: BoxFit.cover 
                   ),
                   borderRadius: BorderRadius.circular(7.5),
               ),
             ),


             Container(
               margin: EdgeInsets.fromLTRB(0, 0, 15, 10),
               height: MediaQuery.of(context).size.height/3,
               width: MediaQuery.of(context).size.width/2.3,

               decoration: BoxDecoration(
                 image: DecorationImage(
                   image: AssetImage('pp.jpg'),
                   fit: BoxFit.cover 
                   ),
                   borderRadius: BorderRadius.circular(7.5),
               ),
             )
           ]
           ),



            ListTile(
                title: Text('Best Sellings',
                  style: TextStyle(color: Color(0xff007386),
                    fontSize: 20.0, fontFamily: 'MontserratSemiBold',),
                ),
                trailing: Text('See All',
                  style: TextStyle(color: Color(0xff007386), fontSize: 15.0, fontWeight: FontWeight.normal),
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {return SearchResult('New Arrival');}));
                },
              ),

              Container(
                height: MediaQuery.of(context).size.height/2.4,
                child:homaPageItem(false) ,
              )
          ],
        ),
      ),
    );
  }
  homaPageItem(bool isBestSelling){


    return ScopedModelDescendant<ItemController>(
      builder: (context,child, ItemController item){
       if(item.isProductLoading == true){
            return Center(child: Loading());
          }else if(item.allItems.length < 1){
            return Center(child: Text('No items found.'));
          }else{
            return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: item.allItems.length,
                itemBuilder: (context, index){
                  return Item(
                      bastSellImage[index],
                      item.allItems[index].itemName,
                      item.allItems[index].itemDescription,
                      item.allItems[index].itemPrice,
                      '!order',
                      item.allItems[index].id
                  );
                }
            );
          }
        }
          );
        }
     bastSellingItem(){
       return ListView.builder(
         scrollDirection: Axis.horizontal,

         itemCount: bastSellName.length,
         itemBuilder: (context, index){
           return Item(bastSellImage[index],bastSellName[index],bestSellingDesc[index],'hdf','order',bestSellingPrice[index]);
         },
       );
     }

     newArrivalItem(){
       return ListView.builder(
         scrollDirection: Axis.horizontal,

         itemCount: newArrialName.length,
         itemBuilder: (context,index){
           return Item(newArrialImage[index],newArrialName[index],'description', 'hdf','!order',200.0);
         },
       );
     }
      
  pickImage(ImageSource source)async{
    var _pickedImage = await ImagePicker.pickImage(source: source);
    setState(() {
      pickedImage = _pickedImage;
  });
 }
} 
