import 'dart:async';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:spice_shack/widgets/navigation%20bar/navigation_bar_widget.dart';
import '../../resources/colors/colors_resources.dart';
import '../../resources/colors/gradient_colors.dart';
import '../../resources/text/fonts.dart';
import '../../resources/text/text.dart';

class RestaurantScreen extends StatefulWidget {
  const RestaurantScreen({Key? key}) : super(key: key);

  @override
  State<RestaurantScreen> createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends State<RestaurantScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  static const CameraPosition _restaurant_1 = CameraPosition(
    target: LatLng(45.056060, -93.248280),
    zoom: 10,
  );
  static const CameraPosition _restaurant_2 = CameraPosition(
    target: LatLng(45.125200, -93.26289),
    zoom: 10,
  );
  static const CameraPosition _restaurant_3 = CameraPosition(
    target: LatLng(45.064550, -93.302630),
    zoom: 10,
  );
  static const CameraPosition _restaurant_4 = CameraPosition(
    target: LatLng(44.844210, -93.441960),
    zoom: 10,
  );

  final List<Marker> _marker_1 = [];
  final List<Marker> _list_1 = [
    const Marker(markerId: MarkerId("1"),
      position: LatLng(45.056060, -93.248280),
      infoWindow: InfoWindow(
        title: "Restaurant Location",
      ),
    ),
  ];
  final List<Marker> _marker_2 = [];
  final List<Marker> _list_2 = [
    const Marker(markerId: MarkerId("1"),
      position: LatLng(45.125200, -93.26289),
      infoWindow: InfoWindow(
        title: "Restaurant Location",
      ),
    ),
  ];
  final List<Marker> _marker_3 = [];
  final List<Marker> _list_3 = [
    const Marker(markerId: MarkerId("1"),
      position: LatLng(45.064550, -93.302630),
      infoWindow: InfoWindow(
        title: "Restaurant Location",
      ),
    ),
  ];
  final List<Marker> _marker_4 = [];
  final List<Marker> _list_4 = [
    const Marker(markerId: MarkerId("1"),
      position: LatLng(44.844210, -93.441960),
      infoWindow: InfoWindow(
        title: "Restaurant Location",
      ),
    ),
  ];


  @override
  void initState(){
    super.initState();
    _marker_1.addAll(_list_1);
    _marker_2.addAll(_list_2);
    _marker_3.addAll(_list_3);
    _marker_4.addAll(_list_4);
  }
  @override
  Widget build(BuildContext context) {
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
          child: Column(
            children: [
              appBarWidget(context),
              Expanded(
                flex: 10,
                child: CustomScrollView(
                  slivers: [
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 0.0),
                            child: Container(
                              decoration: const BoxDecoration(
                               color: Colors.transparent,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: MediaQuery.of(context).size.height * 0.05,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: MyColors.silver),
                                    gradient: LinearGradient(
                                      begin: Alignment.bottomRight,
                                      colors: [
                                        Colors.black.withOpacity(.4),
                                        Colors.black.withOpacity(.5),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: AutoSizeText(
                                      "4864 Northeast Central Avenue Hilltop Minnesota,United States – 55421",
                                      textAlign: TextAlign.center,
                                      style: AppTextStyle.spiceShackFonts(
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: MyColors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.3,
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => const NavigationBarWidget(),),);
                                },
                                child: Card(
                                  elevation: 8,
                                  color: MyColors.red,
                                  shadowColor: MyColors.yellow,
                                  shape: BeveledRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
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
                                        child: Align(
                                          alignment: Alignment.bottomRight,
                                          heightFactor: 0.3,
                                          widthFactor: 2.5,
                                          child: GoogleMap(
                                            mapType: MapType.terrain,
                                            initialCameraPosition: _restaurant_1,
                                            myLocationEnabled: true,
                                            compassEnabled: true,
                                            markers : Set<Marker>.of(_marker_1),
                                            onMapCreated: (
                                                GoogleMapController controller) {
                                              _controller.complete(controller);
                                            },
                                          ),
                                        ),),

                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 0.0),
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.transparent,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: MediaQuery.of(context).size.height * 0.05,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: MyColors.silver),
                                    gradient: LinearGradient(
                                      begin: Alignment.bottomRight,
                                      colors: [
                                        Colors.black.withOpacity(.4),
                                        Colors.black.withOpacity(.5),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: AutoSizeText(
                                      "398 Northtown Drive Northeast Blaine Minnesota,United States – 55434",
                                      textAlign: TextAlign.center,
                                      style: AppTextStyle.spiceShackFonts(
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: MyColors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.3,
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                elevation: 8,
                                color: MyColors.red,
                                shadowColor: MyColors.yellow,
                                shape: BeveledRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
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
                                      child: Align(
                                        alignment: Alignment.bottomRight,
                                        heightFactor: 0.3,
                                        widthFactor: 2.5,
                                        child: GoogleMap(
                                          mapType: MapType.normal,
                                          initialCameraPosition: _restaurant_2,
                                          myLocationEnabled: true,
                                          compassEnabled: true,
                                          markers : Set<Marker>.of(_marker_2),
                                          onMapCreated: (
                                              GoogleMapController controller) {
                                            _controller.complete(controller);
                                          },
                                        ),
                                      ),),

                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 0.0),
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.transparent,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: MediaQuery.of(context).size.height * 0.05,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: MyColors.silver),
                                    gradient: LinearGradient(
                                      begin: Alignment.bottomRight,
                                      colors: [
                                        Colors.black.withOpacity(.4),
                                        Colors.black.withOpacity(.5),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: AutoSizeText(
                                      "Minneapolis ,United States – MN 55430",
                                      textAlign: TextAlign.center,
                                      style: AppTextStyle.spiceShackFonts(
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: MyColors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.3,
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                elevation: 8,
                                color: MyColors.red,
                                shadowColor: MyColors.yellow,
                                shape: BeveledRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
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
                                      child: Align(
                                        alignment: Alignment.bottomRight,
                                        heightFactor: 0.3,
                                        widthFactor: 2.5,
                                        child: GoogleMap(
                                          mapType: MapType.terrain,
                                          initialCameraPosition: _restaurant_3,
                                          myLocationEnabled: true,
                                          compassEnabled: true,
                                          markers : Set<Marker>.of(_marker_3),
                                          onMapCreated: (
                                              GoogleMapController controller) {
                                            _controller.complete(controller);
                                          },
                                        ),
                                      ),),

                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 0.0),
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.transparent,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: MediaQuery.of(context).size.height * 0.05,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: MyColors.silver),
                                    gradient: LinearGradient(
                                      begin: Alignment.bottomRight,
                                      colors: [
                                        Colors.black.withOpacity(.4),
                                        Colors.black.withOpacity(.5),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: AutoSizeText(
                                      "8773 Columbine Road Eden Prairie Minnesota,United States – 55344",
                                      textAlign: TextAlign.center,
                                      style: AppTextStyle.spiceShackFonts(
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: MyColors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.3,
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                elevation: 8,
                                color: MyColors.red,
                                shadowColor: MyColors.yellow,
                                shape: BeveledRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
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
                                      child: Align(
                                        alignment: Alignment.bottomRight,
                                        heightFactor: 0.3,
                                        widthFactor: 2.5,
                                        child: GoogleMap(
                                          mapType: MapType.normal,
                                          initialCameraPosition: _restaurant_4,
                                          myLocationEnabled: true,
                                          compassEnabled: true,
                                          markers : Set<Marker>.of(_marker_4),
                                          onMapCreated: (
                                              GoogleMapController controller) {
                                            _controller.complete(controller);
                                          },
                                        ),
                                      ),),

                                  ),
                                ),
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget appBarWidget(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
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
            Padding(
              padding: EdgeInsets.only(right: 8.0.sp),
              child: IconButton(
                onPressed: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> const NavigationBarWidget(),),);
                },
                icon: Icon(
                  Icons.home_filled,
                  size: 3.h,
                  color: MyColors.silver,
                ),
              ),
            ),
            AutoSizeText(
              MyText.selectRestaurant,
              textAlign: TextAlign.start,
              style: AppTextStyle.spiceShackFonts(
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: MyColors.white,
                ),
              ),
            ),
            const SizedBox(width: 1,height: 1,),
          ],
        ),
      ),
    );
  }
}
