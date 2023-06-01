import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:spice_shack/resources/colors/gradient_colors.dart';
import 'package:spice_shack/screens/checkOut%20screen/model%20places%20api/prediction_auto_complete_places.dart';
import '../../resources/colors/colors_resources.dart';
import '../../resources/text/fonts.dart';
import '../cart screen/cart_screen.dart';
import '../coupons data/coupons_data_model.dart';
import '../delivery screen/delivery_screen.dart';
import '../gift card screen/gift card.dart';
import '../place order screen/place_order_screen.dart';
import '../products APi Functions/products_Functions_api.dart';
import '../products categories screen/providers/product_categories_provider.dart';
import 'model places api/prediction_model.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({Key? key}) : super(key: key);

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}
String _codeGiftCard = '';
String get  codeGiftCard  => _codeGiftCard ;

class _CheckOutScreenState extends State<CheckOutScreen> {

  set codeGiftCard (String value) {
    _codeGiftCard  = value;
  }
  bool loading = false;
  bool isBack = false;
  final searchController = TextEditingController();
  final promoController = TextEditingController();
  final String apiKey = "AIzaSyBkbciwxjBPr8JEcG_059veVzuSLbf4n9Y";
  String billTotal = '';
  String billTotalCoupon = '';
  int responseCode = 0;
  String order = "";

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


  // bool _isPay = false;
  // int _payCount = 0;

  // bool _isApply = false;
  // int _applyCount = 0;
  //
  // void _toggleApply() {
  //   setState(() {
  //     _isApply = !_isApply;
  //     _applyCount += _isApply ? 1 : -1;
  //   });
  // }



  // void _togglePay() {
  //   setState(() {
  //     _isPay = !_isPay;
  //     _payCount += _isPay ? 1 : -1;
  //     if (_payCount == 1) {
  //       _likeCount = 0;
  //       _isLiked = false;
  //     }
  //   });
  // }

  void onButtonClick() {
    setState(() {
      int value;
      double tenPercent = double.parse(billTotal) * 0.2;
      tenPercent = double.parse(billTotal) - tenPercent;
      value = tenPercent.toInt();
      billTotalCoupon = value.toString();
      print(billTotalCoupon);
    });
  }
  Map<String, dynamic>? paymentIntentData;



  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<ProductCategoriesProvider>(context);

    Map<String, String> someMap = {
      "first_name": profileName,
      "last_name": "",
      "company": "Spice Shack",
      "address_1": addressData,
      "address_2": addressData,
      "email": profileEmail,
      "country": "USA",
      "phone": phoneNumber,
    };
    Map<String, String> address = {
      "first_name": profileName,
      "last_name": "",
      "company": "Spice Shack",
      "address_1": addressData,
      "address_2": addressData,
      "phone": phoneNumber,
    };
    List movement = [
      for(int i=0;i<cart.cart.length;i++){

        "product_id": cart.idGrowableList[i],
        "quantity": cart.quantityList[i],

        if(cart.cart[i].varData.toString().isNotEmpty)
          "variation_id": cart.cart[i].varData.toString(),
        if(cart.cart[i].productId.toString() == '6097')
          "meta_data": [
            {
              "key": cart.apIR1,
              "value": cart.apIR1Value,
            },
            {
              "key": cart.e1R1,
              "value": cart.e1R1Value,
            },
            {
              "key": cart.e2R1,
              "value": cart.e2R1Value,
            },
            {
              "key": cart.c1R1,
              "value": cart.c1R1Value,
            },
            {
              "key": cart.dessertsR1,
              "value": cart.dessertsR1Value,
            },
            {
              "key": cart.plateAddOnsR1Check,
              "value": cart.plateQuantityR1Check,
            },
            {
              "key": cart.bottleAddOnsR1Check,
              "value": cart.bottleQuantityR1Check,
            },
            {
              "key": cart.mangoAddOnsR1Check,
              "value": cart.mangoQuantityR1Check,
            },
            {
              "key": cart.naanAddOnsR1Check,
              "value": cart.naanQuantityR1Check,
            },
          ],
        if(cart.cart[i].productId.toString() == '6103')
          "meta_data": [
            {
              "key": cart.apIR2,
              "value": cart.apIR2Value,
            },
            {
              "key": cart.e1R2,
              "value": cart.e1R2Value,
            },
            {
              "key": cart.e2R2,
              "value": cart.e2R2Value,
            },
            {
              "key": cart.e3R2,
              "value": cart.e3R2Value,
            },
            {
              "key": cart.breadR2,
              "value": cart.breadR2Value,
            },
            {
              "key": cart.c1R2,
              "value": cart.c1R2Value,
            },
            {
              "key": cart.c2R2,
              "value": cart.c2R2Value,
            },
            {
              "key": cart.dessertsR2,
              "value": cart.dessertsR2Value,
            },
            {
              "key": cart.plateAddOnsR2Check,
              "value": cart.plateQuantityR2Check,
            },
            {
              "key": cart.bottleAddOnsR2Check,
              "value": cart.bottleQuantityR2Check,
            },
            {
              "key": cart.mangoAddOnsR2Check,
              "value": cart.mangoQuantityR2Check,
            },
            {
              "key": cart.naanAddOnsR2Check,
              "value": cart.naanQuantityR2Check,
            },


            // {  //"id": 3060,
            //   "key": "Spoon, Fork, Napkins (0.25)",
            //   "value": "1",
            //
            // },
          ],
        if(cart.cart[i].productId.toString() == '6104')
          "meta_data": [
            {
              "key": cart.apIR3,
              "value": cart.apIR3Value,
            },
            {
              "key": cart.apIIR3,
              "value": cart.apIIR3Value,
            },
            {
              "key": cart.e1R3,
              "value": cart.e1R3Value,
            },
            {
              "key": cart.e2R3,
              "value": cart.e2R3Value,
            },
            {
              "key": cart.e3R3,
              "value": cart.e3R3Value,
            },
            {
              "key": cart.breadR3,
              "value": cart.breadR3Value,
            },
            {
              "key": cart.c1R3,
              "value": cart.c1R3Value,
            },
            {
              "key": cart.c2R3,
              "value": cart.c2R3Value,
            },
            {
              "key": cart.dessertsR3,
              "value": cart.dessertsR3Value,
            },
            {
              "key": cart.plateAddOnsR3Check,
              "value": cart.plateQuantityR3Check,
            },
            {
              "key": cart.bottleAddOnsR3Check,
              "value": cart.bottleQuantityR3Check,
            },
            {
              "key": cart.mangoAddOnsR3Check,
              "value": cart.mangoQuantityR3Check,
            },
            {
              "key": cart.naanAddOnsR3Check,
              "value": cart.naanQuantityR3Check,
            },


            // {  //"id": 3060,
            //   "key": "Spoon, Fork, Napkins (0.25)",
            //   "value": "1",
            //
            // },
          ],
        if(cart.cart[i].productId.toString() == '6108')
          "meta_data": [
            {
              "key": cart.apIR4,
              "value": cart.apIR4Value,
            },
            {
              "key": cart.apIIR4,
              "value": cart.apIIR4Value,
            },
            {
              "key": cart.e1R4,
              "value": cart.e1R4Value,
            },
            {
              "key": cart.e2R4,
              "value": cart.e2R4Value,
            },
            {
              "key": cart.e3R4,
              "value": cart.e3R4Value,
            },
            {
              "key": cart.breadR4,
              "value": cart.breadR4Value,
            },
            {
              "key": cart.c1R4,
              "value": cart.c1R4Value,
            },
            {
              "key": cart.c2R4,
              "value": cart.c2R4Value,
            },
            {
              "key": cart.dessertsR4,
              "value": cart.dessertsR4Value,
            },
            {
              "key": cart.plateAddOnsR4Check,
              "value": cart.plateQuantityR4Check,
            },
            {
              "key": cart.bottleAddOnsR4Check,
              "value": cart.bottleQuantityR4Check,
            },
            {
              "key": cart.mangoAddOnsR4Check,
              "value": cart.mangoQuantityR4Check,
            },
            {
              "key": cart.naanAddOnsR4Check,
              "value": cart.naanQuantityR4Check,
            },


            // {  //"id": 3060,
            //   "key": "Spoon, Fork, Napkins (0.25)",
            //   "value": "1",
            //
            // },
          ],
        //Family Feast
        if(cart.cart[i].productId.toString() == '6170')
          "meta_data": [
            {
              "key": cart.apIFF,
              "value": cart.apIFFValue,
            },
            {
              "key": cart.apIIFF,
              "value": cart.apIIFFValue,
            },
            {
              "key": cart.e1FF,
              "value": cart.e1FFValue,
            },
            {
              "key": cart.e2FF,
              "value": cart.e2FFValue,
            },
            {
              "key": cart.e3FF,
              "value": cart.e3FFValue,
            },
            {
              "key": cart.breadFF,
              "value": cart.breadFFValue,
            },
            {
              "key": cart.c1FF,
              "value": cart.c1FFValue,
            },
            {
              "key": cart.c2FF,
              "value": cart.c2FFValue,
            },
            {
              "key": cart.dessertsFF,
              "value": cart.dessertsFFValue,
            },
            {
              "key": cart.plateAddOnsFFCheck,
              "value": cart.plateQuantityFFCheck,
            },
            {
              "key": cart.bottleAddOnsFFCheck,
              "value": cart.bottleQuantityFFCheck,
            },
            {
              "key": cart.mangoAddOnsFFCheck,
              "value": cart.mangoQuantityFFCheck,
            },
            {
              "key": cart.naanAddOnsFFCheck,
              "value": cart.naanQuantityFFCheck,
            },


            // {  //"id": 3060,
            //   "key": "Spoon, Fork, Napkins (0.25)",
            //   "value": "1",
            //
            // },
          ],
        //lunch box
        if(cart.cart[i].productId.toString() == '6149')
          "meta_data": [
            {
              "key": cart.apILBox,
              "value": cart.apILBoxValue,
            },
            {
              "key": cart.apIILBox,
              "value": cart.apIILBoxValue,
            },
            {
              "key": cart.e1LBox,
              "value": cart.e1LBoxValue,
            },
            {
              "key": cart.e2LBox,
              "value": cart.e2LBoxValue,
            },
            {
              "key": cart.e3LBox,
              "value": cart.e3LBoxValue,
            },
            {
              "key": cart.breadLBox,
              "value": cart.breadLBoxValue,
            },
            {
              "key": cart.c1LBox,
              "value": cart.c1LBoxValue,
            },
            {
              "key": cart.c2LBox,
              "value": cart.c2LBoxValue,
            },
            {
              "key": cart.dessertsLBox,
              "value": cart.dessertsLBoxValue,
            },
            {
              "key": cart.plateAddOnsLBoxCheck,
              "value": cart.plateQuantityLBoxCheck,
            },
            {
              "key": cart.bottleAddOnsLBoxCheck,
              "value": cart.bottleQuantityLBoxCheck,
            },
            {
              "key": cart.mangoAddOnsLBoxCheck,
              "value": cart.mangoQuantityLBoxCheck,
            },
            {
              "key": cart.naanAddOnsLBoxCheck,
              "value": cart.naanQuantityLBoxCheck,
            },


            // {  //"id": 3060,
            //   "key": "Spoon, Fork, Napkins (0.25)",
            //   "value": "1",
            //
            // },
          ],

      },
      /*for(int i=0;i<cart.cart.length;i++){

        "product_id": cart.idGrowableList[i],
        "quantity": cart.quantityList[i],

        if(cart.cart[i].varData.toString().isNotEmpty)
          "variation_id": cart.variationId[i].toString(),
      }*/
    ];
    List movementHere = [
      {"method_id": "flat_rate", "method_title": "Flat Rate", "total":  '0.00'}
    ];

    List products = [];
    for(int i=0;i<cart.cart.length;i++) {
      Map<String, dynamic> product = {
        "product_id": cart.idGrowableList[i],
        "quantity": cart.quantityList[i]
      };
      if(cart.cart[i].varData.toString().isNotEmpty){
        product['variation_id'] = cart.cart[i].varData;
      }
      products.add(product);
    }
    void oderDataPost() async {

      var url =
          "https://spiceshackus.com/wp-json/wc/v3/orders?consumer key=ck_33fb5dae74953e8d8f552d2ff8cccc6b48bd3e51&consumer secret=cs_a87b5c5300da75bd2e7fc8876d09cb0ec3457f06";


      Map<String, dynamic> data = {
        // "payment_method": "bacs",
        // "payment_method_title": "Direct Bank Transfer",
        "set_paid": true,
        //"status": "completed",
        "shipping": address,
        "billing": someMap,
        "line_items": movement,
        "shipping_lines": movementHere,
        if(cart.isApply == true)
          "coupon_lines": [
            {"code": "SPICY30"}
          ],
          "discount_total": cart.isApply ? billTotalCoupon : billTotal,


      };

      // Map<String, dynamic> map = [
      //   "fthg" : 78,
      //   "buh",
      // ];
      var body = jsonEncode(data);
      var urlParse = Uri.parse(url);
      Response response = await http.post(urlParse,
          body: body, headers: {"content-Type": "application/json"});
      cart.loadDataAPi = 1;
      jsonDecode(response.body);
      cart.orderId = jsonDecode(response.body)['id'];
      if (kDebugMode) {
        print("Response Code :-${response.statusCode}");
      }
      if (response.statusCode == 201) {
        cart.loadDataAPi = 2;
      }
      cart.loadDataAPi = 1;
      if (kDebugMode) {
        print("Id of Order is here :- ${cart.orderId}");
      }
    }

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
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: Container(
                    height: 300,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: GradientsConstants.redGradient,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(60),
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Lottie.asset('assets/images/lottie/drawer.json'),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 8.0, left: 18.0, right: 8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomRight,
                          colors: [
                            Colors.brown.withOpacity(.4),
                            Colors.black.withOpacity(.5),
                          ],
                        ),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(60),
                          topRight: Radius.circular(60),
                        ),
                      ),
                      child: Column(
                        children: [
                          Container(
                            height: 10.h,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.bottomRight,
                                colors: [
                                  Colors.black.withOpacity(.4),
                                  Colors.black.withOpacity(.5),
                                ],
                              ),
                              border: Border.all(width: 1, color: MyColors.brown),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(60),
                              ),
                            ),
                            child: Center(
                              child: AutoSizeText(
                                "Order Detail",
                                textAlign: TextAlign.center,
                                style: AppTextStyle.spiceShackFonts(
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600,
                                    color: MyColors.silver,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 8.0,
                              bottom: 8.0,
                            ),
                            child: Container(
                              height: 17.h,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                //gradient: GradientsConstants.goldGradient,
                                gradient: LinearGradient(
                                  begin: Alignment.bottomRight,
                                  colors: [
                                    Colors.black.withOpacity(.4),
                                    Colors.black.withOpacity(.5),
                                  ],
                                ),

                                //borderRadius: BorderRadius.circular(30),
                              ),
                              child: Stack(
                                children: [
                                  Positioned(
                                    child: Align(
                                      alignment: Alignment.topCenter,
                                      child: Container(
                                        height: 8.h,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.bottomRight,
                                            colors: [
                                              Colors.black.withOpacity(.4),
                                              Colors.black.withOpacity(.5),
                                            ],
                                          ),
                                          border: Border.all(
                                              width: 1, color: MyColors.brown),
                                          borderRadius: const BorderRadius.only(
                                            bottomLeft: Radius.circular(20),
                                            topLeft: Radius.circular(20),
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8.0, horizontal: 15.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  AutoSizeText(
                                                    "Email :",
                                                    textAlign: TextAlign.start,
                                                    style: AppTextStyle
                                                        .spiceShackFonts(
                                                      style: TextStyle(
                                                        fontSize: 12.sp,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: MyColors.white,
                                                      ),
                                                    ),
                                                  ),
                                                  AutoSizeText(
                                                    profileEmail,
                                                    textAlign: TextAlign.end,
                                                    style: AppTextStyle
                                                        .spiceShackFonts(
                                                      style: TextStyle(
                                                        fontSize: 12.sp,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: MyColors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    child: Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Container(
                                        height: 7.h,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          border: Border.all(
                                              width: 1, color: MyColors.brown),
                                          borderRadius: const BorderRadius.only(
                                            bottomLeft: Radius.circular(20),
                                            topLeft: Radius.circular(20),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            AutoSizeText(
                                              "Total :",
                                              textAlign: TextAlign.start,
                                              style: AppTextStyle.spiceShackFonts(
                                                style: TextStyle(
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.w800,
                                                  color: MyColors.white,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 5.w,
                                            ),
                                            Consumer<ProductCategoriesProvider>(
                                              builder: (BuildContext context,
                                                  value, Widget? child) {
                                                final ValueNotifier<double?>
                                                    totalPrice =
                                                    ValueNotifier(null);
                                                for (var element in value.cart) {
                                                  totalPrice.value =
                                                      (element.productPrice! *
                                                              element.quantity!
                                                                  .value) +
                                                          (totalPrice.value ?? 0);
                                                }
                                                billTotal =
                                                    totalPrice.value!.toStringAsFixed(0);
                                                return ValueListenableBuilder<
                                                        double?>(
                                                    valueListenable: totalPrice,
                                                    builder:
                                                        (context, val, child) {
                                                      if(cart.cardCount == 1){
                                                        return AutoSizeText(
                                                          "\$ ${cart.total}",
                                                          // "\$ ${(val?.toStringAsFixed(2) ?? '0')} ",
                                                          textAlign: TextAlign.end,
                                                          style: AppTextStyle
                                                              .spiceShackFonts(
                                                            style: TextStyle(
                                                              fontSize: 12.sp,
                                                              fontWeight:
                                                              FontWeight.w600,
                                                              color: MyColors.white,
                                                            ),
                                                          ),
                                                        );
                                                      }/*if(cart.cardCount == 0){
                                                        return AutoSizeText(
                                                          ": \$ $billTotal ",
                                                          // "\$ ${(val?.toStringAsFixed(2) ?? '0')} ",
                                                          textAlign: TextAlign.end,
                                                          style: AppTextStyle
                                                              .spiceShackFonts(
                                                            style: TextStyle(
                                                              fontSize: 12.sp,
                                                              fontWeight:
                                                              FontWeight.w600,
                                                              color: MyColors.white,
                                                            ),
                                                          ),
                                                        );
                                                      }*/
                                                      return AutoSizeText(
                                                        cart.isApply
                                                            ?  "\$ $billTotalCoupon":
                                                        "\$ $billTotal ",
                                                        // "\$ ${(val?.toStringAsFixed(2) ?? '0')} ",
                                                        textAlign: TextAlign.end,
                                                        style: AppTextStyle
                                                            .spiceShackFonts(
                                                          style: TextStyle(
                                                            fontSize: 12.sp,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: MyColors.white,
                                                          ),
                                                        ),
                                                      );
                                                    });
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: 20.h,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(width: 1, color: MyColors.brown),
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                topLeft: Radius.circular(20),
                              ),
                            ),
                            child: Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 8.h,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.bottomRight,
                                        colors: [
                                          Colors.black.withOpacity(.4),
                                          Colors.black.withOpacity(.5),
                                        ],
                                      ),
                                      border: Border.all(
                                        width: 1,
                                        color: Colors.brown,
                                      ),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Center(
                                      child: RichText(
                                        textAlign: TextAlign.center,
                                        text: TextSpan(
                                          text: "Current Address :",
                                          style: AppTextStyle.spiceShackFonts(
                                            style: TextStyle(
                                              fontSize: 9.sp,
                                              fontWeight: FontWeight.w600,
                                              color: MyColors.white,
                                            ),
                                          ),
                                          children: [
                                            TextSpan(
                                              text: '\t ',
                                              style: AppTextStyle.spliceSans(
                                                style: TextStyle(
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                            TextSpan(
                                              text: valueProvider.Address
                                                  .toString(),
                                              style: AppTextStyle.spliceSans(
                                                style: TextStyle(
                                                  fontSize: 9.sp,
                                                  color: MyColors.yellow,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        height: 8.h,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.bottomRight,
                                            colors: [
                                              Colors.black.withOpacity(.4),
                                              Colors.black.withOpacity(.5),
                                            ],
                                          ),
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                        child: Row(
                                          children: [
                                            cart.isApply?
                                            Expanded(
                                              flex: 3,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                    begin: Alignment.bottomRight,
                                                    colors: [
                                                      Colors.black.withOpacity(.4),
                                                      Colors.black.withOpacity(.5),
                                                    ],
                                                  ),
                                                  border: Border.all(
                                                    width: 1,
                                                    color: Colors.brown,
                                                  ),
                                                  borderRadius: BorderRadius.circular(20),
                                                ),
                                                child: Center(
                                                  child: RichText(
                                                    textAlign: TextAlign.center,
                                                    text: TextSpan(
                                                      text: "Coupon : SPICY30",
                                                      style: AppTextStyle.spiceShackFonts(
                                                        style: TextStyle(
                                                          fontSize: 12.sp,
                                                          fontWeight: FontWeight.w600,
                                                          color: MyColors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ):Expanded(
                                              flex: 3,
                                              child: TextFormField(
                                                style: TextStyle(
                                                    color: MyColors.silver),
                                                decoration: InputDecoration(
                                                  focusedBorder:
                                                  OutlineInputBorder(
                                                    borderRadius:
                                                    BorderRadius.circular(25),
                                                    borderSide: BorderSide(
                                                      color: MyColors.silver,
                                                    ),
                                                  ),
                                                  enabledBorder:
                                                  OutlineInputBorder(
                                                    borderRadius:
                                                    BorderRadius.circular(25),
                                                    borderSide: BorderSide(
                                                        color: MyColors.grey),
                                                  ),
                                                  hintText:
                                                  'Enter promo code here',
                                                  hintStyle: TextStyle(
                                                      color: MyColors.grey),
                                                ),
                                                keyboardType:
                                                TextInputType.emailAddress,
                                                controller: promoController,
                                                onFieldSubmitted: (value) {
                                                  //Validator
                                                },
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Padding(
                                                padding: const EdgeInsets.all(6.0),
                                                child: InkWell(
                                                  onTap: () async {
                                                    //onButtonClick();
                                                    //cart.toggleApply();
                                                    List<CouponsModel> coupons= await ProductsFunctionsApi().getCouponsData(promoController.text.toString());
                                                    Provider.of<ProductCategoriesProvider>(context,listen: false).updateCoupon(coupons);
                                                    print(cart.couponState);

                                                    /*if(promoController.text.toString() == 'SPICY30' && double.parse(billTotal) >=  30.0){
                                                      print("Card loader :- ${cart.cardCount}");
                                                      cart.toggleApply();

                                                    }
                                                    else*/
                                                    if(cart.couponState == 1 ){


                                                      double value;
                                                      if(double.parse(billTotalCoupon) >= double.parse(cart.couponsData[0].balance.toString())){
                                                        value = double.parse(billTotal) - double.parse(cart.couponsData[0].balance.toString());

                                                        billTotalCoupon = value.toStringAsFixed(0);
                                                        cart.toggleApply();
                                                      }

                                                      setState(() {

                                                      });



                                                    }

                                                    // onButtonClick();
                                                    // if(promoController.text.toString() == 'SPICY30' && double.parse(billTotal) >=  30.0){
                                                    //   print("Card loader :- ${cart.cardCount}");
                                                    //   cart.toggleApply();
                                                    //
                                                    // }else{
                                                    //   List<CouponsModel> coupons= await ProductsFunctionsApi().getCouponsData("H89F-UNJ6-KHNU-QMPY");
                                                    //   Provider.of<ProductCategoriesProvider>(context,listen: false).updateCoupon(coupons);
                                                    //   print(cart.couponState);
                                                    //   if(cart.couponState == 1){
                                                    //     if(double.parse(cart.couponsData[0].balance.toString()) >= double.parse(billTotal)){
                                                    //
                                                    //       double value;
                                                    //       value = double.parse(billTotal) - double.parse(cart.couponsData[0].balance.toString());
                                                    //       billTotalCoupon = value.toString();
                                                    //       setState(() {
                                                    //
                                                    //       });
                                                    //       cart.toggleApply();
                                                    //     }
                                                    //
                                                    //   }
                                                    // }


                                                    // codeGiftCard = 'CU9D-45HQ-8LGS-PC8F';
                                                    // Provider.of<ProductCategoriesProvider>(context, listen: false).fetchDataOfGiftsCard();
                                                    // cart.myDataList.clear();

                                                    /*if(cart.card == 1){
                                                      codeGiftCard = '';
                                                      cart.placeApply();
                                                    }else if(cart.card == 0){
                                                      if(promoController.text.toString() == 'SPICY30' && double.parse(billTotal) >=  30.0){
                                                        print("Card loader :- ${cart.cardCount}");
                                                        cart.toggleApply();

                                                      }else{
                                                        cart.checkGiftBill = int.parse(billTotal);
                                                        Provider.of<ProductCategoriesProvider>(context, listen: false).fetchDataOfGiftsCard();
                                                        cart.myDataList.clear();
                                                      }
                                                    }
                                                    print('movement : data :- $movement');*/

                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: cart.isApply
                                                          ? MyColors
                                                          .green.withOpacity(0.8):MyColors.silver,
                                                      borderRadius: BorderRadius.circular(25),
                                                    ),
                                                    child: Center(
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: [
                                                          cart.isApply ? Icon(
                                                            Icons.check,
                                                            color: MyColors
                                                                .white,
                                                          ):const SizedBox(),
                                                          AutoSizeText(
                                                      cart.isApply
                                                      ?  "Applied":"Apply",
                                                            textAlign: TextAlign.center,
                                                            style:
                                                            AppTextStyle.spiceShackFonts(
                                                              style: TextStyle(
                                                                fontSize: 12.sp,
                                                                fontWeight: FontWeight.w800,
                                                                color: cart.isApply
                                                                    ? Colors.white
                                                                    : MyColors
                                                                    .black,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
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
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 8.0,
                              bottom: 8.0,
                            ),
                            child: Container(
                              height: 17.h,
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                  //gradient: GradientsConstants.goldGradient,
                                  color: Colors.transparent
                                  //borderRadius: BorderRadius.circular(30),
                                  ),
                              child: Stack(
                                children: [
                                  Positioned(
                                    child: Align(
                                      alignment: Alignment.topCenter,
                                      child: Container(
                                        height: 8.h,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          border: Border.all(
                                              width: 1, color: MyColors.brown),
                                          borderRadius: const BorderRadius.only(
                                            bottomLeft: Radius.circular(20),
                                            topLeft: Radius.circular(20),
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8.0, horizontal: 15.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                child: Padding(
                                                  padding: const EdgeInsets.only(
                                                      right: 8.0),
                                                  child: InkWell(
                                                    onTap: () {
                                                      if (cart.payCount == 1) {
                                                      } else {
                                                        cart.toggleLike();
                                                      }
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: cart.isLiked
                                                            ? Colors.red.shade400
                                                            : Colors.white,
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                15),
                                                      ),
                                                      child: Center(
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: [
                                                            cart.isLiked ? Icon(
                                                              Icons.check,
                                                              color: MyColors
                                                                  .white,
                                                            ):const SizedBox(),
                                                            AutoSizeText(
                                                              "Cash on delivery ",
                                                              textAlign:
                                                                  TextAlign.center,
                                                              style: AppTextStyle
                                                                  .spiceShackFonts(
                                                                style: TextStyle(
                                                                  fontSize: 10.sp,
                                                                  fontWeight:
                                                                      FontWeight.w600,
                                                                  color: cart.isLiked
                                                                      ? Colors.white
                                                                      : MyColors
                                                                          .black,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Padding(
                                                  padding: const EdgeInsets.only(
                                                      left: 8.0),
                                                  child: InkWell(
                                                    onTap: () {
                                                      setState(() {

                                                      });
                                                      print(billTotal);

                                                     makePayment(billTotal);
                                                      // if (cart.payCount == 1) {
                                                      // } else {
                                                      //   makePayment();
                                                      // }
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: cart.isPay
                                                            ? Colors.red.shade400
                                                            : Colors.white,
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                15),
                                                      ),
                                                      child: Center(
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: [
                                                            cart.isPay ? Icon(
                                                              Icons.check,
                                                              color: cart.isPay
                                                                  ? Colors.white
                                                                  : MyColors
                                                                  .black,
                                                            ):const SizedBox(),
                                                            AutoSizeText(
                                                              "Stripe Pay",
                                                              textAlign:
                                                                  TextAlign.center,
                                                              style: AppTextStyle
                                                                  .spiceShackFonts(
                                                                style: TextStyle(
                                                                  fontSize: 10.sp,
                                                                  fontWeight:
                                                                      FontWeight.w600,
                                                                  color: cart.isPay
                                                                      ? Colors.white
                                                                      : MyColors
                                                                          .black,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
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
                                  ),
                                  Positioned(
                                    child: Align(
                                      alignment: Alignment.bottomCenter,
                                      child: GestureDetector(
                                        onTap: () async {

                                        //   final SharedPreferences prefs = await SharedPreferences.getInstance();
                                        // valueProvider.plateAddOnsLBoxCheck = (prefs.getString('PlatesAddOnsLBox') ?? '');
                                        // valueProvider.plateQuantityLBoxCheck = (prefs.getString('PlatesAddOnsQuantityLBox') ?? '');
                                        // valueProvider.bottleAddOnsLBoxCheck = (prefs.getString('BottleAddOnsLBox') ?? '');
                                        // valueProvider.bottleQuantityLBoxCheck = (prefs.getString('BottleAddOnsQuantityLBox') ?? '');
                                        // valueProvider.mangoAddOnsLBoxCheck = (prefs.getString('MangoAddOnsLBox') ?? '');
                                        // valueProvider.mangoQuantityLBoxCheck = (prefs.getString('MangoAddOnsQuantityLBox') ?? '');
                                        // valueProvider.naanAddOnsLBoxCheck = (prefs.getString('NaanAddOnsLBox') ?? '');
                                        // valueProvider.naanQuantityLBoxCheck = (prefs.getString('NaanAddOnsQuantityLBox') ?? '');
                                        // valueProvider.apILBox = (prefs.getString("ApILBox") ?? '');
                                        // valueProvider.apILBoxValue = (prefs.getString("ApILBoxValue") ?? '');
                                        // valueProvider.apIILBox = (prefs.getString("ApIiLBox") ?? '');
                                        // valueProvider.apIILBoxValue = (prefs.getString("ApIILBoxValue") ?? '');
                                        // valueProvider.e1LBox = (prefs.getString("E1LBox") ?? '');
                                        // valueProvider.e1LBoxValue = (prefs.getString("E1LBoxValue") ?? '');
                                        // valueProvider.e2LBox = (prefs.getString("E2LBox") ?? '');
                                        // valueProvider.e2LBoxValue = (prefs.getString("E2LBoxValue") ?? '');
                                        // valueProvider.e3LBox = (prefs.getString("E3LBox") ?? '');
                                        // valueProvider.e3LBoxValue = (prefs.getString("E3LBoxValue") ?? '');
                                        // valueProvider.breadLBox = (prefs.getString("BreadLBox") ?? '');
                                        // valueProvider.breadLBoxValue = (prefs.getString("BreadLBoxValue") ?? '');
                                        // valueProvider.c1LBox = (prefs.getString("C1LBox") ?? '');
                                        // valueProvider.c1LBoxValue = (prefs.getString("C1LBoxValue") ?? '');
                                        // valueProvider.c2LBox = (prefs.getString("C2LBox") ?? '');
                                        // valueProvider.c2LBoxValue = (prefs.getString("C2LBoxValue") ?? '');
                                        // valueProvider.dessertsLBox = (prefs.getString("DessertsLBox") ?? '');
                                        // valueProvider.dessertsLBoxValue = (prefs.getString("DessertsLBoxValue") ?? '');
                                        //
                                        //   valueProvider.plateAddOnsFFCheck = (prefs.getString('PlatesAddOnsFF') ?? '');
                                        //   valueProvider.plateQuantityFFCheck = (prefs.getString('PlatesAddOnsQuantityFF') ?? '');
                                        //   valueProvider.bottleAddOnsFFCheck = (prefs.getString('BottleAddOnsFF') ?? '');
                                        //   valueProvider.bottleQuantityFFCheck = (prefs.getString('BottleAddOnsQuantityFF') ?? '');
                                        //   valueProvider.mangoAddOnsFFCheck = (prefs.getString('MangoAddOnsFF') ?? '');
                                        //   valueProvider.mangoQuantityFFCheck = (prefs.getString('MangoAddOnsQuantityFF') ?? '');
                                        //   valueProvider.naanAddOnsFFCheck = (prefs.getString('NaanAddOnsFF') ?? '');
                                        //   valueProvider.naanQuantityFFCheck = (prefs.getString('NaanAddOnsQuantityFF') ?? '');
                                        //   valueProvider.apIFF = (prefs.getString("ApIFF") ?? '');
                                        //   valueProvider.apIFFValue = (prefs.getString("ApIFFValue") ?? '');
                                        //   valueProvider.apIIFF = (prefs.getString("ApIiFF") ?? '');
                                        //   valueProvider.apIIFFValue = (prefs.getString("ApIIFFValue") ?? '');
                                        //   valueProvider.e1FF = (prefs.getString("E1FF") ?? '');
                                        //   valueProvider.e1FFValue = (prefs.getString("E1FFValue") ?? '');
                                        //   valueProvider.e2FF = (prefs.getString("E2FF") ?? '');
                                        //   valueProvider.e2FFValue = (prefs.getString("E2FFValue") ?? '');
                                        //   valueProvider.e3FF = (prefs.getString("E3FF") ?? '');
                                        //   valueProvider.e3FFValue = (prefs.getString("E3FFValue") ?? '');
                                        //   valueProvider.breadFF = (prefs.getString("BreadFF") ?? '');
                                        //   valueProvider.breadFFValue = (prefs.getString("BreadFFValue") ?? '');
                                        //   valueProvider.c1FF = (prefs.getString("C1FF") ?? '');
                                        //   valueProvider.c1FFValue = (prefs.getString("C1FFValue") ?? '');
                                        //   valueProvider.c2FF = (prefs.getString("C2FF") ?? '');
                                        //   valueProvider.c2FFValue = (prefs.getString("C2FFValue") ?? '');
                                        //   valueProvider.dessertsFF = (prefs.getString("DessertsFF") ?? '');
                                        //   valueProvider.dessertsFFValue = (prefs.getString("DessertsFFValue") ?? '');
                                        //
                                        //   valueProvider.plateAddOnsFFCheck = (prefs.getString('PlatesAddOnsFF') ?? '');
                                        //   valueProvider.plateQuantityFFCheck = (prefs.getString('PlatesAddOnsQuantityFF') ?? '');
                                        //   valueProvider.bottleAddOnsFFCheck = (prefs.getString('BottleAddOnsFF') ?? '');
                                        //   valueProvider.bottleQuantityFFCheck = (prefs.getString('BottleAddOnsQuantityFF') ?? '');
                                        //   valueProvider.mangoAddOnsFFCheck = (prefs.getString('MangoAddOnsFF') ?? '');
                                        //   valueProvider.mangoQuantityFFCheck = (prefs.getString('MangoAddOnsQuantityFF') ?? '');
                                        //   valueProvider.naanAddOnsFFCheck = (prefs.getString('NaanAddOnsFF') ?? '');
                                        //   valueProvider.naanQuantityFFCheck = (prefs.getString('NaanAddOnsQuantityFF') ?? '');
                                        //   valueProvider.apIFF = (prefs.getString("ApIFF") ?? '');
                                        //   valueProvider.apIFFValue = (prefs.getString("ApIFFValue") ?? '');
                                        //   valueProvider.apIIFF = (prefs.getString("ApIiFF") ?? '');
                                        //   valueProvider.apIIFFValue = (prefs.getString("ApIIFFValue") ?? '');
                                        //   valueProvider.e1FF = (prefs.getString("E1FF") ?? '');
                                        //   valueProvider.e1FFValue = (prefs.getString("E1FFValue") ?? '');
                                        //   valueProvider.e2FF = (prefs.getString("E2FF") ?? '');
                                        //   valueProvider.e2FFValue = (prefs.getString("E2FFValue") ?? '');
                                        //   valueProvider.e3FF = (prefs.getString("E3FF") ?? '');
                                        //   valueProvider.e3FFValue = (prefs.getString("E3FFValue") ?? '');
                                        //   valueProvider.breadFF = (prefs.getString("BreadFF") ?? '');
                                        //   valueProvider.breadFFValue = (prefs.getString("BreadFFValue") ?? '');
                                        //   valueProvider.c1FF = (prefs.getString("C1FF") ?? '');
                                        //   valueProvider.c1FFValue = (prefs.getString("C1FFValue") ?? '');
                                        //   valueProvider.c2FF = (prefs.getString("C2FF") ?? '');
                                        //   valueProvider.c2FFValue = (prefs.getString("C2FFValue") ?? '');
                                        //   valueProvider.dessertsFF = (prefs.getString("DessertsFF") ?? '');
                                        //   valueProvider.dessertsFFValue = (prefs.getString("DessertsFFValue") ?? '');
                                        //   valueProvider.plateAddOnsR3Check = (prefs.getString('PlatesAddOnsR3') ?? '');
                                        //   valueProvider.plateQuantityR3Check = (prefs.getString('PlatesAddOnsQuantityR3') ?? '');
                                        //   valueProvider.bottleAddOnsR3Check = (prefs.getString('BottleAddOnsR3') ?? '');
                                        //   valueProvider.bottleQuantityR3Check = (prefs.getString('BottleAddOnsQuantityR3') ?? '');
                                        //   valueProvider.mangoAddOnsR3Check = (prefs.getString('MangoAddOnsR3') ?? '');
                                        //   valueProvider.mangoQuantityR3Check = (prefs.getString('MangoAddOnsQuantityR3') ?? '');
                                        //   valueProvider.naanAddOnsR3Check = (prefs.getString('NaanAddOnsR3') ?? '');
                                        //   valueProvider.naanQuantityR3Check = (prefs.getString('NaanAddOnsQuantityR3') ?? '');
                                        //   valueProvider.plateAddOnsR1Check = (prefs.getString('PlatesAddOnsR1') ?? '');
                                        //   valueProvider.plateQuantityR1Check = (prefs.getString('PlatesAddOnsQuantityR1') ?? '');
                                        //   valueProvider.bottleAddOnsR1Check = (prefs.getString('BottleAddOnsR1') ?? '');
                                        //   valueProvider.bottleQuantityR1Check = (prefs.getString('BottleAddOnsQuantityR1') ?? '');
                                        //   valueProvider.mangoAddOnsR1Check = (prefs.getString('MangoAddOnsR1') ?? '');
                                        //   valueProvider.mangoQuantityR1Check = (prefs.getString('MangoAddOnsQuantityR1') ?? '');
                                        //   valueProvider.naanAddOnsR1Check = (prefs.getString('NaanAddOnsR1') ?? '');
                                        //   valueProvider.naanQuantityR1Check = (prefs.getString('NaanAddOnsQuantityR1') ?? '');
                                        //
                                        //   valueProvider.apIR1 = (prefs.getString("ApIR1") ?? '');
                                        //   valueProvider.apIR1Value = (prefs.getString("ApIR1Value") ?? '');
                                        //   valueProvider.e1R1 = (prefs.getString("E1R1") ?? '');
                                        //   valueProvider.e1R1Value = (prefs.getString("E1R1Value") ?? '');
                                        //   valueProvider.e2R1 = (prefs.getString("E2R1") ?? '');
                                        //   valueProvider.e2R1Value = (prefs.getString("E2R1Value") ?? '');
                                        //   valueProvider.c1R1 = (prefs.getString("C1R1") ?? '');
                                        //   valueProvider.c1R1Value = (prefs.getString("C1R1Value") ?? '');
                                        //   valueProvider.dessertsR1 = (prefs.getString("DessertsR1") ?? '');
                                        //   valueProvider.dessertsR1Value = (prefs.getString("DessertsR1Value") ?? '');
                                        //
                                        //
                                        //   valueProvider.plateAddOnsR2Check = (prefs.getString('PlatesAddOnsR2') ?? '');
                                        //   valueProvider.plateQuantityR2Check = (prefs.getString('PlatesAddOnsQuantityR2') ?? '');
                                        //   valueProvider.bottleAddOnsR2Check = (prefs.getString('BottleAddOnsR2') ?? '');
                                        //   valueProvider.bottleQuantityR2Check = (prefs.getString('BottleAddOnsQuantityR2') ?? '');
                                        //   valueProvider.mangoAddOnsR2Check = (prefs.getString('MangoAddOnsR2') ?? '');
                                        //   valueProvider.mangoQuantityR2Check = (prefs.getString('MangoAddOnsQuantityR2') ?? '');
                                        //   valueProvider.naanAddOnsR2Check = (prefs.getString('NaanAddOnsR2') ?? '');
                                        //   valueProvider.naanQuantityR2Check = (prefs.getString('NaanAddOnsQuantityR2') ?? '');
                                        //
                                        //
                                        //   valueProvider.apIR2 = (prefs.getString("ApIR2") ?? '');
                                        //   valueProvider.apIR2Value = (prefs.getString("ApIR2Value") ?? '');
                                        //   valueProvider.e1R2 = (prefs.getString("E1R2") ?? '');
                                        //   valueProvider.e1R2Value = (prefs.getString("E1R2Value") ?? '');
                                        //   valueProvider.e2R2 = (prefs.getString("E2R2") ?? '');
                                        //   valueProvider.e2R2Value = (prefs.getString("E2R2Value") ?? '');
                                        //   valueProvider.e3R2 = (prefs.getString("E3R2") ?? '');
                                        //   valueProvider.e3R2Value = (prefs.getString("E3R2Value") ?? '');
                                        //   valueProvider.breadR2 = (prefs.getString("BreadR2") ?? '');
                                        //   valueProvider.breadR2Value = (prefs.getString("BreadR2Value") ?? '');
                                        //   valueProvider.c1R2 = (prefs.getString("C1R2") ?? '');
                                        //   valueProvider.c1R2Value = (prefs.getString("C1R2Value") ?? '');
                                        //   valueProvider.c2R2 = (prefs.getString("C2R2") ?? '');
                                        //   valueProvider.c2R2Value = (prefs.getString("C2R2Value") ?? '');
                                        //   valueProvider.dessertsR2 = (prefs.getString("DessertsR2") ?? '');
                                        //   valueProvider.dessertsR2Value = (prefs.getString("DessertsR2Value") ?? '');
                                        //
                                        //
                                        //   valueProvider.apIR3 = (prefs.getString("ApIR3") ?? '');
                                        //   valueProvider.apIR3Value = (prefs.getString("ApIR3Value") ?? '');
                                        //   valueProvider.apIIR3 = (prefs.getString("ApIIR3") ?? '');
                                        //   valueProvider.apIIR3Value = (prefs.getString("ApIIR3Value") ?? '');
                                        //   valueProvider.e1R3 = (prefs.getString("E1R3") ?? '');
                                        //   valueProvider.e1R3Value = (prefs.getString("E1R3Value") ?? '');
                                        //   valueProvider.e2R3 = (prefs.getString("E2R3") ?? '');
                                        //   valueProvider.e2R3Value = (prefs.getString("E2R3Value") ?? '');
                                        //   valueProvider.e3R3 = (prefs.getString("E3R3") ?? '');
                                        //   valueProvider.e3R3Value = (prefs.getString("E3R3Value") ?? '');
                                        //   valueProvider.breadR3 = (prefs.getString("BreadR3") ?? '');
                                        //   valueProvider.breadR3Value = (prefs.getString("BreadR3Value") ?? '');
                                        //   valueProvider.c1R3 = (prefs.getString("C1R3") ?? '');
                                        //   valueProvider.c1R3Value = (prefs.getString("C1R3Value") ?? '');
                                        //   valueProvider.c2R3 = (prefs.getString("C2R3") ?? '');
                                        //   valueProvider.c2R3Value = (prefs.getString("C2R3Value") ?? '');
                                        //   valueProvider.dessertsR3 = (prefs.getString("DessertsR3") ?? '');
                                        //   valueProvider.dessertsR3Value = (prefs.getString("DessertsR3Value") ?? '');
                                        //
                                        //
                                        //   valueProvider.plateAddOnsR4Check = (prefs.getString('PlatesAddOnsR4') ?? '');
                                        //   valueProvider.plateQuantityR4Check = (prefs.getString('PlatesAddOnsQuantityR4') ?? '');
                                        //   valueProvider.bottleAddOnsR4Check = (prefs.getString('BottleAddOnsR4') ?? '');
                                        //   valueProvider.bottleQuantityR4Check = (prefs.getString('BottleAddOnsQuantityR4') ?? '');
                                        //   valueProvider.mangoAddOnsR4Check = (prefs.getString('MangoAddOnsR4') ?? '');
                                        //   valueProvider.mangoQuantityR4Check = (prefs.getString('MangoAddOnsQuantityR4') ?? '');
                                        //   valueProvider.naanAddOnsR4Check = (prefs.getString('NaanAddOnsR4') ?? '');
                                        //   valueProvider.naanQuantityR4Check = (prefs.getString('NaanAddOnsQuantityR4') ?? '');
                                        //   valueProvider.apIR4 = (prefs.getString("ApIR4") ?? '');
                                        //   valueProvider.apIR4Value = (prefs.getString("ApIR4Value") ?? '');
                                        //   valueProvider.apIIR4 = (prefs.getString("ApIIR4") ?? '');
                                        //   valueProvider.apIIR4Value = (prefs.getString("ApIIR4Value") ?? '');
                                        //   valueProvider.e1R4 = (prefs.getString("E1R4") ?? '');
                                        //   valueProvider.e1R4Value = (prefs.getString("E1R4Value") ?? '');
                                        //   valueProvider.e2R4 = (prefs.getString("E2R4") ?? '');
                                        //   valueProvider.e2R4Value = (prefs.getString("E2R4Value") ?? '');
                                        //   valueProvider.e3R4 = (prefs.getString("E3R4") ?? '');
                                        //   valueProvider.e3R4Value = (prefs.getString("E3R4Value") ?? '');
                                        //   valueProvider.breadR4 = (prefs.getString("BreadR4") ?? '');
                                        //   valueProvider.breadR4Value = (prefs.getString("BreadR4Value") ?? '');
                                        //   valueProvider.c1R4 = (prefs.getString("C1R4") ?? '');
                                        //   valueProvider.c1R4Value = (prefs.getString("C1R4Value") ?? '');
                                        //   valueProvider.c2R4 = (prefs.getString("C2R4") ?? '');
                                        //   valueProvider.c2R4Value = (prefs.getString("C2R4Value") ?? '');
                                        //   valueProvider.dessertsR4 = (prefs.getString("DessertsR4") ?? '');
                                        //   valueProvider.dessertsR4Value = (prefs.getString("DessertsR4Value") ?? '');












                                          if (cart.likeCount == 1 || cart.payCount == 1) {
                                            order = valueProvider.getTotalPrice
                                                .toString();
                                            oderDataPost();
                                            cart.placeApply();
                                            cart.placeLike();
                                            cart.placePay();

                                            Navigator.pushAndRemoveUntil(context,
                                                MaterialPageRoute(builder:
                                                    (BuildContext context) {
                                                  return const PlaceOrderScreen();
                                                }), (r) {
                                                  return false;
                                                });
                                            if (cart.loadDAtaAPi == 2) {
                                            } else {
                                              const CircularProgressIndicator();
                                            }
                                          } else {
                                            const snackBar = SnackBar(
                                                backgroundColor: Colors.red,
                                                content: Text(
                                                    'Please select payment method'),
                                                duration: Duration(seconds: 1));

                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(snackBar);
                                          }

                                          //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const PlaceOrderScreen()));
                                        },
                                        child: Container(
                                          height: 7.h,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              begin: Alignment.bottomRight,
                                              colors: [
                                                MyColors.yellow.withOpacity(.4),
                                                MyColors.yellow.withOpacity(.5),
                                              ],
                                            ),
                                            border: Border.all(
                                                width: 1, color: MyColors.brown),
                                            borderRadius: const BorderRadius.only(
                                              bottomLeft: Radius.circular(20),
                                              topLeft: Radius.circular(20),
                                            ),
                                          ),
                                          child: Center(
                                            child: AutoSizeText(
                                              "Place Order",
                                              textAlign: TextAlign.start,
                                              style: AppTextStyle.spiceShackFonts(
                                                style: TextStyle(
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.w800,
                                                  color: MyColors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  /*if(cart.cardCount == 1)...[
                                    Positioned(
                                      child: Align(
                                        alignment: Alignment.bottomCenter,
                                        child: GestureDetector(
                                          onTap: () {
                                            if (cart.likeCount == 1 || cart.payCount == 1) {
                                              order = valueProvider.getTotalPrice
                                                  .toString();
                                              oderDataPost();
                                              cart.placeApply();
                                              cart.placeLike();
                                              cart.placePay();

                                              Navigator.pushAndRemoveUntil(context,
                                                  MaterialPageRoute(builder:
                                                      (BuildContext context) {
                                                    return const PlaceOrderScreen();
                                                  }), (r) {
                                                    return false;
                                                  });
                                              if (cart.loadDAtaAPi == 2) {
                                              } else {
                                                const CircularProgressIndicator();
                                              }
                                            } else {
                                              const snackBar = SnackBar(
                                                  backgroundColor: Colors.red,
                                                  content: Text(
                                                      'Please select payment method'),
                                                  duration: Duration(seconds: 1));

                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(snackBar);
                                            }

                                            //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const PlaceOrderScreen()));
                                          },
                                          child: Container(
                                            height: 7.h,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                begin: Alignment.bottomRight,
                                                colors: [
                                                  MyColors.yellow.withOpacity(.4),
                                                  MyColors.yellow.withOpacity(.5),
                                                ],
                                              ),
                                              border: Border.all(
                                                  width: 1, color: MyColors.brown),
                                              borderRadius: const BorderRadius.only(
                                                bottomLeft: Radius.circular(20),
                                                topLeft: Radius.circular(20),
                                              ),
                                            ),
                                            child: Center(
                                              child: AutoSizeText(
                                                "Place Order",
                                                textAlign: TextAlign.start,
                                                style: AppTextStyle.spiceShackFonts(
                                                  style: TextStyle(
                                                    fontSize: 16.sp,
                                                    fontWeight: FontWeight.w800,
                                                    color: MyColors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),

                                  ]else...[
                                    CircularProgressIndicator(),
                                  ]*/
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Future<void> makePayment(String value) async {
    final likesData = Provider.of<ProductCategoriesProvider>(context, listen: false);
 /*   int valueInInt;
    // if(billTotal == "$billTotal.0"){
    //   double value = double.parse(billTotal);
    //   valueInInt = value.toInt();
    //   print("________");
    //   print(valueInInt);
    // }else {
    //   double value = double.parse(billTotal);
    //   double roundedValue = value.roundToDouble();
    //   roundedValue == value ? 0.0 : (roundedValue + 1) - value;
    //   valueInInt = roundedValue.toInt();
    // }
    double value = double.parse(billTotal);
    valueInInt = value.toInt();
    print(valueInInt);
    //coupon
   // double valueCoupon = double.parse(billTotalCoupon);
    // double roundedValueCoupon = valueCoupon.roundToDouble();
    // roundedValueCoupon == valueCoupon ? 0.0 : (roundedValueCoupon + 1) - valueCoupon;
   // int valueInIntCoupon = valueCoupon.toInt();
    print(valueInInt);*/
    try {
      //String amount = likesData.isApply ?  billTotalCoupon.toString():valueInInt.toString();
      String amount = likesData.isApply ?  billTotalCoupon.toString():billTotal.toString();

      print(billTotal);
      //STEP 1: Create Payment Intent
      paymentIntentData = await createPaymentIntent('${amount}00', 'USD');

      //STEP 2: Initialize Payment Sheet
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  paymentIntentClientSecret: paymentIntentData![
                      'client_secret'], //Gotten from payment intent
                  style: ThemeMode.light,
                  merchantDisplayName: 'Ikay'))
          .then((value) {});

      //STEP 3: Display Payment sheet
      displayPaymentSheet(context);
    } catch (err) {
      throw Exception(err);
    }
  }

  createPaymentIntent(String amount, String currency) async {
    try {
      //Request body
      Map<String, dynamic> body = {
        'amount': amount,
        'currency': currency,
      };

      //Make post request to Stripe
      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer  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',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      return json.decode(response.body);
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  displayPaymentSheet(BuildContext context) async {
    final likesData = Provider.of<ProductCategoriesProvider>(context, listen: false);
    try {
      await Stripe.instance.presentPaymentSheet().then((value) {
        //Clear paymentIntent variable after successful payment
        paymentIntentData = null;
        likesData.togglePay();
      }).onError((error, stackTrace) {
        throw Exception(error);
      });
    } on StripeException catch (e) {
      print('Error is:---> $e');
    } catch (e) {
      print('$e');
    }
  }
}
/*  final searchController = TextEditingController();
  final String apiKey= "AIzaSyBkbciwxjBPr8JEcG_059veVzuSLbf4n9Y";
  String order = "";



  List<AutoCompletePrediction> placePredictions = [];
  Future<void> placesAutoComplete(String query) async {
    Uri uriPlaces = Uri.http(
      "maps.googleapis.com",
      'maps/api/place/autocomplete/json',
      {
        "input" : query,
        "key" : apiKey,
      }
    );
    String? response = await ProductsFunctionsApi.fetchUrl(uriPlaces);
    if(response!=null){
      if (kDebugMode) {
        print("Places Response :- Is Empty -- ${response.toString()}");
      }
      PlacesAutoCompleteResponse result = PlacesAutoCompleteResponse.parseAutoCompleteResult(response);
      if(result.predictions !=null){
        setState(() {
          placePredictions = result.predictions!;
        });
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<ProductCategoriesProvider>(context);
    Map<String, String> someMap = {
      "first_name": profileName,
      "last_name": "",
      "company": "Spice Shack",
      "address_1": addressData,
      "address_2": addressData,
      "email": profileEmail,
      "country": "USA",
      "phone": phoneNumber,
    };
    Map<String, String> address = {
      "first_name": profileName,
      "last_name": "",
      "company": "Spice Shack",
      "address_1": addressData,
      "address_2": addressData,
      "phone": phoneNumber,
    };

    List movement = [
      for(int i=0;i<cart.cart.length;i++){

      "product_id": cart.idGrowableList[i],
      "quantity": cart.quantityList[i],
      "variation_id": int.parse(cart.variationId[i]),

      }
      */ /*{
      "product_id": 22,
      "quantity": 1
    }*/ /*

    ];
    List movementHere = [
      {
        "method_id": "flat_rate",
        "method_title": "Flat Rate",
        "total": "0.00"
      }

    ];

    void oderDataPost() async {
      var url = "https://spiceshackus.com/wp-json/wc/v3/orders?consumer key=ck_33fb5dae74953e8d8f552d2ff8cccc6b48bd3e51&consumer secret=cs_a87b5c5300da75bd2e7fc8876d09cb0ec3457f06";
      var data = {
        "shipping": address,
        "billing": someMap,
        "line_items": movement,
        "shipping_lines": movementHere,
      };

      var body = jsonEncode(data);
      var urlParse = Uri.parse(url);

      Response response =await http.post(
          urlParse,
          body: body,
          headers: {
            "content-Type":"application/json"
          }
      );
      cart.orderId = jsonDecode(response.body)['id'];
      if (kDebugMode) {
        print("Id of Order is here :- ${cart.orderId}");
      }


    }
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  height: 300,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: GradientsConstants.redGradient,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(60),
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Lottie.asset('assets/images/lottie/drawer.json'),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 7,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 18.0,right: 8.0),
                  child: Container(
                    decoration:  BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomRight,
                        colors: [
                          Colors.brown.withOpacity(.4),
                          Colors.black.withOpacity(.5),
                        ],
                      ),

                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60),
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          height: 10.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomRight,
                              colors: [
                                Colors.black.withOpacity(.4),
                                Colors.black.withOpacity(.5),
                              ],
                            ),
                            border: Border.all(width: 1,color: MyColors.brown),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(60),
                            ),
                          ),
                          child: Center(
                            child: AutoSizeText(
                              "Order Detail",
                              textAlign: TextAlign.center,
                              style: AppTextStyle.spiceShackFonts(
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                  color: MyColors.silver,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 8.0,
                            bottom: 8.0,
                          ),
                          child: Container(
                            height: 17.h,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              //gradient: GradientsConstants.goldGradient,
                              gradient: LinearGradient(
                                begin: Alignment.bottomRight,
                                colors: [
                                  Colors.black.withOpacity(.4),
                                  Colors.black.withOpacity(.5),
                                ],
                              ),
                            ),
                            child: Stack(
                              children: [
                                Positioned(
                                  child: Align(
                                    alignment: Alignment.topCenter,
                                    child: Container(
                                      height: 8.h,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.bottomRight,
                                          colors: [
                                            Colors.black.withOpacity(.4),
                                            Colors.black.withOpacity(.5),
                                          ],
                                        ),

                                        border: Border.all(width: 1,color: MyColors.brown),
                                        borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(20),
                                          topLeft: Radius.circular(20),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8.0, horizontal: 15.0),
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                              children: [
                                                AutoSizeText(
                                                  "Email :",
                                                  textAlign: TextAlign.start,
                                                  style: AppTextStyle
                                                      .spiceShackFonts(
                                                    style: TextStyle(
                                                      fontSize: 12.sp,
                                                      fontWeight:
                                                      FontWeight.w600,
                                                      color: MyColors.white,
                                                    ),
                                                  ),
                                                ),

                                                if(valueProvider.stateEmail.isNotEmpty)...[
                                                  AutoSizeText(
                                                    valueProvider.stateEmail,
                                                    textAlign: TextAlign.end,
                                                    style: AppTextStyle
                                                        .spiceShackFonts(
                                                      style: TextStyle(
                                                        fontSize: 12.sp,
                                                        fontWeight:
                                                        FontWeight.w600,
                                                        color: MyColors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                                if(valueProvider.stateEmail.isEmpty)...[
                                                  AutoSizeText(
                                                    valueProvider.temp!.email,
                                                    textAlign: TextAlign.end,
                                                    style: AppTextStyle
                                                        .spiceShackFonts(
                                                      style: TextStyle(
                                                        fontSize: 12.sp,
                                                        fontWeight:
                                                        FontWeight.w600,
                                                        color: MyColors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                      height: 7.h,
                                      width: double.infinity,
                                      decoration:  BoxDecoration(
                                        color: Colors.transparent,
                                        border: Border.all(width: 1,color: MyColors.brown),
                                        borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(20),
                                          topLeft: Radius.circular(20),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          AutoSizeText(
                                            "Total :",
                                            textAlign: TextAlign.start,
                                            style: AppTextStyle.spiceShackFonts(
                                              style: TextStyle(
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w800,
                                                color: MyColors.white,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5.w,
                                          ),
                                          Consumer<ProductCategoriesProvider>(
                                            builder: (BuildContext context, value,
                                                Widget? child) {
                                              final ValueNotifier<int?> totalPrice =
                                              ValueNotifier(null);
                                              for (var element in value.cart) {
                                                totalPrice.value =
                                                    (element.productPrice! *
                                                        element.quantity!.value) +
                                                        (totalPrice.value ?? 0);
                                              }
                                              if (kDebugMode) {
                                                print("Total billTotal: --------- $billTotal");
                                              }
                                              return ValueListenableBuilder<int?>(
                                                  valueListenable:
                                                  totalPrice,
                                                  builder: (context, val,
                                                      child) {
                                                    return AutoSizeText(
                                                      "\$ ${(val?.toStringAsFixed(
                                                          2) ??
                                                          '0')} ",
                                                      textAlign: TextAlign.end,
                                                      style: AppTextStyle
                                                          .spiceShackFonts(
                                                        style: TextStyle(
                                                          fontSize: 12.sp,
                                                          fontWeight:
                                                          FontWeight.w600,
                                                          color: MyColors.white,
                                                        ),
                                                      ),
                                                    );
                                                  });
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: 20.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(width: 1,color: MyColors.brown),
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              topLeft: Radius.circular(20),
                            ),
                          ),
                          child: Stack(
                            children: [
                              Padding(
                                padding:  const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 8.h,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.bottomRight,
                                      colors: [
                                        Colors.black.withOpacity(.4),
                                        Colors.black.withOpacity(.5),
                                      ],
                                    ),
                                    border: Border.all(width: 1,color: Colors.brown, ),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Center(
                                    child: RichText(
                                      textAlign: TextAlign.center,
                                      text: TextSpan(
                                        text: "Current Address :",
                                        style: AppTextStyle.spiceShackFonts(
                                          style: TextStyle(
                                            fontSize: 9.sp,
                                            fontWeight: FontWeight.w600,
                                            color: MyColors.white,
                                          ),
                                        ),
                                        children: [
                                          TextSpan(
                                            text: '\t ',
                                            style: AppTextStyle.spliceSans(
                                              style: TextStyle(
                                                  fontSize: 12.sp,
                                                  fontWeight:
                                                  FontWeight.bold),
                                            ),
                                          ),
                                          TextSpan(
                                            text: valueProvider.Address.toString(),
                                            style: AppTextStyle.spliceSans(
                                              style: TextStyle(
                                                fontSize: 9.sp,
                                                color: MyColors.yellow,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: 8.h,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.bottomRight,
                                          colors: [
                                            Colors.black.withOpacity(.4),
                                            Colors.black.withOpacity(.5),
                                          ],
                                        ),
                                        border: Border.all(width: 1,color: Colors.brown, ),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Center(
                                        child: RichText(
                                          textAlign: TextAlign.center,
                                          text: TextSpan(
                                            text: "Restaurant :",
                                            style: AppTextStyle.spiceShackFonts(
                                              style: TextStyle(
                                                fontSize: 13.sp,
                                                fontWeight: FontWeight.w600,
                                                color: MyColors.white,
                                              ),
                                            ),
                                            children: [
                                              TextSpan(
                                                text: '\t ',
                                                style: AppTextStyle.spliceSans(
                                                  style: TextStyle(
                                                      fontSize: 13.sp,
                                                      fontWeight:
                                                      FontWeight.bold),
                                                ),
                                              ),
                                              TextSpan(
                                                //text: valueProvider.searchLocation.toString(),
                                                text: "Spice Shack",
                                                style: AppTextStyle.spliceSans(
                                                  style: TextStyle(
                                                    fontSize: 13.sp,
                                                    color: MyColors.yellow,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                            ],
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
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 8.0,
                            bottom: 8.0,
                          ),
                          child: Container(
                            height: 17.h,
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              //gradient: GradientsConstants.goldGradient,
                                color: Colors.transparent
                              //borderRadius: BorderRadius.circular(30),
                            ),
                            child: Stack(
                              children: [
                                Positioned(
                                  child: Align(
                                    alignment: Alignment.topCenter,
                                    child: Container(
                                      height: 8.h,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        border: Border.all(width: 1,color: MyColors.brown),

                                        borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(20),
                                          topLeft: Radius.circular(20),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8.0, horizontal: 15.0),
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          children: [
                                            AutoSizeText(
                                              "Payment: Cash on delivery ",
                                              textAlign: TextAlign.start,
                                              style: AppTextStyle
                                                  .spiceShackFonts(
                                                style: TextStyle(
                                                  fontSize: 12.sp,
                                                  fontWeight:
                                                  FontWeight.w600,
                                                  color: MyColors.white,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: GestureDetector(
                                      onTap: (){
                                        // addressData =  valueProvider.Address.toString();
                                        order = valueProvider.getTotalPrice.toString();
                                        //print("Clicked $order");
                                        //valueProvider.oderDataPost();
                                        oderDataPost();
                                        // makePostRequest();

                                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context){
                                          return const PlaceOrderScreen();
                                        }), (r){
                                          return false;
                                        });
                                      },
                                      child: Container(
                                        height: 7.h,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.bottomRight,
                                            colors: [
                                              MyColors.yellow.withOpacity(.4),
                                              MyColors.yellow.withOpacity(.5),
                                            ],
                                          ),
                                          border: Border.all(width: 1,color: MyColors.brown),
                                          borderRadius: const BorderRadius.only(
                                            bottomLeft: Radius.circular(20),
                                            topLeft: Radius.circular(20),
                                          ),
                                        ),
                                        child: Center(
                                          child: AutoSizeText(
                                            "Place Order",
                                            textAlign: TextAlign.start,
                                            style: AppTextStyle.spiceShackFonts(
                                              style: TextStyle(
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w800,
                                                color: MyColors.white,
                                              ),
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
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });}
  }*/
