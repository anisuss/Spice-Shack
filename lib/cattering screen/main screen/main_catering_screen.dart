import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:spice_shack/cattering%20screen/event%20catering/event_catering.dart';
import 'package:spice_shack/cattering%20screen/family%20feast/family_feasy.dart';
import 'package:spice_shack/cattering%20screen/lunch%20box/lunch_box.dart';
import 'package:spice_shack/cattering%20screen/ramadan/ramadan_categories.dart';
import 'package:spice_shack/cattering%20screen/screen/cattering_screen.dart';

import '../../resources/colors/colors_resources.dart';
import '../../resources/colors/gradient_colors.dart';
import '../../resources/text/fonts.dart';
import '../../screens/products APi Functions/products_Functions_api.dart';
import '../../screens/products categories screen/model/api_data_model.dart';
import '../../screens/products categories screen/providers/product_categories_provider.dart';
import '../catering_model.dart';
import '../ramadan/ramadan.dart';

class MainCateringScreen extends StatefulWidget {
  const MainCateringScreen({Key? key}) : super(key: key);

  @override
  State<MainCateringScreen> createState() => _MainCateringScreenState();
}
String _myIdFeast = "";
String get myIdFeast => _myIdFeast;
class _MainCateringScreenState extends State<MainCateringScreen> {
  set myIdFeast(String value) {
    _myIdFeast = value;
  }
  List cateringProductName = [
    "Ramadan special",
    "Events Catering",
    "Family Feast",
    "Ramadan special",
    "Family catering",
    "Lunch boxes",
  ];
  List cateringProductImage = [
    "assets/images/cart backgrounds/food-7.jpg",
    "assets/images/backgrounds/event.jpg",
    "assets/images/backgrounds/ff.jpg",
    "assets/images/backgrounds/ramadan.jpg",
    "assets/images/backgrounds/family.jpg",
    "assets/images/backgrounds/lunch.jpg",
  ];
  List cateringPages = [
    RamadanCategoriesScreen(title: "Ramadan Special"),
    const EventCatering(),
    const FamilyFeastScreen(),
    RamadanCategoriesScreen(title: "Ramadan Special"),
    const CateringScreen(),
    const LunchBoxCateringScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final valueProvider = Provider.of<ProductCategoriesProvider>(context, listen: false);

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
              Expanded(
                child: ListView.builder(
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Container(
                        height: 30.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: GradientsConstants.blackGradient,
                          image: const DecorationImage(
                            image: AssetImage(
                              'assets/images/backgrounds/cat3.jpg',
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
                                      "Spice Catering",
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
                      );
                    }
                    return Padding(
                      padding: EdgeInsets.all(5.0.sp),
                      child: Container(
                        height: 30.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: MyColors.silver, width: 2),
                        ),
                        child: Stack(
                          children: [
                            Container(
                              height: 30.h,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                    cateringProductImage[index],
                                  ),
                                  fit: BoxFit.fill,
                                ),
                                borderRadius: BorderRadius.circular(30),
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
                                    cateringProductName[index],
                                    maxLines: 3,
                                    textAlign: TextAlign.center,
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
                                      //myIdFeast = '105';
                                     // valueProvider.getFamilyFeastCateringList();
                                     //  Navigator.push(context, MaterialPageRoute(builder: (_) => const FamilyFeastScreen(),),);
                                      Navigator.push(context, MaterialPageRoute(builder: (_) => cateringPages[index],),);
                                      List<CateringModel> myCateringRamadan = await ProductsFunctionsApi().getRamadanCateringList();
                                      Provider.of<ProductCategoriesProvider>(context,listen: false).updateCateringRamadanListModel(myCateringRamadan);
                                      //Catering list
                                      List<CartItemModel> myCatering = await ProductsFunctionsApi().getCatering();
                                      Provider.of<ProductCategoriesProvider>(context,listen: false).updateDataCateringModel(myCatering);

                                      List<CateringModel> myCateringFamilyFeast = await ProductsFunctionsApi().getFamilyFeastCateringList();
                                      Provider.of<ProductCategoriesProvider>(context,listen: false).updateCateringFamilyFeastListModel(myCateringFamilyFeast);

                                      List<CateringModel> myCateringLunch = await ProductsFunctionsApi().getLunchBoxCateringList();
                                      Provider.of<ProductCategoriesProvider>(context,listen: false).updateCateringLunchBoxListModel(myCateringLunch);

                                      List<CateringModel> myCateringEvent= await ProductsFunctionsApi().getEventsCateringCateringList();
                                      Provider.of<ProductCategoriesProvider>(context,listen: false).updateCateringEventListModel(myCateringEvent);
                                    },
                                    /*onTap: () async {
                                      if(index == 0){
                                        //events catering
                                        myIdFeast = '106';

                                        Navigator.push(context, MaterialPageRoute(builder: (_) => RamadanCategoriesScreen(title: cateringProductName[index],),),);
                                        List<CateringModel> myCateringRamadan = await ProductsFunctionsApi().getRamadanCateringList();
                                        valueProvider.updateCateringRamadanListModel(myCateringRamadan);
                                      }else if(index == 1){
                                        //family feast
                                        myIdFeast = '105';
                                        Navigator.push(context, MaterialPageRoute(builder: (_) => RamadanCategoriesScreen(title: cateringProductName[index],),),);

                                        List<CateringModel> myCateringRamadan = await ProductsFunctionsApi().getRamadanCateringList();
                                        valueProvider.updateCateringRamadanListModel(myCateringRamadan);
                                      }else if(index == 2){
                                        //Ramadan special
                                        myIdFeast = '103';
                                        Navigator.push(context, MaterialPageRoute(builder: (_) => RamadanCategoriesScreen(title: cateringProductName[index],),),);

                                        List<CateringModel> myCateringRamadan = await ProductsFunctionsApi().getRamadanCateringList();
                                        valueProvider.updateCateringRamadanListModel(myCateringRamadan);
                                      }else if(index == 4){
                                        //Lunch box
                                        myIdFeast = '104';
                                        Navigator.push(context, MaterialPageRoute(builder: (_) => RamadanCategoriesScreen(title: cateringProductName[index],),),);

                                        List<CateringModel> myCateringRamadan = await ProductsFunctionsApi().getRamadanCateringList();
                                        valueProvider.updateCateringRamadanListModel(myCateringRamadan);
                                      }else{
                                        Navigator.push(context, MaterialPageRoute(builder: (_) => const CateringScreen(),),);

                                      }

                                    },*/
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
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
