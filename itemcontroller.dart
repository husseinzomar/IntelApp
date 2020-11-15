import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intel/models/item/itemModel.dart';
import 'package:http/http.dart' as http;
import 'package:scoped_model/scoped_model.dart';
import 'dart:convert';


class ItemController extends Model{
  bool _isProductLoading = false;
  bool get isProductLoading => _isProductLoading;

  List<ItemModel> _allItems = [];
  List<ItemModel> get alliItems =>  _allItems;

  Future<bool> addItem(String itemName,double itemPrice, String itemDescription) async {
    _isProductLoading = true;
    notifyListeners();

    Map<String,dynamic> _newItem = {
      'itemName' : itemName,
      'itemPrice' : itemPrice,
      'itemDescription' : itemDescription
    };


    http.Response _response = await http.post('https://fashion-ec3a4.firebaseio.com/item.json', body: json.encode(_newItem));

    // print(_response.statusCode);
    // print(_response.body);

    if(_response.statusCode == 200){
      _isProductLoading = false;
      notifyListeners();
      return true;
    }else{
      _isProductLoading = false;
      notifyListeners();
      return false;
    }

    //Firestore.instance.collection('item').add(_newItem);

    // _isProductLoading = false;
    // notifyListeners();

  }


  Future<bool> getItems() async {

    _isProductLoading = true;
    notifyListeners();


    // Firestore.instance.collection('item').getDocuments().then((QuerySnapshot snapshot) {
    //   snapshot.documents.forEach((i) {
    //     final ItemModel _newItem = ItemModel(
    //       itemName : i['itemName'],
    //       itemPrice : i['itemPrice'],
    //       itemDescription : i['itemDescription']
    //     );
    //     _allItems.add(_newItem);
    //     _isProductLoading = false;
    //     notifyListeners();
    //   });
    // });

    http.Response _response = await http.get('https://fashion-ec3a4.firebaseio.com/item.json');

    var _convert = json.decode(_response.body);

    _convert.forEach((x , i) {
      final ItemModel _newItem = ItemModel(
          itemName : i['itemName'],
          itemPrice : i['itemPrice'],
          itemDescription : i['itemDescription']
        );
        _allItems.add(_newItem);
        _isProductLoading = false;
        notifyListeners();
    });
  }


  String _selectedItemId;
  String get selectedItemId => _selectedItemId;

  ItemModel get selectedItem{
    return _allItems.firstWhere((ItemModel item){
      return item.id == _selectedItemId;
    });
  }


  getSelectedItem(String id) {
    return _selectedItemId = id;
  }


  Future<bool> deleteItem(String id) async {

    _isProductLoading = true;
    notifyListeners();


    http.Response _response = await http.delete('https://newproject-aa1fd.firebaseio.com/item/$id');

    if(_response.statusCode == 200){
      _allItems.removeWhere((ItemModel item){
        return item.id == _selectedItemId;
      });
      _isProductLoading = false;
      notifyListeners();
      return true;
    }else{
      _isProductLoading = false;
      notifyListeners();
      return false;
    }
  }
    
  
}