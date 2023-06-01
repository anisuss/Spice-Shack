import 'package:auto_size_text/auto_size_text.dart';
import 'package:badges/src/badge.dart' as badge;
import 'package:flutter/src/material/badge.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../resources/colors/colors_resources.dart';
import '../../resources/colors/gradient_colors.dart';
import '../../resources/text/fonts.dart';
import '../../screens/cart screen/cart_screen.dart';
import '../../screens/categories list screen/model/cartCategroiesModel.dart';
import '../../screens/categories list screen/model/db_helper_categories.dart';
import '../../screens/products categories screen/providers/product_categories_provider.dart';
import '../../widgets/box/box.dart';
import '../../widgets/box/button.dart';

class EventCatering extends StatefulWidget {
  const EventCatering({Key? key}) : super(key: key);

  @override
  State<EventCatering> createState() => _EventCateringState();
}

String _variationId1 = '';

String get variationId1 => _variationId1;
String _variationId2 = '';

String get variationId2 => _variationId2;
String _productIdOfValidation = '';

String get productIdOfValidation => _productIdOfValidation;

class _EventCateringState extends State<EventCatering> {
  DBHelperStatic? dbHelper = DBHelperStatic();

  set variationId1(String value) {
    _variationId1 = value;
  }

  set variationId2(String value) {
    _variationId2 = value;
  }

  set productIdOfValidation(String value) {
    _productIdOfValidation = value;
  }
  var result;
  @override
  Widget build(BuildContext context) {
    final valueProvider =
        Provider.of<ProductCategoriesProvider>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: Container(
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
            children: [
              Stack(
                children: [
                  Container(
                    height: 25.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: GradientsConstants.blackGradient,
                      image: const DecorationImage(
                        image: AssetImage(
                          'assets/images/backgrounds/event.jpg',
                        ),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(30),
                        bottomLeft: Radius.circular(30),
                      ),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(30),
                          bottomLeft: Radius.circular(30),
                        ),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          colors: [
                            Colors.black.withOpacity(.4),
                            Colors.black.withOpacity(.2),
                          ],
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: MyColors.silver),
                                gradient: LinearGradient(
                                  begin: Alignment.bottomRight,
                                  colors: [
                                    Colors.black.withOpacity(.4),
                                    Colors.black.withOpacity(.5),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white),
                            child: Container(
                              height: 8.h,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.bottomRight,
                                    colors: [
                                      Colors.black.withOpacity(.4),
                                      Colors.black.withOpacity(.5),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white),
                              child: Center(
                                child: AutoSizeText(
                                  'Event Catering',
                                  style: AppTextStyle.spiceShackFonts(
                                    style: TextStyle(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.bold,
                                      color: MyColors.silver,
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
                  Positioned(
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(28.0),
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.backspace_outlined,
                            size: 3.h,
                            color: MyColors.silver,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.all(28.0),
                        child: TextButton(
                          onPressed: () async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const CartScreen(),
                              ),
                            );
                          },
                          child: badge.Badge(
                            badgeContent: Text(
                                valueProvider.getCounter().toString(),
                                style: const TextStyle(color: Colors.white)),
                            showBadge: true,
                            child: Icon(
                              Icons.shopping_bag_outlined,
                              size: 3.h,
                              color: MyColors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              if (valueProvider.loadEvent == 0)
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 48.0, horizontal: 20.0),
                  child: SizedBox(
                    height: 40.h,
                    width: 40.h,
                    child: Lottie.asset('assets/images/lottie/loader.json'),
                  ),
                ),
              Expanded(
                child: ListView.builder(
                    itemCount: valueProvider.cateringEventList.length,
                    itemBuilder: (context, index) {
                      for (int i = 0; i < 2; i++) {
                        valueProvider.selectedFeastValue.add("Half Tray");
                      }
                      for (int i = 0;
                          i < valueProvider.cateringEventList.length;
                          i++) {
                        if (valueProvider.feastValidate.length <=
                            valueProvider.cateringEventList.length) {
                          valueProvider.feastValidate.add(true);
                        }
                      }

                      return Column(
                        children: [
                          BoxWidget(
                            image: valueProvider.cateringEventList[index].images![0]['src'].toString(),
                            price: valueProvider.feastValidate[index]
                                ? "${valueProvider.cateringEventList[index].price.toString()}.00" : Bidi.stripHtmlIfNeeded(valueProvider.cateringEventList[index].price_html.toString().replaceAll("${valueProvider.cateringEventList[index].price}.00", '').replaceAll(RegExp(r'\s+'), '')).trim(),
                            productName: valueProvider.cateringEventList[index].name.toString(),
                          ),


                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 16.h,
                                  decoration: BoxDecoration(
                                    color: Colors.red.shade400,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: DropdownButton(
                                      elevation: 0,
                                      alignment: Alignment.center,
                                      underline: DropdownButtonHideUnderline(
                                          child: Container()),
                                      dropdownColor:
                                          Colors.black.withOpacity(0.8),
                                      iconSize: 13.sp,
                                      icon: Icon(
                                        Icons.arrow_drop_down,
                                        color: MyColors.silver,
                                      ),
                                      isExpanded: true,
                                      style: TextStyle(
                                          fontStyle: FontStyle.normal,
                                          fontSize: 8.sp,
                                          color: MyColors.silver,
                                          fontWeight: FontWeight.w500),
                                      value: valueProvider
                                          .selectedFeastValue[index]
                                          .toString(),
                                      items: valueProvider.dropDownFeastItem(),
                                      onChanged: (String? newValue) {
                                        valueProvider.selectedFeastValue[index] = newValue!;
                                        valueProvider.toggleFeastValidate(index);
                                        setState(() {});
                                      },
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: GestureDetector(
                                    onTap: () {

                                      print(valueProvider.cateringEventList[index].variations![1].toString());
                                      dbHelper!.insert(
                                        ProductModel(
                                          id: (index + 1),
                                          productId: valueProvider.cateringEventList[index].id.toString(),
                                          name: valueProvider.cateringEventList[index].name.toString(),
                                          initialPrice: valueProvider.feastValidate[index]?double.parse(valueProvider.cateringEventList[index].price.toString()):double.parse(Bidi.stripHtmlIfNeeded(valueProvider.cateringEventList[index].price_html.toString().replaceAll("${valueProvider.cateringEventList[index].price}.00", '').replaceAll(RegExp(r'\s+'), '')).trim()).toDouble(),
                                          productPrice: valueProvider.feastValidate[index]?double.parse(valueProvider.cateringEventList[index].price.toString()):double.parse(Bidi.stripHtmlIfNeeded(valueProvider.cateringEventList[index].price_html.toString().replaceAll("${valueProvider.cateringEventList[index].price}.00", '').replaceAll(RegExp(r'\s+'), '')).trim()).toDouble(),
                                          quantity: 1,
                                          image: valueProvider.cateringEventList[index].images![0]["src"].toString(),
                                          varData: valueProvider.feastValidate[index]?valueProvider.cateringEventList[index].variations![0].toString():valueProvider.cateringEventList[index].variations![1].toString(),
                                        ),
                                      )
                                          .then((value) {
                                        valueProvider.addTotalPrice(valueProvider.feastValidate[index]?double.parse(valueProvider.cateringEventList[index].price.toString()):double.parse(Bidi.stripHtmlIfNeeded(valueProvider.cateringEventList[index].price_html.toString().replaceAll("${valueProvider.cateringEventList[index].price}.00", '').replaceAll(RegExp(r'\s+'), '')).trim())
                                        );
                                        valueProvider.addCounter();
                                        setState(() {

                                        });

                                        const snackBar = SnackBar(
                                          backgroundColor: Colors.green,
                                          content:
                                              Text('Product is added to cart'),
                                          duration: Duration(microseconds: 100),
                                        );

                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar);
                                      }).onError((error, stackTrace) {
                                        if (kDebugMode) {
                                          print("error$error");
                                        }
                                        const snackBar = SnackBar(
                                            backgroundColor: Colors.red,
                                            content: Text(
                                                'Product is already added in cart'),
                                            duration:
                                                Duration(microseconds: 100));

                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar);
                                      });
                                    },
                                    child: Container(
                                      height: 6.h,
                                      width: 20.h,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: Colors.white),
                                      child: Row(
                                        children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: AutoSizeText(
                            "Add to cart",
                            textAlign: TextAlign.start,
                            style: AppTextStyle.spiceShackFonts(
                              style: TextStyle(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0XFF033354),
                              ),
                            ),),
                      ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Lottie.asset(
                                                'assets/images/lottie/cart.json'),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
