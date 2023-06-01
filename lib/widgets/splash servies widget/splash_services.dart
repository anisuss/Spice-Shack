import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spice_shack/screens/home%20screen/home_screen.dart';
import 'package:spice_shack/widgets/navigation%20bar/navigation_bar_widget.dart';
import '../../cattering screen/catering_model.dart';
import '../../model/api data model/prdoucts_model.dart';
import '../../screens/categories list screen/model/cartCategroiesModel.dart';
import '../../screens/categories list screen/model/db_helper_categories.dart';
import '../../screens/products APi Functions/products_Functions_api.dart';
import '../../screens/products categories screen/model/api_data_model.dart';
import '../../screens/products categories screen/providers/product_categories_provider.dart';

class SplashServices {
  DBHelperStatic? dbHelper = DBHelperStatic();
  Future<void> isLogin(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString("email") ?? "";
    String? password = prefs.getString("email") ?? "";
    Widget child = const HomeScreen();
    if (email.isNotEmpty && password.isNotEmpty) {

      child = const NavigationBarWidget();
    }

    //Categories list
    List<CartItemModel> myData = await ProductsFunctionsApi().getCategories();

    Provider.of<ProductCategoriesProvider>(context,listen: false).updateDataProductCategoriesModel(myData);

    //Catering list
    List<CartItemModel> myCatering = await ProductsFunctionsApi().getCatering();
    Provider.of<ProductCategoriesProvider>(context,listen: false).updateDataCateringModel(myCatering);

    List<CateringModel> myCateringRamadan = await ProductsFunctionsApi().getRamadanCateringList();
    Provider.of<ProductCategoriesProvider>(context,listen: false).updateCateringRamadanListModel(myCateringRamadan);

    List<CateringModel> myCateringFamilyFeast = await ProductsFunctionsApi().getFamilyFeastCateringList();
    Provider.of<ProductCategoriesProvider>(context,listen: false).updateCateringFamilyFeastListModel(myCateringFamilyFeast);

    List<CateringModel> myCateringLunch = await ProductsFunctionsApi().getLunchBoxCateringList();
    Provider.of<ProductCategoriesProvider>(context,listen: false).updateCateringLunchBoxListModel(myCateringLunch);

    List<CateringModel> myCateringEvent= await ProductsFunctionsApi().getEventsCateringCateringList();
    Provider.of<ProductCategoriesProvider>(context,listen: false).updateCateringEventListModel(myCateringEvent);




    //dummy value in db
    dbHelper!.insert(ProductModel(
        id: 0,
        name: "",
        initialPrice: 0,
        productPrice: 0,
        quantity: 0,
        image: "", productId: '', varData: ''),);

    /*//Catering Product list
                List<CateringModel> myCateringProduct = await ProductsFunctionsApi().getProductsCateringList();
                valueProvider.updateCateringProductsListModel(myCateringProduct);*/

    //Categories products list
    List<ProductListModel> productData = await ProductsFunctionsApi().getListOfProductsByCategories();
    Provider.of<ProductCategoriesProvider>(context,listen: false).updateDataProductCategoriesListModel(productData);

    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => child ));

    // final auth = FirebaseAuth.instance;
    // final user = auth.currentUser;
    //
    // if(user != null){
    //   Timer(
    //     const Duration(seconds: 2,),
    //         () => Navigator.pushReplacement(
    //       context,
    //       MaterialPageRoute(
    //         builder: (context) => const RestaurantScreen(),
    //       ),
    //     ),
    //   );
    // }else {
    //   Timer(
    //     const Duration(seconds: 2,),
    //         () => Navigator.pushReplacement(
    //       context,
    //       MaterialPageRoute(
    //        builder: (context) => const HomeScreen(),
    //        //  builder: (context) => const ProductCategoriesScreen(),
    //       ),
    //     ),
    //   );
    // }
  }
}
