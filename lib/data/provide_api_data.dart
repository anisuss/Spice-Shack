import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:woocommerce_api/woocommerce_api.dart';

import 'model.dart';

class DemoProvider extends ChangeNotifier {
  DemoProvider() {
    Timer(const Duration(seconds: 3), () {

      fetchData();
    });

  }
  int _state = 0;
  int get state => _state;

  set state(int value) {
    _state = value;
    notifyListeners();
  }

  List<Demo> listDemo = [];

  fetchData() async {



    state = 0;
    try {
      WooCommerceAPI wooCommerceAPI = WooCommerceAPI(
          url: "https://apple.ucstestserver.xyz/wp-json/wc/v3/products?",
          consumerKey: "ck_802852d78d45c811a9adefd458c9e660b205ac40",
          consumerSecret: "cs_7c3274f9c9f45008c8bc2bb9f026c6e243e2e2a2"
      );

      listDemo = [];
      List products = await wooCommerceAPI.getAsync("id");
      for (var element in products) {
        listDemo.add(Demo.fromJson(element));
      }
      state = 1;
    } catch (e) {
      e;
    }
  }

}