import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:spice_shack/screens/guest%20detail/guest_detail.dart';
import 'package:spice_shack/screens/home%20screen/home_screen.dart';
import 'package:spice_shack/widgets/navigation%20bar/navigation_bar_widget.dart';

import '../../cart data/model/cart_model.dart';
import '../../resources/colors/colors_resources.dart';
import '../../resources/colors/gradient_colors.dart';
import '../../resources/text/fonts.dart';
import '../../resources/text/text.dart';
import '../../widgets/input text fields/input_text_field.dart';
import '../checkOut screen/checkOut_screen.dart';
import '../checkOut screen/model places api/prediction_auto_complete_places.dart';
import '../checkOut screen/model places api/prediction_model.dart';
import '../map.dart';
import '../products APi Functions/products_Functions_api.dart';
import '../products categories screen/providers/product_categories_provider.dart';

class DeliveryScreen extends StatefulWidget {
  const DeliveryScreen({Key? key}) : super(key: key);

  @override
  State<DeliveryScreen> createState() => _DeliveryScreenState();
}

String _addressData = "";

String get addressData => _addressData;

String _phoneNumber = "";

String get phoneNumber => _phoneNumber;

class _DeliveryScreenState extends State<DeliveryScreen> {
  set addressData(String value) {
    _addressData = value;
  }

  set phoneNumber(String value) {
    _phoneNumber = value;
  }

  final searchController = TextEditingController();
  static const CameraPosition downTown = CameraPosition(
    target: LatLng(39.28989, -76.6095443),
    zoom: 14,
  );

  //final List<Marker> _marker = [];
  // Uint8List? markerImage;
  List<String> image = ['assets/images/logo/person.png'];

  final String apiKey = "AIzaSyBkbciwxjBPr8JEcG_059veVzuSLbf4n9Y";

  List<AutoCompletePrediction> placePredictions = [];

  Future<void> placesAutoComplete(String query) async {
    Uri uriPlaces =
        Uri.https("maps.googleapis.com", 'maps/api/place/autocomplete/json', {
      "input": query,
      "key": apiKey,
    });
    String? response = await ProductsFunctionsApi.fetchUrl(uriPlaces);
    if (response != null) {
      if (kDebugMode) {
        print("Places Response :- Is Empty -- ${response.toString()}");
      }
      PlacesAutoCompleteResponse result =
          PlacesAutoCompleteResponse.parseAutoCompleteResult(response);
      if (result.predictions != null) {
        setState(() {
          placePredictions = result.predictions!;
        });
      }
    }
  }

  final List<Marker> marker = <Marker>[
    const Marker(
      markerId: MarkerId("1"),
      // icon: Icon(Icons.location_history),
      position: LatLng(39.28989, -76.6095443),
      infoWindow: InfoWindow(
        title: "Restaurant Location",
      ),
    ),
  ];

  Future<Uint8List> getBytesFromAssets(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetHeight: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) {
      print("Error $error");
    });
    return await Geolocator.getCurrentPosition();
  }

  @override
  void initState() {
    super.initState();
    // loadData();

    //_marker.addAll(_list);
  }

  List<Cart> cart = [];

  @override
  Widget build(BuildContext context) {
    LocationPermission permission;

    return Consumer<ProductCategoriesProvider>(
        builder: (context, valueProvider, child) {
      return Scaffold(
        body: Container(
          constraints: const BoxConstraints.expand(),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/images/backgrounds/app.jpg',
              ),
              fit: BoxFit.fill,
            ),
          ),
          child: Padding(
            padding: MediaQuery.of(context).padding,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  appBarWidget(context),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 1,
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: Card(
                      elevation: 8,
                      color: MyColors.red,
                      shadowColor: MyColors.yellow,
                      shape: BeveledRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            //gradient: GradientsConstants.goldGradient,
                            color: MyColors.grey,
                          ),
                          height: MediaQuery.of(context).size.height * 0.1,
                          width: double.infinity,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                              bottomRight: Radius.circular(15),
                              bottomLeft: Radius.circular(15),
                            ),
                            child: GoogleMap(
                              mapType: MapType.terrain,
                              initialCameraPosition: downTown,
                              myLocationEnabled: true,
                              compassEnabled: true,
                              markers: Set<Marker>.of(marker),
                              onMapCreated: (GoogleMapController controller) {
                                valueProvider.mapController
                                    .complete(controller);
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 6.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: GradientsConstants.redGradient,
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(width: 1, color: MyColors.silver),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 0.0,
                          horizontal: 100,
                        ),
                        child: TextButton(
                          onPressed: () async {
                            addressData = valueProvider.Address.toString();
                            if (valueProvider.temp.email == "" &&
                                valueProvider.stateEmail == "") {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const GuestDetailScreen(),
                                ),
                              );
                            } else {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Dialog(
                                      backgroundColor: Colors.transparent,
                                      child: Container(
                                        height: 40.h,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          border: Border.all(
                                              width: 2, color: MyColors.brown),
                                          color: MyColors.silver,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            AutoSizeText(
                                              "Enter Your Phone Number",
                                              textAlign: TextAlign.start,
                                              style:
                                                  AppTextStyle.spiceShackFonts(
                                                style: TextStyle(
                                                  fontSize: 13.sp,
                                                  fontWeight: FontWeight.w600,
                                                  color: MyColors.red,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: TextFormField(
                                                style: TextStyle(
                                                    color: MyColors.black),
                                                obscureText: false,
                                                decoration: InputDecoration(
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25),
                                                    borderSide: BorderSide(
                                                      color: MyColors.brown,
                                                    ),
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25),
                                                    borderSide: BorderSide(
                                                        color: MyColors.red),
                                                  ),
                                                  hintText: MyText.phoneNumber,
                                                  prefixIcon: Icon(
                                                    CupertinoIcons.phone,
                                                    color: MyColors.brown,
                                                  ),
                                                  hintStyle: TextStyle(
                                                      color: MyColors.black),
                                                ),
                                                keyboardType:
                                                    TextInputType.number,
                                                controller:
                                                    valueProvider.phoneControll,
                                                onFieldSubmitted: (value) {
                                                  //Validator
                                                },
                                                validator: (value) {
                                                  if (value == null) {
                                                    return 'Enter a valid password!';
                                                  }
                                                  return null;
                                                },
                                              ),
                                            ),
                                            ElevatedButton(
                                              onPressed: () async {
                                                if (valueProvider.phoneControll
                                                    .text.isNotEmpty) {
                                                  phoneNumber = valueProvider.phoneControll.text;
                                                  //phoneNumber = '040040304';
                                                  if (kDebugMode) {
                                                    print("------->>>> $cart");
                                                  }
                                                  permission = await Geolocator.checkPermission();
                                                  if(permission == LocationPermission.denied)
                                                    {
                                                      Navigator.pop(context);
                                                    }else{
                                                    Navigator.pushReplacement(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                        const CheckOutScreen(),
                                                      ),
                                                    );
                                                  }
                                                }
                                              },
                                              child: AutoSizeText(
                                                "Continue",
                                                textAlign: TextAlign.start,
                                                style: AppTextStyle
                                                    .spiceShackFonts(
                                                  style: TextStyle(
                                                    fontSize: 10.sp,
                                                    fontWeight: FontWeight.w600,
                                                    color: MyColors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                            }
                            if (kDebugMode) {
                              print("Delivery Screen ----:- ");
                            }
                          },
                          child: AutoSizeText(
                            "Confirm Order",
                            textAlign: TextAlign.center,
                            style: AppTextStyle.spiceShackFonts(
                              style: TextStyle(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w800,
                                color: MyColors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget appBarWidget(BuildContext context) {
    return Container(
      height: 8.h,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: GradientsConstants.redGradient,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: () {
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                  const NavigationBarWidget(),), (Route<dynamic> route) => false);
            },
            child: Icon(
              Icons.highlight_remove_rounded,
              color: MyColors.white,
              size: MediaQuery.of(context).size.width * 0.08,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          AutoSizeText(
            MyText.deliveryTo,
            textAlign: TextAlign.start,
            style: AppTextStyle.spiceShackFonts(
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: MyColors.white,
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }

  Widget checkStatus(bool val) {
    return const SizedBox();
  }
}
