import 'dart:async';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
import 'package:badges/src/badge.dart' as badge;

class CateringProductsScreen extends StatefulWidget {
  const CateringProductsScreen({Key? key}) : super(key: key);

  @override
  State<CateringProductsScreen> createState() => _CateringProductsScreenState();
}

String _variationId1 = '';
String get variationId1 => _variationId1;
String _variationId2 = '';
String get  variationId2 => _variationId2;
String _productIdOfValidation = '';
String get  productIdOfValidation  => _productIdOfValidation ;
class _CateringProductsScreenState extends State<CateringProductsScreen> {
  set variationId1(String value) {
    _variationId1 = value;
  }
  set variationId2(String value) {
    _variationId2 = value;
  }
  set productIdOfValidation (String value) {
    _productIdOfValidation  = value;
  }
  DBHelperStatic? dbHelper = DBHelperStatic();
  String html =
      '<div><p>Hello</p>This is <br/>fluttercampus.com<span>,Bye!</span></div>';

  final sliderImages = [
    'assets/images/backgrounds/food.jpg',
    'assets/images/cart backgrounds/food-5.jpg',
    'assets/images/cart backgrounds/food-6.jpg',
    'assets/images/cart backgrounds/food-7.jpg',
  ];

  String crypto = 'For 3 Persons';
  String pp = '26';
  String yy = '10';
  var currentCurrency = [
    "For 3 Persons",
    "For 5 Persons",
  ];

  @override
  void initState() {
    super.initState();
    context.read<ProductCategoriesProvider>().variationDetail();
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<ProductCategoriesProvider>(context);

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
          child: SafeArea(
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: 30.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: GradientsConstants.blackGradient,
                        image: const DecorationImage(
                          image: AssetImage(
                            'assets/images/backgrounds/cat_pro.jpg',
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
                                    "Add Catering Items",
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
                              Icons.arrow_back_ios_new_rounded,
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
                          child: GestureDetector(
                            onTap: () async {
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
                familyCateringProductsWidget(valueProvider),
                //cateringProductsList(valueProvider, cart),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget familyCateringProductsWidget(ProductCategoriesProvider valueProvider) {
    if (valueProvider.loadCatering == 0)
    {
      return Padding(
        padding: const EdgeInsets.symmetric(
            vertical: 48.0, horizontal: 20.0),
        child: SizedBox(
          height: 40.h,
          width: 40.h,
          child: Lottie.asset('assets/images/lottie/loader.json'),
        ),
      );
    }
    return Expanded(
      //cateringProductsList
      child: ListView.builder(
          itemCount: valueProvider.cateringProductsList.length,
          itemBuilder: (context, index) {
            for (int i = 0; i < 2; i++) {
              valueProvider.selectedItemValue.add("For 3 persons");
            }
            for (int i = 0;
            i < valueProvider.cateringProductsList.length;
            i++) {
              if (valueProvider.familyCateringValidate.length <=
                  valueProvider.cateringProductsList.length) {
                valueProvider.familyCateringValidate.add(true);
              }
            }

            return Column(
              children: [
                BoxWidget(
                  image: valueProvider.cateringProductsList[index].images![0]['src'].toString(),
                  price: valueProvider.familyCateringValidate[index]
                      ? "${valueProvider.cateringProductsList[index].price.toString()}.00" : Bidi.stripHtmlIfNeeded(valueProvider.cateringProductsList[index].price_html.toString().replaceAll("${valueProvider.cateringProductsList[index].price}.00", '').replaceAll(RegExp(r'\s+'), '')).trim(),
                  productName: valueProvider.cateringProductsList[index].name.toString(),
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
                                .selectedItemValue[index]
                                .toString(),
                            items: valueProvider.dropDownItem(),
                            onChanged: (String? newValue) {
                              valueProvider.selectedItemValue[index] = newValue!;
                              valueProvider.toggleFamilyCateringValidate(index);
                              setState(() {});
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: GestureDetector(
                          onTap: () {

                            print(valueProvider.cateringProductsList[index].variations![1].toString());
                            dbHelper!.insert(
                              ProductModel(
                                id: (index + 1),
                                productId: valueProvider.cateringProductsList[index].id.toString(),
                                name: valueProvider.cateringProductsList[index].name.toString(),
                                initialPrice: valueProvider.familyCateringValidate[index]?double.parse(valueProvider.cateringProductsList[index].price.toString()):double.parse(Bidi.stripHtmlIfNeeded(valueProvider.cateringProductsList[index].price_html.toString().replaceAll("${valueProvider.cateringProductsList[index].price}.00", '').replaceAll(RegExp(r'\s+'), '')).trim()).toDouble(),
                                productPrice: valueProvider.familyCateringValidate[index]?double.parse(valueProvider.cateringProductsList[index].price.toString()):double.parse(Bidi.stripHtmlIfNeeded(valueProvider.cateringProductsList[index].price_html.toString().replaceAll("${valueProvider.cateringProductsList[index].price}.00", '').replaceAll(RegExp(r'\s+'), '')).trim()).toDouble(),
                                quantity: 1,
                                image: valueProvider.cateringProductsList[index].images![0]["src"].toString(),
                                varData: valueProvider.familyCateringValidate[index]?valueProvider.cateringProductsList[index].variations![0].toString():valueProvider.cateringProductsList[index].variations![1].toString(),
                              ),
                            )
                                .then((value) {
                              valueProvider.addTotalPrice(valueProvider.familyCateringValidate[index]?double.parse(valueProvider.cateringProductsList[index].price.toString()):double.parse(Bidi.stripHtmlIfNeeded(valueProvider.cateringProductsList[index].price_html.toString().replaceAll("${valueProvider.cateringProductsList[index].price}.00", '').replaceAll(RegExp(r'\s+'), '')).trim())
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
    );
  }

  Widget cateringProductsList(ProductCategoriesProvider valueProvider, ProductCategoriesProvider cart) {
    if (valueProvider.loadCatering == 0)
      {
        return Padding(
          padding: const EdgeInsets.symmetric(
              vertical: 48.0, horizontal: 20.0),
          child: SizedBox(
            height: 40.h,
            width: 40.h,
            child: Lottie.asset('assets/images/lottie/loader.json'),
          ),
        );
      }
    return Expanded(
      child: ListView.builder(
          itemCount: valueProvider.cateringProductsList.length,
          itemBuilder: (context, index) {
            for (int i = 0; i < 2; i++) {
              cart.selectedItemValue.add("For 3 persons");
            }
            return Padding(
              padding: EdgeInsets.symmetric(
                  vertical: 5.0.sp, horizontal: 10.sp),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                            color: MyColors.silver, width: 2)),
                    height: 30.h,
                    child: Stack(
                      children: [
                        Container(
                          height: 30.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            image: DecorationImage(
                                image: imagesForBackground(
                                    valueProvider, index),
                                fit: BoxFit.cover),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: CachedNetworkImage(
                              placeholder: (context, url) =>
                                  Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.bottomRight,
                                    colors: [
                                      Colors.white.withOpacity(.4),
                                      Colors.brown.withOpacity(.5),
                                    ],
                                  ),
                                ),
                              ),
                              imageUrl: valueProvider
                                  .cateringProductsList[index]
                                  .images![0]['src']
                                  .toString(),
                              fit: BoxFit.cover,
                              key: UniqueKey(),
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            gradient: LinearGradient(
                              begin: Alignment.bottomRight,
                              colors: [
                                Colors.black.withOpacity(.6),
                                Colors.black.withOpacity(.4),
                              ],
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                            crossAxisAlignment:
                                CrossAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 8.0.sp,
                                    horizontal: 10.sp),
                                child: Text(
                                  Bidi.stripHtmlIfNeeded(
                                      valueProvider
                                          .cateringProductsList[
                                              index]
                                          .short_description
                                          .toString()),
                                  maxLines: 5,
                                  textAlign: TextAlign.left,
                                  style:
                                      AppTextStyle.spiceShackFonts(
                                    style: TextStyle(
                                      height: 1.2,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w600,
                                      color: MyColors.silver,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  valueProvider
                                      .cateringProductsList[index]
                                      .name
                                      .toString(),
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  style:
                                      AppTextStyle.spiceShackFonts(
                                    style: TextStyle(
                                      height: 1.2,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w600,
                                      color: MyColors.silver,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment
                                          .spaceBetween,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 16.h,
                                      decoration: BoxDecoration(
                                        color: Colors.red.shade400,
                                        borderRadius:
                                            BorderRadius.circular(
                                                10),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets
                                                .symmetric(
                                            horizontal: 8.0),
                                        child: DropdownButton(
                                          elevation: 0,
                                          alignment: Alignment.center,
                                          underline: DropdownButtonHideUnderline(
                                                  child: Container()),
                                          dropdownColor: Colors.black.withOpacity(0.8),
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
                                          value: cart.selectedItemValue[index].toString(),
                                          items: cart.dropDownItem(),
                                          onChanged:
                                              (String? newValue) {
                                            if(cart.selectedItemValue[index] == 'For 3 persons'){
                                              variationId1 = valueProvider.cateringProductsList[index].variations![0].toString();
                                            }else{
                                              variationId2 = valueProvider.cateringProductsList[index].variations![1].toString();
                                            }
                                            productIdOfValidation = valueProvider.cateringProductsList[index].id.toString();
                                            valueProvider.variationDetail();
                                                cart.selectedItemValue[index] = newValue!;
                                                setState(() {
                                                  valueProvider.newPriceVariation = valueProvider.priceVariation.replaceAll('"', '');
                                                });
                                          },

                                        ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        if(cart.selectedItemValue[index].toString() == "For 3 persons")...[
                                          Padding(
                                            padding:
                                            const EdgeInsets.all(
                                                8.0),
                                            child: Container(
                                              height: 6.h,
                                              width: 6.h,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius
                                                      .circular(
                                                      10),
                                                  color:
                                                  Colors.white),
                                              child: Center(
                                                child: Text(
                                                  "\$ ${valueProvider.cateringProductsList[index].price.toString()}",
                                                  style: AppTextStyle
                                                      .spiceShackFonts(
                                                    style:
                                                    TextStyle(
                                                      height: 1.2,
                                                      fontSize:
                                                      10.sp,
                                                      fontWeight:
                                                      FontWeight
                                                          .w600,
                                                      color: MyColors
                                                          .yellow,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ]else...[
                                          if(cart.loadVariation == 1)...[
                                            Padding(
                                              padding:
                                              const EdgeInsets.all(
                                                  8.0),
                                              child: Container(
                                                height: 6.h,
                                                width: 6.h,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius
                                                        .circular(
                                                        10),
                                                    color:
                                                    Colors.white),
                                                child: Center(
                                                  child:LayoutBuilder(builder: (context, constraints){
                                                    if(valueProvider.priceVariation.isEmpty){
                                                      return Text(
                                                        "\$ 45",
                                                        // "\$ ${valueProvider.cateringProductsList[index].price.toString()} String myString = "s, t, r";
                                                        //                         myString = myString.replaceAll(",", "");",
                                                        style: AppTextStyle
                                                            .spiceShackFonts(
                                                          style:
                                                          TextStyle(
                                                            height: 1.2,
                                                            fontSize:
                                                            10.sp,
                                                            fontWeight:
                                                            FontWeight
                                                                .w600,
                                                            color: MyColors
                                                                .yellow,
                                                          ),
                                                        ),
                                                      );
                                                    }else{
                                                      return Text(
                                                        "\$ ${valueProvider.priceVariation.replaceAll('"', '')}",
                                                        // "\$ ${valueProvider.cateringProductsList[index].price.toString()} String myString = "s, t, r";
                                                        //                         myString = myString.replaceAll(",", "");",
                                                        style: AppTextStyle
                                                            .spiceShackFonts(
                                                          style:
                                                          TextStyle(
                                                            height: 1.2,
                                                            fontSize:
                                                            10.sp,
                                                            fontWeight:
                                                            FontWeight
                                                                .w600,
                                                            color: MyColors
                                                                .yellow,
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                  }
                                                ),
                                              ),
                                            ),),
                                          ]else...[
                                            const CircularProgressIndicator(),
                                          ]
                                        ],
                                        Padding(
                                          padding:
                                              const EdgeInsets.all(
                                                  8.0),
                                          child: GestureDetector(
                                            onTap: () {
                                              if (kDebugMode) {
                                                print(index);
                                              }
                                              if (kDebugMode) {
                                                print(index);
                                              }
                                              if (kDebugMode) {
                                                print(valueProvider
                                                    .cateringProductsList[
                                                        index]
                                                    .name
                                                    .toString());
                                              }
                                              if (kDebugMode) {
                                                print(valueProvider
                                                    .cateringProductsList[
                                                        index]
                                                    .price
                                                    .toString());
                                              }
                                              if (kDebugMode) {
                                                print('1');
                                              }
                                              if(cart.selectedItemValue[index] == 'For 3 persons'){
                                                print(valueProvider.cateringProductsList[index].variations![1].toString());
                                                dbHelper!
                                                    .insert(
                                                  ProductModel(
                                                    id: (index + 1),
                                                    productId: valueProvider.cateringProductsList[index].id.toString(),
                                                    name: valueProvider.cateringProductsList[index].name.toString(),
                                                    initialPrice: double.parse(valueProvider.cateringProductsList[index].price.toString()),
                                                    productPrice: double.parse(valueProvider.cateringProductsList[index].price.toString()),
                                                    quantity: 1,
                                                    image: valueProvider.cateringProductsList[index].images![0]["src"].toString(),
                                                    varData: valueProvider.cateringProductsList[index].variations![0].toString(),
                                                  ),
                                                )
                                                    .then((value) {
                                                  valueProvider.addTotalPrice(
                                                      double.parse(valueProvider
                                                          .cateringProductsList[
                                                      index]
                                                          .price
                                                          .toString()));
                                                  valueProvider
                                                      .addCounter();

                                                  const snackBar =
                                                  SnackBar(
                                                    backgroundColor:
                                                    Colors.green,
                                                    content: Text(
                                                        'Product is added to cart'),
                                                    duration: Duration(
                                                        microseconds:
                                                        100),
                                                  );

                                                  ScaffoldMessenger
                                                      .of(context)
                                                      .showSnackBar(
                                                      snackBar);
                                                }).onError((error, stackTrace) {
                                                  if (kDebugMode) {
                                                    print(
                                                        "error$error");
                                                  }
                                                  const snackBar = SnackBar(
                                                      backgroundColor:
                                                      Colors.red,
                                                      content: Text(
                                                          'Product is already added in cart'),
                                                      duration: Duration(
                                                          microseconds:
                                                          100));

                                                  ScaffoldMessenger
                                                      .of(context)
                                                      .showSnackBar(
                                                      snackBar);
                                                });
                                              }else if(cart.selectedItemValue[index] == 'For 5 persons'){
                                                dbHelper!.insert(
                                                  ProductModel(
                                                    id: (index +
                                                        1),
                                                    productId: valueProvider.cateringProductsList[index].id.toString(),
                                                    name: valueProvider.cateringProductsList[index].name.toString(),
                                                    initialPrice: double.parse('45'),
                                                    productPrice: double.parse('45'),
                                                    quantity: 1,
                                                    //unitTag: "Empty",
                                                    image: valueProvider.cateringProductsList[index].images![0]["src"].toString(),
                                                    varData: valueProvider.cateringProductsList[index].variations![1].toString(),
                                                  ),
                                                )
                                                    .then((value) {
                                                  valueProvider.addTotalPrice(
                                                      double.parse(valueProvider
                                                          .cateringProductsList[
                                                      index]
                                                          .price
                                                          .toString()));
                                                  valueProvider
                                                      .addCounter();

                                                  const snackBar =
                                                  SnackBar(
                                                    backgroundColor:
                                                    Colors.green,
                                                    content: Text(
                                                        'Product is added to cart'),
                                                    duration: Duration(
                                                        microseconds:
                                                        100),
                                                  );

                                                  ScaffoldMessenger
                                                      .of(context)
                                                      .showSnackBar(
                                                      snackBar);
                                                }).onError((error, stackTrace) {
                                                  if (kDebugMode) {
                                                    print(
                                                        "error$error");
                                                  }
                                                  const snackBar = SnackBar(
                                                      backgroundColor:
                                                      Colors.red,
                                                      content: Text(
                                                          'Product is already added in cart'),
                                                      duration: Duration(
                                                          microseconds:
                                                          100));

                                                  ScaffoldMessenger
                                                      .of(context)
                                                      .showSnackBar(
                                                      snackBar);
                                                });
                                              }
                                            },
                                            child: Container(
                                              height: 6.h,
                                              width: 6.h,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius
                                                          .circular(
                                                              10),
                                                  color:
                                                      Colors.white),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets
                                                        .all(8.0),
                                                child: Lottie.asset(
                                                    'assets/images/lottie/cart.json'),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
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
                ],
              ),
            );
          }),
    );
  }

  //NetworkImage imagesForBackground(ProductCategoriesProvider valueProvider, int index) => NetworkImage(valueProvider.cateringProductsList[index].images![0]['src'].toString());
  NetworkImage imagesForBackground(
          ProductCategoriesProvider valueProvider, int index) =>
      NetworkImage(valueProvider.cateringProductsList[index].images![0]['src']
          .toString());
}
