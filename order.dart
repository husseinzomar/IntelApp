import 'package:flutter/material.dart';
import 'package:intel/widgets/item.dart';
import 'package:scoped_model/scoped_model.dart';



class Order extends StatefulWidget {
  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<Order> with TickerProviderStateMixin {

  TabController tabController;

  @override
  void initState(){
    tabController = TabController(initialIndex: 0,length: 2, vsync: this);
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: Text(
          'Order', style: TextStyle(color:Colors.black54,fontSize: 20.0,fontWeight: FontWeight.bold),
        ),
        iconTheme: IconThemeData(color: Colors.black54,size: 20.0),
        bottom: PreferredSize(
          preferredSize: Size(0.0, 30.0),
          child: TabBar(
            tabs: [
              Text('Pervious'),Text('Current')
            ],
            controller: tabController,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black,width: 1.0),
            ),
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            labelStyle: TextStyle(fontSize: 15.0),
            unselectedLabelStyle: TextStyle(fontSize: 10.0),
          ),
        ),
      ),

      backgroundColor: Colors.grey[100],
      body: Container(
        child: TabBarView(
          controller: tabController,
          children: [
            Pervious(),
            Current(),
          ],
        ),
      ),
    );
  }
}




class Pervious extends StatefulWidget {
  @override
  _PerviousState createState() => _PerviousState();
}

class _PerviousState extends State<Pervious> {

  List<String> itemName = ['Chair', 'Lamp', 'Home', 'Office'];

  List<String> itemImage = ['assets/chair.jpg', 'assets/lamp.jpg', 'assets/home.jpg', 'assets/office.jpg'];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: itemName.length,
        itemBuilder: (context,index){
          return Item(itemImage[index], itemName[index], 'description', 'hdf', '!order', 200.0);
        },
      ),
    );
  }
}



class Current extends StatefulWidget {
  @override
  _CurrentState createState() => _CurrentState();
}

class _CurrentState extends State<Current> {

  List<String> itemName = ['Chair', 'Lamp', 'Home', 'Office'];

  List<String> itemImage = ['assets/chair.jpg', 'assets/lamp.jpg', 'assets/home.jpg', 'assets/office.jpg'];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: itemName.length,
        itemBuilder: (context,index){
          return Item(itemImage[index], itemName[index], 'description', 'hdf', '!order', 200.0);
        },
      ),
    );
  }
}