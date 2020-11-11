import 'dart:html';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';





class Map extends StatefulWidget {
  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {

  final TextEditingController searchController = TextEditingController();

  Position position;
  bool isMapLoading = false;

  List<Marker> markers = [];

  @override
  void initState() {
    getLocation();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: field('Current location',Icons.location_on, searchController),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Color(0xffE74C3C),size: 20.0),
        elevation: 0.0,
      ),

      body: isMapLoading == true ? Center(child: CircularProgressIndicator(backgroundColor: Colors.black,)) : map(),
    );
  }

  Future getLocation() async{
    setState(() {
      isMapLoading = true;
    });

    bool _enabled = await Geolocator().isLocationServiceEnabled();

    if(_enabled == false) {
      setState(() {
        isMapLoading = false;
      });
      return Text('location service is disabled\n kindly enable it');
    }


    else if (searchController.text.isNotEmpty){
      List<Placemark> _search = await Geolocator().placemarkFromAddress(searchController.text);
     final Marker _newMarkers = Marker(markerId: MarkerId(_search[0].name),position: LatLng(
       _search[0].position.latitude,_search[0].position.longitude 
     ),
        icon: BitmapDescriptor.defaultMarker
     );

     setState(() {
       markers.add(_newMarkers);
       isMapLoading = false;
     });
    }

    else {
      var _current = await Geolocator().getCurrentPosition();
      setState(() {
        position = _current;
        isMapLoading = false;
      });
    }
  }

  map() {
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        zoom: 12,
        target: LatLng(position.latitude, position.longitude),
      ),
      myLocationButtonEnabled: true,
      myLocationEnabled: true,
      markers: Set.from(markers),
    );
  }


  field(String label, IconData icon,TextEditingController controller) {
    return Container(
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(color: Colors.white,width: 0.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(color: Colors.white,width: 0.0)
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(color: Colors.white,width: 0.0),
          ),
          labelText: label,
          labelStyle: TextStyle(color: Color(0xffE74C3C),fontSize: 15.0),
          prefixIcon: Icon(icon,color: Color(0xffE74C3C),size: 20.0,),
        ),
        textInputAction: TextInputAction.search,
        controller: controller,
        onSubmitted: (value){
          getLocation();
        },
      ),
    );
  }
}



