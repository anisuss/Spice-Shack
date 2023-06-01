import 'dart:async';
import 'dart:collection';
import 'dart:ui' as ui;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../resources/colors/colors_resources.dart';
import '../../resources/colors/gradient_colors.dart';
import '../../resources/text/fonts.dart';
import '../map.dart';


class CarSideToGo extends StatefulWidget {
  const CarSideToGo({Key? key}) : super(key: key);

  @override
  State<CarSideToGo> createState() => _CarSideToGoState();
}

class _CarSideToGoState extends State<CarSideToGo> {
  final Completer<GoogleMapController> _controller = Completer();
  final Set<Polyline> _polylines = HashSet<Polyline>();
  static const CameraPosition _jinnahHospital = CameraPosition(
    target: LatLng(31.48462325, 74.29710848648166),
    zoom: 12,
  );

  //final List<Marker> _marker = [];
  Uint8List? markerImage;
  List<String> image = ['assets/images/logo/person.png'];

  List<LatLng> latlng = [
    const LatLng(31.48462325, 74.29710848648166),
    const LatLng(31.4611568, 74.2731373),
  ];



  final List<Marker> _marker = <Marker>[
    const Marker(
      markerId: MarkerId("1"),
      // icon: Icon(Icons.location_history),
      position: LatLng(31.48462325, 74.29710848648166),
      infoWindow: InfoWindow(
        title: "Current Position",
      ),
    ),

  ];


  Future<Uint8List> getBytesFromAssets(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),targetHeight: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }


  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) {
    });
    return await Geolocator.getCurrentPosition();
  }


  loadData() async {

    for(int i=0;i<image.length;i++){
      final Uint8List markerIcon = await getBytesFromAssets(image[i], 100);
      getUserCurrentLocation().then((value) async {
        _marker.add(
          Marker(
            markerId: const MarkerId("2"),
            icon: BitmapDescriptor.fromBytes(markerIcon),
            position: LatLng(value.latitude, value.longitude),
            infoWindow: const InfoWindow(
              title: "User Current Location",
            ),
          ),
        );
        CameraPosition cameraPosition = CameraPosition(
          zoom: 12,
          target: LatLng(value.latitude, value.longitude),
        );
        final GoogleMapController controller = await _controller.future;
        controller.animateCamera(
          CameraUpdate.newCameraPosition(cameraPosition),
        );
      });

    }

    setState(() {});
  }
  @override
  void initState() {
    super.initState();
    _polylines.add(
      Polyline(polylineId: const PolylineId('1'),
        points: latlng,
        color: Colors.red.shade100,
        geodesic: true,
      ),
    );
    loadData();

    //_marker.addAll(_list);
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
                child: Column(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
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
                                child: Align(
                                  alignment: Alignment.bottomRight,
                                  heightFactor: 0.3,
                                  widthFactor: 2.5,
                                  child: Stack(
                                    children: [
                                      GoogleMap(
                                        mapType: MapType.terrain,
                                        initialCameraPosition: _jinnahHospital,
                                        myLocationEnabled: true,
                                        polylines: _polylines,
                                        compassEnabled: true,
                                        markers: Set<Marker>.of(_marker),
                                        onMapCreated:
                                            (GoogleMapController controller) {
                                          _controller.complete(controller);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
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
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const PlacesSearch(),
                                ),
                              );
                            },
                            child: AutoSizeText(
                              "Confirm Order",
                              textAlign: TextAlign.center,
                              style: AppTextStyle.spiceShackFonts(
                                style: TextStyle(
                                  fontSize: 18,
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
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.location_on_outlined),
        onPressed: () async {},
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
            InkWell(
              onTap: () {
                Navigator.pop(context);
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
              "Car Side to Go",
              textAlign: TextAlign.start,
              style: AppTextStyle.spiceShackFonts(
                style: TextStyle(
                  fontSize: 24,
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
      ),
    );
  }
}
