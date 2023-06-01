import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart' as https;
import 'package:http/http.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import '../../resources/colors/colors_resources.dart';
import '../../resources/colors/gradient_colors.dart';
import '../../resources/text/fonts.dart';
import '../../utils/resources/toast_message.dart';
import '../checkOut screen/model places api/prediction_auto_complete_places.dart';
import '../checkOut screen/model places api/prediction_model.dart';
import '../coupons data/coupons_data_model.dart';
import '../delivery screen/delivery_screen.dart';
import '../place order screen/place_order_screen.dart';
import '../products APi Functions/products_Functions_api.dart';
import '../products categories screen/providers/product_categories_provider.dart';
import 'guest_detail.dart';

class GuestCheckOutScreen extends StatefulWidget {
  const GuestCheckOutScreen({Key? key}) : super(key: key);

  @override
  State<GuestCheckOutScreen> createState() => _GuestCheckOutScreenState();
}

class _GuestCheckOutScreenState extends State<GuestCheckOutScreen> {

  bool loading = false;
  bool isBack = false;
  final searchController = TextEditingController();
  final promoController = TextEditingController();
  final String apiKey= "AIzaSyBkbciwxjBPr8JEcG_059veVzuSLbf4n9Y";
  String billTotal = '';
  String billTotalCoupon = '';
  int responseCode = 0;
  String order = "";

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
      "first_name": firstnameSignupGuest,
      "last_name": lastNameSignupGuest,
      "company": "Spice Shack",
      "address_1": addressData,
      "address_2": addressData,
      "email": emailSignupGuest,
      "country": "USA",
      "phone": userNameSignupGuest,
    };
    Map<String, String> address = {
      "first_name": firstnameSignupGuest,
      "last_name": lastNameSignupGuest,
      "company": "Spice Shack",
      "address_1": addressData,
      "address_2": addressData,
      "phone": userNameSignupGuest,
      "postcode": "94103",
      "state": "CA",
    };
    List movement = [

      for(int i=0;i<cart.cart.length;i++){

        "product_id": cart.idGrowableList[i],
        "quantity": cart.quantityList[i],

        if(cart.cart[i].varData.toString().isNotEmpty)
          "variation_id": cart.cart[i].varData.toString(),
          // "variation_id": cart.variationId[i].toString(),
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

      },
      // {
      //   "total": cart.isApply
      //       ?  billTotalCoupon:billTotal,
      // }






    ];
    List movementHere = [
      {"method_id": "flat_rate", "method_title": "Flat Rate", "total":  cart.isApply
          ?  billTotalCoupon:billTotal}
    ];
    var requestBody = json.encode({
      'status': 'completed',
    });

    List products = [];
    for(int i=0;i<cart.cart.length;i++) {
      Map<String, dynamic> product = {
        "product_id": cart.idGrowableList[i],
        "quantity": cart.quantityList[i]
      };
      if(cart.cart[i].varData.toString().isNotEmpty){
        product['variation_id'] = cart.cart[i].varData.toString();
        // "quantity": cart.varData[i]
        // product['variation_id'] = cart.variationId[i];

      }
      products.add(product);
    }
    void oderDataPost() async {

      var url =
          "https://spiceshackus.com/wp-json/wc/v3/orders?consumer key=ck_33fb5dae74953e8d8f552d2ff8cccc6b48bd3e51&consumer secret=cs_a87b5c5300da75bd2e7fc8876d09cb0ec3457f06";


      Map<String, dynamic> data = {
        'payment_method': 'stripe',
        'payment_method_title': 'Stripe',
        // 'set_paid': true,
        'needs_payment': false,
        //"status": "completed",
        "shipping": address,
        "billing": someMap,
        "line_items": movement,
        // "line_items": [
        //   {
        //     "product_id": 6170,
        //     "quantity": 1,
        //     "meta_data": [
        //       {
        //         "id": 3051,
        //         "key": "Appetizers - I",
        //         "value": "Veg Samosa",
        //       },
        //       {  "id": 3060,
        //         "key": "Spoon, Fork, Napkins (0.25)",
        //         "value": "1",
        //
        //       },
        //     ],
        //     "total": "42.24",
        //   }
        // ],
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
      print(body);
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
        print("Id of Order is here :- ${cart.cart[0].productId.toString()}");
      }
    }

    // void oderDataPost() async {
    //   var url = "https://spiceshackus.com/wp-json/wc/v3/orders?consumer key=ck_33fb5dae74953e8d8f552d2ff8cccc6b48bd3e51&consumer secret=cs_a87b5c5300da75bd2e7fc8876d09cb0ec3457f06";
    //   // var data = {
    //   //   "shipping": address,
    //   //   "billing": someMap,
    //   //   "line_items": movement,
    //   //   "shipping_lines": movementHere,
    //   // };
    //   print('Cart Data is here :- ${cart.cart.length}');
    //   var data = {
    //
    //     "shipping": {
    //       "first_name": firstnameSignupGuest,
    //       "last_name": lastNameSignupGuest,
    //       "company": "Spice Shack",
    //       "address_1": addressData,
    //       "address_2": addressData,
    //       "phone": userNameSignupGuest,
    //       "postcode": "94103",
    //       "state": "CA",
    //       // "first_name": "John",
    //       // "last_name": "Doe",
    //       // "address_1": "969 Market",
    //       // "address_2": "",
    //       "city": "San Francisco"
    //       // "state": "CA",
    //       // "postcode": "94103",
    //       // "country": "US"
    //     },
    //     "billing":{
    //       "first_name": firstnameSignupGuest,
    //       "last_name": lastNameSignupGuest,
    //      // "company": "Spice Shack",
    //       "address_1": addressData,
    //       "address_2": addressData,
    //       "email": emailSignupGuest,
    //       "country": "USA",
    //       "phone": userNameSignupGuest,
    //       // "first_name": "John",
    //       // "last_name": "Doe",
    //       // "address_1": "969 Market",
    //       // "address_2": "",
    //       "city": "San Francisco",
    //       "state": "CA",
    //       "postcode": "94103",
    //       // "country": "US",
    //       // "email": "john.doe@example.com",
    //       // "phone": "(555) 555-5555"
    //     },
    //     "line_items": [
    //       {"product_id": 93, "quantity": 2},
    //       {"product_id": 22, "variation_id": 23, "quantity": 1}
    //     ],
    //     // "line_items":[
    //     //   // {
    //     //   //   for(int i=0;i<cart.cart.length;i++){
    //     //   //
    //     //   //     "product_id": cart.idGrowableList[i],
    //     //   //     "quantity": cart.quantityList[i],
    //     //   //     "variation_id": cart.variationId[i],
    //     //   //
    //     //   //   }
    //     //   //
    //     //   // }
    //     //   //
    //     //   //     for(int i=0;i<2;i++){
    //     //   //
    //     //   //         "product_id": cart.idGrowableList[i],
    //     //   //         "quantity": cart.quantityList[i],
    //     //   //         "variation_id": cart.variationId[i],}
    //     //
    //     //
    //     //
    //     //       {
    //     //     "product_id": cart.idGrowableList[0],
    //     //     "quantity": cart.quantityList[0]
    //     //   },
    //     //   {
    //     //     "product_id": cart.idGrowableList[1],
    //     //     "quantity": cart.quantityList[1]
    //     //   },
    //     // ],
    //     "shipping_lines": [
    //       {
    //         "method_id": "flat_rate",
    //         "method_title": "Flat Rate",
    //         "total": "10.00"
    //       }
    //     ],
    //   };
    //
    //
    //   // Map<String, dynamic> map = [
    //   //   "fthg" : 78,
    //   //   "buh",
    //   // ];
    //   var body = jsonEncode(data);
    //   var urlParse = Uri.parse(url);
    //   Response response =await http.post(
    //       urlParse,
    //       body: body,
    //       headers: {
    //         "content-Type":"application/json"
    //       }
    //   );
    //   cart.loadDataAPi = 1;
    //   jsonDecode(response.body);
    //   cart.orderId = jsonDecode(response.body)['id'];
    //   if (kDebugMode) {
    //     print("Response Code :-${response.statusCode}");
    //   }
    //   if (response.statusCode == 201) {
    //     cart.loadDataAPi = 2;
    //
    //   }
    //   cart.loadDataAPi = 1;
    //   if (kDebugMode) {
    //     print("Id of Order is here :- ${cart.orderId}");
    //   }
    //
    //
    // }



    checkFromApi() async {

      //Ramadan------------------------------------------
      //const String apiUrl = "https://spiceshackus.com/wp-json/wc/v3/products?consumer key=ck_33fb5dae74953e8d8f552d2ff8cccc6b48bd3e51&consumer secret=cs_a87b5c5300da75bd2e7fc8876d09cb0ec3457f06&category=103&per page=100";

      var result = await https.get(Uri.parse("https://spiceshackus.com/wp-json/wc-pimwick/v1/pw-gift-cards?consumer key=ck_33fb5dae74953e8d8f552d2ff8cccc6b48bd3e51&consumer secret=cs_a87b5c5300da75bd2e7fc8876d09cb0ec3457f06&number=H89F-UNJ6-KHNU-QMPY"));

      // final data = jsonDecode(result.body);
      // var productChoices = data['number'];
      //
      // print("__________________________ List Data __________________{");
      print(jsonDecode(result.body));

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
                                                        emailSignupGuest,
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
                                                          return AutoSizeText(
                                                            cart.isApply
                                                                ?  "\$ $billTotalCoupon":
                                                            "\$ ${billTotal} ",
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
                                                          text: "Coupon : Applied",
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
                                                      /*onTap: () async {
                                                        onButtonClick();
                                                        //print('movement : data :- $movement');
                                                        //Coupons list
                                                        *//*List<CouponsModel> coupons = await ProductsFunctionsApi().getCouponsData();
                                                        valueProvider.updateCoupon(coupons);*//*

                                                        List<CouponsModel> coupons= await ProductsFunctionsApi().getCouponsData("H89F-UNJ6-KHNU-QMPY");
                                                        Provider.of<ProductCategoriesProvider>(context,listen: false).updateCoupon(coupons);

                                                       // checkFromApi();
                                                        print("---------");
                                                        print("Amount of coupon :- ${cart.couponsData[0].balance}");
                                                        // print("Amount of coupon :- ${cart.couponsData[0].number.toString()}");
                                                        // print("Number of coupon :- ${cart.couponsData[0].balance.toString()}");
                                                        if(promoController.text.toString() == 'SPICY30' && double.parse(billTotal) >=  30.0){
                                                          cart.toggleApply();
                                                        }
                                                      },*/
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
                                                          
                                                          if (cart.payCount == 1) {
                                                          } else {
                                                            makePayment();
                                                          }
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

    /*return Consumer<ProductCategoriesProvider>(
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

                                                    AutoSizeText(
                                                      emailSignupGuest,
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
                                                  billTotal = totalPrice.value.toString();
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
                                            borderRadius: BorderRadius.circular(15),
                                          ),
                                          child: Row(
                                            children: [
                                              Expanded(
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
                                                    onTap: (){

                                                      if(promoController.text.toString() == 'SPICE30'){
                                                        double value = 100.0; // Replace 100.0 with your desired value
                                                        double tenPercent = value * 0.1;
                                                        print("10% of $value is $tenPercent");
                                                        cart.toggleApply();
                                                        promoController.clear();
                                                      }
                                                      // else if(promoController.text.isEmpty){
                                                      //   const snackBar = SnackBar(
                                                      //       backgroundColor: Colors.red,
                                                      //       content: Text(
                                                      //           'Enter promo code'),
                                                      //       duration: Duration(seconds: 1));
                                                      //
                                                      //   ScaffoldMessenger.of(context)
                                                      //       .showSnackBar(snackBar);
                                                      // }else{
                                                      //   const snackBar = SnackBar(
                                                      //       backgroundColor: Colors.red,
                                                      //       content: Text(
                                                      //           'Invalid promo code'),
                                                      //       duration: Duration(seconds: 1));
                                                      //
                                                      //   ScaffoldMessenger.of(context)
                                                      //       .showSnackBar(snackBar);
                                                      // }

                                                      // promo(promoController.text.toString());
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
                                            border: Border.all(width: 1,color: MyColors.brown),

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
                                                    padding: const EdgeInsets.only(right: 8.0),
                                                    child: InkWell(
                                                      onTap: (){
                                                        if(_payCount == 1){

                                                        }else{
                                                          _toggleLike();
                                                        }
                                                      },
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                          color:  _isLiked ? Colors.red.shade400 : Colors.white,
                                                          borderRadius: BorderRadius.circular(15),
                                                        ),
                                                        child: Center(
                                                          child: AutoSizeText(
                                                            "Cash on delivery ",
                                                            textAlign: TextAlign.center,
                                                            style: AppTextStyle
                                                                .spiceShackFonts(
                                                              style: TextStyle(
                                                                fontSize: 12.sp,
                                                                fontWeight:
                                                                FontWeight.w600,
                                                                color: _isLiked ? Colors.white : MyColors.black,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(left: 8.0),
                                                    child: InkWell(
                                                      onTap: (){
                                                        if(_payCount == 1){

                                                        }else{
                                                          makePayment();
                                                        }

                                                      },
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                          color: _isPay ? Colors.red.shade400 : Colors.white,
                                                          borderRadius: BorderRadius.circular(15),
                                                        ),
                                                        child: Center(
                                                          child: AutoSizeText(
                                                            "Stripe Pay",
                                                            textAlign: TextAlign.center,
                                                            style: AppTextStyle
                                                                .spiceShackFonts(
                                                              style: TextStyle(
                                                                fontSize: 12.sp,
                                                                fontWeight:
                                                                FontWeight.w600,
                                                                color: _isPay ? Colors.white : MyColors.black,
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
                                      ),
                                    ),
                                    Positioned(
                                      child: Align(
                                        alignment: Alignment.bottomCenter,
                                        child: GestureDetector(
                                          onTap: (){
                                            if(_likeCount == 1 || _payCount == 1){
                                              order = valueProvider.getTotalPrice.toString();
                                              oderDataPost();
                                              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context){
                                                return const PlaceOrderScreen();
                                              }), (r){
                                                return false;
                                              });
                                              if(cart.loadDAtaAPi == 2){

                                              }else{
                                                const CircularProgressIndicator();
                                              }
                                            }else{

                                              const snackBar = SnackBar(
                                                  backgroundColor:
                                                  Colors.red,
                                                  content: Text(
                                                      'Please select payment method'),
                                                  duration: Duration(
                                                      seconds:
                                                      1));

                                              ScaffoldMessenger
                                                  .of(context)
                                                  .showSnackBar(
                                                  snackBar);
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
        });*/
  }

  Future<void> makePayment() async {
    final likesData = Provider.of<ProductCategoriesProvider>(context, listen: false);
    /*double value = double.parse(billTotal);
    double roundedValue = value.roundToDouble();
    roundedValue == value ? 0.0 : (roundedValue + 1) - value;
    int valueInInt = roundedValue.toInt();
    //coupon
    double valueCoupon = double.parse(billTotalCoupon);
    double roundedValueCoupon = valueCoupon.roundToDouble();
    roundedValueCoupon == valueCoupon ? 0.0 : (roundedValueCoupon + 1) - valueCoupon;
    int valueInIntCoupon = roundedValueCoupon.toInt();
    print(valueInInt);*/
    try {
      //String amount = likesData.isApply ?  valueInIntCoupon.toString():valueInInt.toString();
      String amount = likesData.isApply ?  billTotalCoupon.toString():billTotal.toString();

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

  /*Future<void> makePayment() async {
    final likesData = Provider.of<ProductCategoriesProvider>(context, listen: false);

    try {
      String amount = likesData.isApply
          ?  billTotalCoupon:billTotal;
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
  }*/

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

