import 'dart:convert';
import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:spice_shack/screens/profile%20screen/profile_screen.dart';
import 'package:spice_shack/widgets/navigation%20bar/navigation_bar_widget.dart';

import '../../resources/colors/colors_resources.dart';
import '../../resources/text/fonts.dart';
import '../products categories screen/providers/product_categories_provider.dart';

class GiftCardScreen extends StatefulWidget {
  const GiftCardScreen({Key? key}) : super(key: key);

  @override
  State<GiftCardScreen> createState() => _GiftCardScreenState();
}
String _giftCardBill = '';
String get  giftCardBill  => _giftCardBill ;
class _GiftCardScreenState extends State<GiftCardScreen> {
  set giftCardBill (String value) {
    _giftCardBill  = value;
  }
  final fromNameController = TextEditingController();
  final toEmailController = TextEditingController();
  final fromEmailController = TextEditingController();
  final priceController = TextEditingController();
  final messageController = TextEditingController();

  void clear(){
    fromNameController.clear();
    toEmailController.clear();
    fromEmailController.clear();
    priceController.clear();
    messageController.clear();
  }
  Map<String, dynamic>? paymentIntentData;
  Map<String, dynamic>? giftCardIntentData;

  @override
  Widget build(BuildContext context) {
    bool isValidResponse = false;


    final couponProviders = Provider.of<ProductCategoriesProvider>(context, listen: false);
    void giftOrderPost() async {
      var url =
          "https://spiceshackus.com/wp-json/wc-pimwick/v1/pw-gift-cards?consumer key=ck_33fb5dae74953e8d8f552d2ff8cccc6b48bd3e51&consumer secret=cs_a87b5c5300da75bd2e7fc8876d09cb0ec3457f06";

      // List args = [
      //  {
      //       'quantity': 1,
      //       'amount': 22,
      //       'expiration_date': '12-2-2024',
      //       'send_email': 'true',
      //       'recipient_email': 'moon@gmail.com',
      //       'from': 'moon'
      //     }
      // ];
      // print(args);
      var args = <String, dynamic>{};
      args['amount'] = priceController.text;
      args['send_email'] = true;
      args['recipient_email'] = toEmailController.text;
      args['from'] = fromNameController.text;
      var body = jsonEncode(args);
      print(body);
      var urlParse = Uri.parse(url);
      Response response = await http.post(urlParse,
          body: body, headers: {'content-type':'application/json','Cookie': 'woolentor_viewed_products_list=a%3A1%3A%7Bi%3A1677783329%3Bi%3A6000%3B%7D'});

      jsonDecode(response.body);

      if (kDebugMode) {
        print("Response Code :-${response.statusCode}");
        print("Response  :-${response.body}");
      }
    }

    // Map<String, String> someMap = {
    //   "first_name": fromNameController.text,
    //   "last_name": "",
    //   "company": "Gift Card",
    //   "address_1": "Spice Shack",
    //   "address_2": "Spice Shack",
    //   "email": fromEmailController.text.toString(),
    //   "country": "USA",
    //   "phone": "none",
    // };
    // Map<String, String> address = {
    //   "first_name": fromNameController.text.toString(),
    //   "last_name": "",
    //   "company": "Gift Card",
    //   "address_1": "Spice Shack",
    //   "address_2": "Spice Shack",
    //   "phone": 'none',
    // };
    // List movementHere = [
    //   {"method_id": "flat_rate", "method_title": "Flat Rate", "total": "${priceController.text}.00"}
    // ];

  /*  void oderDataPost() async {

      var url =
          "https://spiceshackus.com/wp-json/wc/v3/orders?consumer key=ck_33fb5dae74953e8d8f552d2ff8cccc6b48bd3e51&consumer secret=cs_a87b5c5300da75bd2e7fc8876d09cb0ec3457f06";

      setState(() {
        isValidResponse = false;
      });
      Map<String, dynamic> data = {

        //"set_paid": true,
        //"status": "completed",
        "shipping": address,
        "billing": someMap,
        "shipping_lines": movementHere,
        //'subtotal': '50',
      };

      var body = jsonEncode(data);
      var urlParse = Uri.parse(url);
      Response response = await http.post(urlParse,
          body: body, headers: {"content-Type": "application/json"});
      if(response.statusCode == '201'){
        setState(() {
          isValidResponse = true;
        });
      }else{
        setState(() {
          isValidResponse = false;
        });
      }
      jsonDecode(response.body);
      if (kDebugMode) {
        print("Response Code Order:-${response.statusCode}");
        print("Response Order:-${response.body}");
      }
    }*/
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
                Padding(
                  padding: const EdgeInsets.only(left: 8.0,right: 8.0,top: 25.0,bottom: 8.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.2,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13),
                      image: const DecorationImage(
                        image: AssetImage(
                          'assets/images/cart backgrounds/gift.jpg',
                        ),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.1,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(13),
                        color: Colors.black.withOpacity(0.6),
                        border: Border.all(color: Colors.white)),
                    child: Center(
                      child: AutoSizeText(
                        "Gift Cards For Friends",
                        textAlign: TextAlign.center,
                        style: AppTextStyle.spiceShackFonts(
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: MyColors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.9,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(13),
                        color: Colors.black.withOpacity(0.6),
                        border: Border.all(color: Colors.white)),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 20.0, bottom: 10.0),
                          child: AutoSizeText(
                            "Enter Your Name",
                            textAlign: TextAlign.center,
                            style: AppTextStyle.spiceShackFonts(
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: MyColors.white,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          child: TextFormField(
                            style: TextStyle(color: MyColors.silver),
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                  color: MyColors.silver,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(color: MyColors.grey),
                              ),
                              hintText: "Enter your Name",
                              hintStyle: TextStyle(color: MyColors.grey),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            controller: fromNameController,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          child: AutoSizeText(
                            "Amount Of Gift Card",
                            textAlign: TextAlign.center,
                            style: AppTextStyle.spiceShackFonts(
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: MyColors.white,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          child: TextFormField(
                            style: TextStyle(color: MyColors.silver),
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                  color: MyColors.silver,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(color: MyColors.grey),
                              ),
                              hintText: "Enter Gift Card Amount",
                              hintStyle: TextStyle(color: MyColors.grey),
                            ),
                            keyboardType: TextInputType.number,
                            controller: priceController,
                          ),
                        ),
                        AutoSizeText(
                          "From",
                          textAlign: TextAlign.center,
                          style: AppTextStyle.spiceShackFonts(
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: MyColors.white,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          child: TextFormField(
                            style: TextStyle(color: MyColors.silver),
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                  color: MyColors.silver,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(color: MyColors.grey),
                              ),
                              hintText: "Enter your email address",
                              hintStyle: TextStyle(color: MyColors.grey),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            controller: fromEmailController,
                          ),
                        ),
                        AutoSizeText(
                          "To",
                          textAlign: TextAlign.center,
                          style: AppTextStyle.spiceShackFonts(
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: MyColors.white,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          child: TextFormField(
                            style: TextStyle(color: MyColors.silver),
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                  color: MyColors.silver,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(color: MyColors.grey),
                              ),
                              hintText: "Enter the recipient's email address",
                              hintStyle: TextStyle(color: MyColors.grey),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            controller: toEmailController,
                          ),
                        ),
                        // AutoSizeText(
                        //   "Gift Message",
                        //   textAlign: TextAlign.center,
                        //   style: AppTextStyle.spiceShackFonts(
                        //     style: TextStyle(
                        //       fontSize: 18,
                        //       fontWeight: FontWeight.w600,
                        //       color: MyColors.white,
                        //     ),
                        //   ),
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.symmetric(
                        //       vertical: 10.0, horizontal: 20.0),
                        //   child: TextFormField(
                        //     maxLines: 3,
                        //     style: TextStyle(color: MyColors.silver),
                        //     decoration: InputDecoration(
                        //       focusedBorder: OutlineInputBorder(
                        //         borderRadius: BorderRadius.circular(15),
                        //         borderSide: BorderSide(
                        //           color: MyColors.silver,
                        //         ),
                        //       ),
                        //       enabledBorder: OutlineInputBorder(
                        //         borderRadius: BorderRadius.circular(15),
                        //         borderSide: BorderSide(color: MyColors.grey),
                        //       ),
                        //       hintText: "Gift for you!",
                        //       hintStyle: TextStyle(color: MyColors.grey),
                        //     ),
                        //     keyboardType: TextInputType.multiline,
                        //     controller: messageController,
                        //   ),
                        // ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: ElevatedButton(
                            onPressed: (){
                             // giftOrderPost();
                              //oderDataPost();
                              makePayment();
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white.withOpacity(0.4),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 13.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(
                                    Icons.credit_card,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 8.0),
                                 Text(
                                    "Pay Now",
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        isValidResponse ?const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CircularProgressIndicator(),
                        ) : Text("Ok"),

                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String generateCouponCode(int length) {
    const chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890";
    Random rnd = Random();
    String code = "";
    for (var i = 0; i < length; i++) {
      code += chars[rnd.nextInt(chars.length)];
    }
    return code;
  }

  Future<void> makePayment() async {
    try {
      String amount = priceController.text.toString();
      //STEP 1: Create Payment Intent
      paymentIntentData = await createPaymentIntent('${amount}00', 'USD');
      // giftCardIntentData = await createGiftIntent();


      //STEP 2: Initialize Payment Sheet
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  paymentIntentClientSecret: paymentIntentData!['client_secret'],
                  //Gotten from payment intent
                  style: ThemeMode.dark,
                  merchantDisplayName: 'Moon'))
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
          'Authorization':
              'Bearer  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',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      return json.decode(response.body);
    } catch (err) {
      throw Exception(err.toString());
    }
  }
  createGiftIntent() async {
    try {
      //Request body
      Map<String, dynamic> body = {
        'amount': priceController.text,
        'send_email': "true",
        'recipient_email': toEmailController.text,
        'from': fromNameController.text,
      };

      //Make post request to Stripe
      var response = await http.post(
        Uri.parse('https://spiceshackus.com/wp-json/wc-pimwick/v1/pw-gift-cards?consumer key=ck_33fb5dae74953e8d8f552d2ff8cccc6b48bd3e51&consumer secret=cs_a87b5c5300da75bd2e7fc8876d09cb0ec3457f06'),
        body: body,
      );
      return json.decode(response.body);
    } catch (err) {
      throw Exception(err.toString());
    }
  }
  void giftOrderPost() async {
    try{
      var url =
          "https://spiceshackus.com/wp-json/wc-pimwick/v1/pw-gift-cards?consumer key=ck_33fb5dae74953e8d8f552d2ff8cccc6b48bd3e51&consumer secret=cs_a87b5c5300da75bd2e7fc8876d09cb0ec3457f06";

      // List args = [
      //  {
      //       'quantity': 1,
      //       'amount': 22,
      //       'expiration_date': '12-2-2024',
      //       'send_email': 'true',
      //       'recipient_email': 'moon@gmail.com',
      //       'from': 'moon'
      //     }
      // ];
      // print(args);
      var args = <String, dynamic>{};
      args['amount'] = priceController.text;
      args['send_email'] = true;
      args['recipient_email'] = toEmailController.text;
      args['from'] = fromNameController.text;
      var body = jsonEncode(args);
      print(body);
      var urlParse = Uri.parse(url);
      Response response = await http.post(urlParse,
          body: body, headers: {'content-type':'application/json','Cookie': 'woolentor_viewed_products_list=a%3A1%3A%7Bi%3A1677783329%3Bi%3A6000%3B%7D'});

      jsonDecode(response.body);

      if (kDebugMode) {
        print("Response Code :-${response.statusCode}");
        print("Response  :-${response.body}");
      }
    }catch(err){
      throw Exception(err.toString());
    }

  }
  displayPaymentSheet(BuildContext context) async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) {
        //Clear paymentIntent variable after successful payment
        giftOrderPost();
        paymentIntentData = null;
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
            const NavigationBarWidget()), (Route<dynamic> route) => false);
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
