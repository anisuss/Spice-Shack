import 'package:auto_size_text/auto_size_text.dart';
import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:spice_shack/resources/colors/gradient_colors.dart';
import 'package:spice_shack/screen.dart';
import 'package:spice_shack/widgets/navigation%20bar/navigation_bar_widget.dart';
import '../../resources/colors/colors_resources.dart';
import '../../resources/text/fonts.dart';
import '../../screens/cart screen/cart_screen.dart';
import '../../screens/products APi Functions/products_Functions_api.dart';
import '../../screens/products categories screen/providers/product_categories_provider.dart';
import '../catering_model.dart';
import 'catering_products.dart';
import 'package:badges/src/badge.dart' as badge;

class CateringScreen extends StatefulWidget {
  const CateringScreen({Key? key}) : super(key: key);

  @override
  State<CateringScreen> createState() => _CateringScreenState();
}
String _myCateringId = "";
String get myCateringId => _myCateringId;
class _CateringScreenState extends State<CateringScreen> {
  set myCateringId(String value) {
    _myCateringId = value;
  }


  @override
  Widget build(BuildContext context) {
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
                            'assets/images/backgrounds/family.jpg',
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
                                    "Family Catering",
                                    style: AppTextStyle.spiceShackFonts(
                                      style: TextStyle(
                                        fontSize: 24.sp,
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
                            onPressed: (){
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
                          child: GestureDetector(
                            onTap: () async {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                  const CartScreen(),
                                ),
                              );
                            },
                            child: badge.Badge(
                              badgeContent: Text(
                                  valueProvider.getCounter().toString(),
                                  style: const TextStyle(
                                      color: Colors.white)),
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
                if (valueProvider.state == 0)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 48.0, horizontal: 20.0),
                    child: SizedBox(
                      height: 40.h,
                      width: 40.h,
                      child: Lottie.asset(
                          'assets/images/lottie/loader.json'),
                    ),
                  ),

                Expanded(
                  child: ListView.builder(
                      itemCount: valueProvider.dataCateringList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.all(5.0.sp),
                          child: Container(
                            height: 30.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: MyColors.silver,width: 2),
                            ),
                            child: Stack(
                              children: [
                                Container(
                                  height: 30.h,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(30),
                                    child: CachedNetworkImage(
                                      placeholder: (context, url) => Container(
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
                                      imageUrl: valueProvider.dataCateringList[index].image!["src"].toString(),
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
                                          ])),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Text(
                                        Bidi.stripHtmlIfNeeded( valueProvider.dataCateringList[index].name.toString(),),maxLines: 3,textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 22.sp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 3.h,
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          myCateringId = valueProvider.dataCateringList[index].id.toString();
                                          print("_________ID_____________");
                                          print(valueProvider.dataCateringList[index].id.toString());
                                          print("_________ID END_____________");


                                          valueProvider.selectedItemValue.clear();
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const CateringProductsScreen(),
                                              ),);

                                          //Catering Product list
                                          List<CateringModel> myCateringProduct = await ProductsFunctionsApi().getProductsCateringList();
                                          valueProvider.updateCateringProductsListModel(myCateringProduct);


                                        },
                                        child: Container(
                                          height: 6.h,
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 44.sp),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Colors.white),
                                          child: Center(
                                            child: Text(
                                              "Order Now",
                                              style: TextStyle(
                                                  color: Colors.grey[900],
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 2.h,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
