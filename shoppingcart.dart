import 'package:intel/responsive/responsiveHomePage.dart';
import 'package:intel/widgets/item.dart';
import 'package:intel/material.dart';




class ShoppingCart extends StatefulWidget {
  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {

List<String> itemName = ['Chair', 'Lamp', 'Home', 'Office'];

List<String> itemImage = ['assets/chair.jpg', 'assets/lamp.jpg', 'assets/home.jpg', 'assets/office.jpg'];

  @override
  Widget build(BuildContext context) {
    var data = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: Text(
          'Basket',
          style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold)
        ),
      ),
      backgroundColor: Colors.grey[100],
      body: Container(
        margin: EdgeInsets.all(5.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 5.0,
            childAspectRatio: responsiveGridViewItem(data)
          ),
          scrollDirection: Axis.vertical,
          itemCount: itemName.length,
          itemBuilder: (context, index){
            return Item(itemImage[index], itemName[index], 'description', 200.0, '!order', 'hdf');
          },
        ),
      ),
    );
  }
}
