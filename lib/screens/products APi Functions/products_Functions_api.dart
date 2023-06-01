import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../../cattering screen/catering_model.dart';
import '../../cattering screen/main screen/main_catering_screen.dart';
import '../../cattering screen/screen/cattering_screen.dart';
import '../../model/api data model/prdoucts_model.dart';
import '../authentication screen/login_model.dart';
import '../authentication screen/login_screen.dart';
import '../checkOut screen/model places api/prediction_model.dart';
import '../coupons data/coupons_data_model.dart';
import '../products categories screen/model/api_data_model.dart';
import '../products categories screen/model/profile_model.dart';
import '../products categories screen/product categories/categories_screen.dart';

class ProductsFunctionsApi {
  int _check = 0;

  int get check => _check;

  set check(int value) {
    _check = value;
  }

  //Fetch data from api
  //Login Api
  Future<List<LoginModel>> loginWithApi() async {
    String email = emailStateData;
    String password = passwordStateData;
    List<LoginModel> loginData = [];
    try {
      var request = http.Request(
          'GET',
          Uri.parse(
              "https://spiceshackus.com/wp-json/custom-plugin/login?username=$email&password=$password"));
      http.StreamedResponse loginResponse = await request.send();
      if (loginResponse.statusCode == 200) {
        if (kDebugMode) {
          print("Response :- ${loginResponse.statusCode.toString()}");
        }
        var rawData = await loginResponse.stream.bytesToString();
        List<dynamic> dataInJsonDecode = jsonDecode(rawData);
        for (var element in dataInJsonDecode) {
          if (kDebugMode) {
            print("Login data :- $element");
          }

          LoginModel loginModel = LoginModel.fromJson(element);
          loginData.add(loginModel);
        }

        if (kDebugMode) {
          print("all okay");
        }
      } else {
        if (kDebugMode) {
          print("Your Api Response ${loginResponse.toString()}");
        }
      }
      return loginData;
    } catch (e) {
      if (kDebugMode) {
        print("Your Api is not working ${e.toString()}");
      }
    }
    return loginData;
  }

  //Categories
  Future<List<CartItemModel>> getCategories() async {
    List<CartItemModel> listProductData = [];
    try {
      var request = http.Request(
          'GET',
          Uri.parse("https://spiceshackus.com/wp-json/wc/v3/products/categories?consumer key=ck_33fb5dae74953e8d8f552d2ff8cccc6b48bd3e51&consumer secret=cs_a87b5c5300da75bd2e7fc8876d09cb0ec3457f06&per page=100&parent=0&exclude=91,156&per page=100"));
      http.StreamedResponse productCategoriesResponse = await request.send();
      if (productCategoriesResponse.statusCode == 200) {
        if (kDebugMode) {
          // print(
          //     "Response :- ${productCategoriesResponse.statusCode.toString()}");
        }
        var rawData = await productCategoriesResponse.stream.bytesToString();
        List<dynamic> dataInJsonDecode = jsonDecode(rawData);
        // print('________________________Response Start________________________');
        int i=0;
        for (var element in dataInJsonDecode) {
          if (kDebugMode) {
            // print('________________________________________________\n');
            // print('<:<:<:<:<:<:<:<:<:<  ${i++}  >:>:>::>:>:>:>::>');
            // print("| $element | \n ");
            // print('________________________________________________\n');
          }

          CartItemModel categoriesModel = CartItemModel.fromJson(element);
          listProductData.add(categoriesModel);
          listProductData.sort((a, b) => a.description.compareTo(b.description));
          listProductData.removeWhere((item) => item.name == 'Uncategorized');
          listProductData.removeWhere((item) => item.name == 'Gift Card');
          listProductData.removeWhere((item) => item.name == 'Events Catering');
          listProductData.removeWhere((item) => item.name == 'Family Feast');
          listProductData.removeWhere((item) => item.name == 'Lunch box');
          listProductData.removeWhere((item) => item.name == 'Ramadan special');
          // if (kDebugMode) {
          //   print("________________Start Categories__________________");
          // }
          for(CartItemModel p in listProductData) {
            // if (kDebugMode) {
            //   print("${p.description} Name :- ${p.name} ");
            // }

          }
          // if (kDebugMode) {
          //   print("_________________Last Categories__________________");
          // }


        }
        //print('________________________Response End_________________________');
      } else {}
      return listProductData;
    } catch (e) {
      e;
    }
    return listProductData;
  }

  //Coupons
  /*Future<List<CouponsModel>> getCouponsData() async {
    List<CouponsModel> couponsData = [];
    try {
      var request = http.Request(
          'GET',
          Uri.parse(
              "https://spiceshackus.com/wp-json/wc-pimwick/v1/pw-gift-cards?consumer key=ck_33fb5dae74953e8d8f552d2ff8cccc6b48bd3e51&consumer secret=cs_a87b5c5300da75bd2e7fc8876d09cb0ec3457f06"));
      http.StreamedResponse couponsResponse = await request.send();
      if (couponsResponse.statusCode == 200) {
        if (kDebugMode) {
          print(
              "Response :- ${couponsResponse.statusCode.toString()}");
        }
        var rawData = await couponsResponse.stream.bytesToString();
        List<dynamic> dataInJsonDecode = jsonDecode(rawData);
        for (var element in dataInJsonDecode) {
          if (kDebugMode) {
            print(" $element ");

          }

          CouponsModel couponsModel = CouponsModel.fromJson(element);
          couponsData.add(couponsModel);

          for(CouponsModel p in couponsData) {
            if (kDebugMode) {
              print("${p.description} Name :- ${p.description} ");
              print("${p.amount} Amount :- ${p.amount} ");
              print("${p.code} Code :- ${p.code} ");
            }

          }
          if (kDebugMode) {
            print("________________<><><><>   Coupons  <><><><><>_________________");
          }


        }
        print('________________________Coupons End_________________________');
      } else {}
      return couponsData;
    } catch (e) {
      e;
    }
    return couponsData;
  }*/
  Future<List<CouponsModel>> getCouponsData(String data) async {
    List<CouponsModel> listCouponData = [];
    try {
      var request = http.Request(
          'GET',
          Uri.parse(
              "https://spiceshackus.com/wp-json/wc-pimwick/v1/pw-gift-cards?consumer key=ck_33fb5dae74953e8d8f552d2ff8cccc6b48bd3e51&consumer secret=cs_a87b5c5300da75bd2e7fc8876d09cb0ec3457f06&number=$data"));
              // "https://spiceshackus.com/wp-json/wc-pimwick/v1/pw-gift-cards?consumer key=ck_33fb5dae74953e8d8f552d2ff8cccc6b48bd3e51&consumer secret=cs_a87b5c5300da75bd2e7fc8876d09cb0ec3457f06&number=H89F-UNJ6-KHNU-QMPY"));
      http.StreamedResponse productCategoriesResponse = await request.send();
      if (productCategoriesResponse.statusCode == 200) {

       // print(productCategoriesResponse.statusCode);
        var rawData = await productCategoriesResponse.stream.bytesToString();
        //print(rawData);
        List<dynamic> dataInJsonDecode = jsonDecode(rawData);
       // print(dataInJsonDecode[0]);
        for (var element in dataInJsonDecode) {
         // print("Loop is working");
          //print(element);
          CouponsModel couponModel = CouponsModel.fromJson(element);
         // print("Loop mid working");
          //print(element);

          listCouponData.add(couponModel);
        }
       // print("List of coupons ${listCouponData}");
      } else {
      }
      return listCouponData;
    } catch (e) {
      e;
    }
    return listCouponData;
  }

  Future<List<CartItemModel>> getCatering() async {
    List<CartItemModel> listProductData = [];
    try {
      var request = http.Request(
          'GET',
          Uri.parse(
              "https://spiceshackus.com/wp-json/wc/v3/products/categories?consumer key=ck_33fb5dae74953e8d8f552d2ff8cccc6b48bd3e51&consumer secret=cs_a87b5c5300da75bd2e7fc8876d09cb0ec3457f06&per page=100&parent=91"));
      http.StreamedResponse productCategoriesResponse = await request.send();
      if (productCategoriesResponse.statusCode == 200) {
        var rawData = await productCategoriesResponse.stream.bytesToString();
        List<dynamic> dataInJsonDecode = jsonDecode(rawData);
        for (var element in dataInJsonDecode) {
          CartItemModel productCategoriesModel =
              CartItemModel.fromJson(element);
          listProductData.add(productCategoriesModel);
        }
      } else {
      }
      return listProductData;
    } catch (e) {
      e;
    }
    return listProductData;
  }

//list
  Future<List<ProductListModel>> getListOfProductsByCategories() async {
    String checkId = myStateId;
    List<ProductListModel> productsCategoriesList = [];
    try {
      check = 1;
      var request = http.Request(
          'GET',
          Uri.parse(
              "https://spiceshackus.com/wp-json/wc/v3/products?consumer key=ck_33fb5dae74953e8d8f552d2ff8cccc6b48bd3e51&consumer secret=cs_a87b5c5300da75bd2e7fc8876d09cb0ec3457f06&category=$checkId&per page=100"));
      http.StreamedResponse productCategoriesResponse = await request.send();
      if (productCategoriesResponse.statusCode == 200) {
        var rawData = await productCategoriesResponse.stream.bytesToString();
        List<dynamic> dataInJsonDecode = jsonDecode(rawData);
        for (var element in dataInJsonDecode) {
          ProductListModel productListCategoriesModel =
              ProductListModel.fromJson(element);
          productsCategoriesList.add(productListCategoriesModel);
        }
      } else {
      }
      return productsCategoriesList;
    } catch (e) {
      e;
    }
    check = 0;
    return productsCategoriesList;
  }

  //Catering products
  Future<List<CateringModel>> getProductsCateringList() async {
    String cateringId = myCateringId;
    List<CateringModel> cateringProductsList = [];
    try {
      //var request = http.Request('GET', Uri.parse("&category=$cateringId"));
      //var request = http.Request('GET', Uri.parse("https://spiceshackus.com/wp-json/wc/v3/products/categories/$cateringId?consumer key=ck_33fb5dae74953e8d8f552d2ff8cccc6b48bd3e51&consumer secret=cs_a87b5c5300da75bd2e7fc8876d09cb0ec3457f06&per page=100"));
      var request = http.Request('GET', Uri.parse("https://spiceshackus.com/wp-json/wc/v3/products?consumer key=ck_33fb5dae74953e8d8f552d2ff8cccc6b48bd3e51&consumer secret=cs_a87b5c5300da75bd2e7fc8876d09cb0ec3457f06&category=$cateringId&per page=100"));
      http.StreamedResponse productCategoriesResponse = await request.send();
      if (productCategoriesResponse.statusCode == 200) {
        var rawData = await productCategoriesResponse.stream.bytesToString();
        List<dynamic> dataInJsonDecode = jsonDecode(rawData);
        //print("__________________________________Start____________________");
        for (var element in dataInJsonDecode) {
          CateringModel productCategoriesModel =
              CateringModel.fromJson(element);
         // print(element);
          cateringProductsList.add(productCategoriesModel);
        }
        //print("__________________________________End____________________");

      } else {

      }
      return cateringProductsList;
    } catch (e) {
      e;
    }
    return cateringProductsList;
  }

  //Catering products
  Future<List<CateringModel>> getRamadanCateringList() async {
    List<CateringModel> cateringRamadanList = [];
    try {
      var request = http.Request('GET', Uri.parse("https://spiceshackus.com/wp-json/wc/v3/products?consumer key=ck_33fb5dae74953e8d8f552d2ff8cccc6b48bd3e51&consumer secret=cs_a87b5c5300da75bd2e7fc8876d09cb0ec3457f06&category=103&per page=100"));
      http.StreamedResponse productCategoriesResponse = await request.send();
      if (productCategoriesResponse.statusCode == 200) {
        var rawData = await productCategoriesResponse.stream.bytesToString();
        List<dynamic> dataInJsonDecode = jsonDecode(rawData);


        //nt("__________________________________Start____________________");
        for (var element in dataInJsonDecode) {
          CateringModel productCategoriesModel =
          CateringModel.fromJson(element);
          //nt(element);


          cateringRamadanList.add(productCategoriesModel);
        }
        //nt("__________________________________End____________________");

      } else {

      }
      return cateringRamadanList;
    } catch (e) {
      e;
    }
    return cateringRamadanList;
  }

  //Catering products
  Future<List<CateringModel>> getFamilyFeastCateringList() async {
    List<CateringModel> cateringFamilyFeastList = [];
    try {
      var request = http.Request('GET', Uri.parse("https://spiceshackus.com/wp-json/wc/v3/products?consumer key=ck_33fb5dae74953e8d8f552d2ff8cccc6b48bd3e51&consumer secret=cs_a87b5c5300da75bd2e7fc8876d09cb0ec3457f06&category=105t&per page=100"));
      http.StreamedResponse productCategoriesResponse = await request.send();
      if (productCategoriesResponse.statusCode == 200) {
        var rawData = await productCategoriesResponse.stream.bytesToString();
        List<dynamic> dataInJsonDecode = jsonDecode(rawData);


        //nt("__________________________________Start____________________");
        for (var element in dataInJsonDecode) {
          CateringModel productCategoriesModel =
          CateringModel.fromJson(element);
          //nt(element);


          cateringFamilyFeastList.add(productCategoriesModel);
        }
        //nt("__________________________________End____________________");

      } else {

      }
      return cateringFamilyFeastList;
    } catch (e) {
      e;
    }
    return cateringFamilyFeastList;
  }

  //Catering products
  Future<List<CateringModel>> getLunchBoxCateringList() async {
    List<CateringModel> cateringLunchBoxList = [];
    try {
      var request = http.Request('GET', Uri.parse("https://spiceshackus.com/wp-json/wc/v3/products?consumer key=ck_33fb5dae74953e8d8f552d2ff8cccc6b48bd3e51&consumer secret=cs_a87b5c5300da75bd2e7fc8876d09cb0ec3457f06&category=104t&per page=100"));
      http.StreamedResponse productCategoriesResponse = await request.send();
      if (productCategoriesResponse.statusCode == 200) {
        var rawData = await productCategoriesResponse.stream.bytesToString();
        List<dynamic> dataInJsonDecode = jsonDecode(rawData);


        //nt("__________________________________Start____________________");
        for (var element in dataInJsonDecode) {
          CateringModel productCategoriesModel =
          CateringModel.fromJson(element);
          //nt(element);


          cateringLunchBoxList.add(productCategoriesModel);
        }
        //nt("__________________________________End____________________");

      } else {

      }
      return cateringLunchBoxList;
    } catch (e) {
      e;
    }
    return cateringLunchBoxList;
  }

  //Catering products
  Future<List<CateringModel>> getEventsCateringCateringList() async {
    List<CateringModel> cateringEventList = [];
    try {
      var request = http.Request('GET', Uri.parse("https://spiceshackus.com/wp-json/wc/v3/products?consumer key=ck_33fb5dae74953e8d8f552d2ff8cccc6b48bd3e51&consumer secret=cs_a87b5c5300da75bd2e7fc8876d09cb0ec3457f06&category=106&per page=100"));
      http.StreamedResponse productCategoriesResponse = await request.send();
      if (productCategoriesResponse.statusCode == 200) {
        var rawData = await productCategoriesResponse.stream.bytesToString();
        List<dynamic> dataInJsonDecode = jsonDecode(rawData);


        //nt("__________________________________Start____________________");
        for (var element in dataInJsonDecode) {
          CateringModel productCategoriesModel =
          CateringModel.fromJson(element);
          //nt(element);


          cateringEventList.add(productCategoriesModel);
        }
        //nt("__________________________________End____________________");

      } else {

      }
      return cateringEventList;
    } catch (e) {
      e;
    }
    return cateringEventList;
  }

  //Profile Data
  Future<List<ProfileModel>> getProfileData() async {
    List<ProfileModel> myProfileList = [];
    try {
      var request = http.Request(
          'GET',
          Uri.parse(
              "https://spiceshackus.com/wp-json/custom-plugin/login?username=$emailStateData&password=$passwordStateData"));
      http.StreamedResponse productCategoriesResponse = await request.send();
      if (productCategoriesResponse.statusCode == 200) {
        var rawData = await productCategoriesResponse.stream.bytesToString();
        List<dynamic> dataInJsonDecode = jsonDecode(rawData);
        for (var element in dataInJsonDecode) {
          ProfileModel profileModel = ProfileModel.fromJson(element);
          myProfileList.add(profileModel);
        }
      } else {
      }
      return myProfileList;
    } catch (e) {
      e;
    }
    return myProfileList;
  }

  //Places APi
  List<AutoCompletePrediction> placePredictions = [];

  static Future<String?> fetchUrl(Uri uriPlaces,
      {Map<String, String>? headers}) async {
    try {
      final response = await http.get(uriPlaces, headers: headers);
      if (response.statusCode == 200) {
        return response.body;
      }
    } catch (e) {
      debugPrint("Places Api Response :- ${e.toString()}");
    }
    return null;
  }
}
