/*import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

import '../resources/colors/colors_resources.dart';
import '../resources/text/text.dart';

class PlacesSearch extends StatefulWidget {
  const PlacesSearch({Key? key}) : super(key: key);

  @override
  State<PlacesSearch> createState() => _PlacesSearchState();
}

class _PlacesSearchState extends State<PlacesSearch> {
  final _searchController = TextEditingController();
  var uuid = const Uuid();
  String _sessionToken = '122344';
  List<dynamic> _placesList = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      onChange();
    });
  }

  void onChange(){
    if(_sessionToken == null){
      setState(() {
        _sessionToken = uuid.v4();
      });
    }
  }

  getSuggestion(String input) async {
    String kPLACESAPIKEY = "AIzaSyBkbciwxjBPr8JEcG_059veVzuSLbf4n9Y";
    String baseURL ='https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request = '$baseURL?input=$input&key=$kPLACESAPIKEY&sessiontoken=$_sessionToken';
    var response = await http.get(Uri.parse(request));
    var data = response.body.toString();
    print(data);
    if(response.statusCode == 200){
      setState(() {
        _placesList = jsonDecode(response.body.toString())['predictions'];
      });
    }else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: TextFormField(
                controller: _searchController,
                obscureText: false,
                keyboardType: TextInputType.text,
                style: TextStyle(color: MyColors.brown),
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: MyColors.brown,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: MyColors.white),
                  ),
                  hintText: MyText.searchAddress,
                  prefixIcon: Icon(
                    CupertinoIcons.search,
                    color: MyColors.brown,
                  ),
                  hintStyle: TextStyle(color: MyColors.grey),
                ),
              ),
            ),
            Expanded(child: ListView.builder(
                itemCount: _placesList.length,
                itemBuilder: (context, index){
                  return ListTile(
                    title: Text(_placesList[index]['description']),
                  );
            }),),
          ],
        ),
      ),
    );
  }
}*/

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:provider/provider.dart';
import 'package:spice_shack/screens/products%20categories%20screen/providers/product_categories_provider.dart';

class PlacesSearch extends StatefulWidget {
  const PlacesSearch({Key? key}) : super(key: key);

  @override
  _PlacesSearchState createState() => _PlacesSearchState();
}

class _PlacesSearchState extends State<PlacesSearch> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProductCategoriesProvider>(
        builder: (context, valueProvider, child) {
      return Scaffold(
        backgroundColor: Colors.greenAccent.shade400,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Coordinates Points',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                valueProvider.location,
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'ADDRESS',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text('${valueProvider.Address}'),
              ElevatedButton(
                  onPressed: () async {
                    if (kDebugMode) {
                      print("Other Screen ----:- ");
                    }
                    valueProvider.position =
                        await valueProvider.getGeoLocationPosition(context);
                    valueProvider.location =
                        'Lat: ${valueProvider.position.latitude} , Long: ${valueProvider.position.longitude}';
                    valueProvider.getAddressFromLatLong(valueProvider.position);
                  },
                  child: Text('Get Location'))
            ],
          ),
        ),
      );
    });
  }
}
