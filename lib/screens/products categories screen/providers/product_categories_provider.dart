import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spice_shack/del/model.dart';
import 'package:woocommerce_api/woocommerce_api.dart';
import 'package:http/http.dart' as https;
import 'package:http/http.dart' as http;
import 'dart:ui' as ui;
import '../../../cart data/database/db_helper.dart';
import '../../../cart data/model/cart_model.dart';
import '../../../cattering screen/catering_model.dart';
import '../../../cattering screen/family feast/family_feast_model.dart';
import '../../../cattering screen/ramadan/ramadan_model.dart';
import '../../../cattering screen/screen/catering_products.dart';
import '../../../model/api data model/prdoucts_model.dart';
import '../../../utils/resources/toast_message.dart';
import '../../authentication screen/login_model.dart';
import '../../authentication screen/login_screen.dart';
import '../../authentication screen/sign_up_screen.dart';
import '../../cart screen/cart_screen.dart';
import '../../categories list screen/model/temp.dart';
import '../../checkOut screen/checkOut_screen.dart';
import '../../coupons data/coupons_data_model.dart';
import '../../delivery screen/delivery_screen.dart';
import '../model/api_data_model.dart';
import '../model/profile_model.dart';

class ProductCategoriesProvider extends ChangeNotifier {
  bool showButtons = true;

  Future<void> checkSharedPrefsData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool sharedData = prefs.getBool('sharedData') ?? false;
    if (sharedData) {
      showButtons = false;
    }
    notifyListeners();
  }

  Future<void> saveToSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('sharedData', true);
    showButtons = false;
    notifyListeners();
  }
  //nav bar index
  int selectedIndexByNav = 0;

  //update nav bar index
  void updateIndexNavBarBy(value) {
    selectedIndexByNav = value;
    notifyListeners();
  }
  ///Ramadan box 1 addons
  String apIR1 = '';
  String apIR1Value = '';
  String e1R1 = '';
  String e1R1Value = '';
  String e2R1 = '';
  String e2R1Value = '';
  String c1R1 = '';
  String c1R1Value = '';
  String dessertsR1 = '';
  String dessertsR1Value = '';

  String plateAddOnsR1Check = '';
  String plateQuantityR1Check = '';
  String bottleAddOnsR1Check = '';
  String bottleQuantityR1Check = '';
  String mangoAddOnsR1Check = '';
  String mangoQuantityR1Check = '';
  String naanAddOnsR1Check = '';
  String naanQuantityR1Check = '';

  ///Ramadan box 2 addons
  String apIR2 = '';
  String apIR2Value = '';
  String e1R2 = '';
  String e1R2Value = '';
  String e2R2 = '';
  String e2R2Value = '';
  String e3R2 = '';
  String e3R2Value = '';
  String breadR2 = '';
  String breadR2Value = '';
  String c1R2 = '';
  String c1R2Value = '';
  String c2R2 = '';
  String c2R2Value = '';
  String dessertsR2 = '';
  String dessertsR2Value = '';


  String plateAddOnsR2Check = '';
  String plateQuantityR2Check = '';
  String bottleAddOnsR2Check = '';
  String bottleQuantityR2Check = '';
  String mangoAddOnsR2Check = '';
  String mangoQuantityR2Check = '';
  String naanAddOnsR2Check = '';
  String naanQuantityR2Check = '';

  ///Ramadan box 3 addons
  String apIR3 = '';
  String apIR3Value = '';
  String apIIR3 = '';
  String apIIR3Value = '';
  String e1R3 = '';
  String e1R3Value = '';
  String e2R3 = '';
  String e2R3Value = '';
  String e3R3 = '';
  String e3R3Value = '';
  String breadR3 = '';
  String breadR3Value = '';
  String c1R3 = '';
  String c1R3Value = '';
  String c2R3 = '';
  String c2R3Value = '';
  String dessertsR3 = '';
  String dessertsR3Value = '';

  String plateAddOnsR3Check = '';
  String plateQuantityR3Check = '';
  String bottleAddOnsR3Check = '';
  String bottleQuantityR3Check = '';
  String mangoAddOnsR3Check = '';
  String mangoQuantityR3Check = '';
  String naanAddOnsR3Check = '';
  String naanQuantityR3Check = '';

  ///Ramadan box 4 addons
  String apIR4 = '';
  String apIR4Value = '';
  String apIIR4 = '';
  String apIIR4Value = '';
  String e1R4 = '';
  String e1R4Value = '';
  String e2R4 = '';
  String e2R4Value = '';
  String e3R4 = '';
  String e3R4Value = '';
  String breadR4 = '';
  String breadR4Value = '';
  String c1R4 = '';
  String c1R4Value = '';
  String c2R4 = '';
  String c2R4Value = '';
  String dessertsR4 = '';
  String dessertsR4Value = '';

  String plateAddOnsR4Check = '';
  String plateQuantityR4Check = '';
  String bottleAddOnsR4Check = '';
  String bottleQuantityR4Check = '';
  String mangoAddOnsR4Check = '';
  String mangoQuantityR4Check = '';
  String naanAddOnsR4Check = '';
  String naanQuantityR4Check = '';

  ///Family Feast addons
  String apIFF = '';
  String apIFFValue = '';
  String apIIFF = '';
  String apIIFFValue = '';
  String e1FF = '';
  String e1FFValue = '';
  String e2FF = '';
  String e2FFValue = '';
  String e3FF = '';
  String e3FFValue = '';
  String breadFF = '';
  String breadFFValue = '';
  String c1FF = '';
  String c1FFValue = '';
  String c2FF = '';
  String c2FFValue = '';
  String dessertsFF = '';
  String dessertsFFValue = '';

  String plateAddOnsFFCheck = '';
  String plateQuantityFFCheck = '';
  String bottleAddOnsFFCheck = '';
  String bottleQuantityFFCheck = '';
  String mangoAddOnsFFCheck = '';
  String mangoQuantityFFCheck = '';
  String naanAddOnsFFCheck = '';
  String naanQuantityFFCheck = '';


  ///Family Feast addons
  String apILBox = '';
  String apILBoxValue = '';
  String apIILBox = '';
  String apIILBoxValue = '';
  String e1LBox = '';
  String e1LBoxValue = '';
  String e2LBox = '';
  String e2LBoxValue = '';
  String e3LBox = '';
  String e3LBoxValue = '';
  String breadLBox = '';
  String breadLBoxValue = '';
  String c1LBox = '';
  String c1LBoxValue = '';
  String c2LBox = '';
  String c2LBoxValue = '';
  String dessertsLBox = '';
  String dessertsLBoxValue = '';

  String plateAddOnsLBoxCheck = '';
  String plateQuantityLBoxCheck = '';
  String bottleAddOnsLBoxCheck = '';
  String bottleQuantityLBoxCheck = '';
  String mangoAddOnsLBoxCheck = '';
  String mangoQuantityLBoxCheck = '';
  String naanAddOnsLBoxCheck = '';
  String naanQuantityLBoxCheck = '';
  checkFromApi() async {

    //Ramadan------------------------------------------
    const String apiUrl = "https://spiceshackus.com/wp-json/wc/v3/products?consumer key=ck_33fb5dae74953e8d8f552d2ff8cccc6b48bd3e51&consumer secret=cs_a87b5c5300da75bd2e7fc8876d09cb0ec3457f06&category=103&per page=100";

    var result = await https.get(Uri.parse("https://spiceshackus.com/wp-json/wc/v3/products/meta_data?consumer key=ck_33fb5dae74953e8d8f552d2ff8cccc6b48bd3e51&consumer secret=cs_a87b5c5300da75bd2e7fc8876d09cb0ec3457f06&category=103&per page=100"));
   // print(jsonEncode(json.decode(result.body)));
    List<String> choices = [];
    final data = jsonDecode(result.body);
    for (var item in data) {
      var productChoices = item['choices'];
      for (var choice in productChoices) {
        choices.add(choice['name']);
      }
      print("__________________________ List Data __________________{");
      print(choices);
  }}
  List<FamilyFeastModel> _familyFeastList = [];

  List<FamilyFeastModel> get familyFeastList => _familyFeastList;
  List<CateringModel> thisList = [];
  //Catering products
  Future<void> getFamilyFeastCateringList() async {


      final response = await http.get(Uri.parse('https://spiceshackus.com/wp-json/wc/v3/products?consumer key=ck_33fb5dae74953e8d8f552d2ff8cccc6b48bd3e51&consumer secret=cs_a87b5c5300da75bd2e7fc8876d09cb0ec3457f06&category=105&per page=100'));
      print("_____________++++++++++++++++++++___________________________");
      print(response.body);
      print("_____________^^^^^^^^^^^^^^^^^^^^___________________________");

      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body);
        thisList = data.map((json) => CateringModel.fromJson(json)).toList();
        print(thisList);
        notifyListeners();
      } else {
        throw Exception('Failed to fetch data from API');
      }
  }

  List<MyData> _myDataList = [];
  var _total;

  List<MyData> get myDataList => _myDataList;

  get total => _total;


  bool _isLiked = false;
  int _likeCount = 0;
  int like = 0;
  int pay = 0;
  int apply = 0;

  bool get isLiked => _isLiked;
  int get likeCount => _likeCount;

  void toggleLike() {
    _isLiked = !_isLiked;
    _likeCount += _isLiked ? 1 : -1;
    notifyListeners();
  }
  void placeLike() {
    _isLiked = false;
    _likeCount = 0;
    notifyListeners();
  }
  bool _isPay = false;
  int _payCount = 0;

  bool get isPay => _isPay;
  int get payCount => _payCount;
  void togglePay() {
    _isPay = !_isPay;
    _payCount += _isPay ? 1 : -1;
    notifyListeners();
  }
  void placePay() {
    _isPay = false;
    _payCount = 0;
    notifyListeners();
  }
  bool _isApply = false;
  bool _card = false;
  int _applyCount = 0;
  int _cardCount = 0;
  bool _isCheckCoupon = false;
  int _checkCouponCount = 0;
  bool get isCheckCoupon => _isCheckCoupon;
  int get checkCouponCount => _checkCouponCount;
  void toggleCheckCoupon() {
    _isCheckCoupon = !_isCheckCoupon;
    _checkCouponCount += _isCheckCoupon ? 1 : -1;
    notifyListeners();
  }
  bool get isApply => _isApply;
  int get applyCount => _applyCount;
  int get cardCount => _cardCount;
  int get card => _cardCount;

  void toggleCard() {
    _card = true;
   // _cardCount += _card ? 1 : -1;
    _cardCount = 1 ;

    notifyListeners();
  }
  void toggleCardCount() {
    //_card = !_card;
    _card = false;
    // _cardCount += _card ? 1 : -1;
    _cardCount = 0 ;
    notifyListeners();
  }
  void toggleApply() {
    _isApply = !_isApply;
    _applyCount += _isApply ? 1 : -1;
    notifyListeners();
  }
  void placeApply() {
    _isApply = false;
    _applyCount = 0;
    notifyListeners();
  }

  var quantityList = List<String>.filled(0, '', growable: true);
  var idGrowableList = List<String>.filled(0, '', growable: true);
  var variationId = List<String>.filled(0, '', growable: true);
  var orderId;
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

  List movement = [];
  List movementHere = [
    {"method_id": "flat_rate", "method_title": "Flat Rate", "total": "0.00"}
  ];
  final guestEmail = TextEditingController();
  final guestPhone = TextEditingController();
  final guestF = TextEditingController();
  final guestL = TextEditingController();
  final phoneControll = TextEditingController();

  List<String> logo = ['assets/images/logo/spice-logo.png'];
  bool isVisibleIcon = false;
  int _state = 0;

  int get state => _state;

  set state(int value) {
    _state = value;
    notifyListeners();
  }
  int _couponState = 0;

  int get couponState => _couponState;

  set couponState(int value) {
    _couponState = value;
    notifyListeners();
  }

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

  int _profileLoader = 0;

  int get profileLoader => _profileLoader;

  set profileLoader(int value) {
    _profileLoader = value;
    notifyListeners();
  }

  int _log = 0;

  int get log => _log;

  set log(int value) {
    _log = value;
    notifyListeners();
  }

  int _logSignup = 0;

  int get logSignup => _logSignup;

  set logSignup(int value) {
    _logSignup = value;
    notifyListeners();
  }

  int _loginLoader = 0;

  int get loginLoader => _loginLoader;

  set loginLoader(int value) {
    _loginLoader = value;
    notifyListeners();
  }

  int _productState = 0;

  int get productState => _productState;

  set productState(int value) {
    _productState = value;
    notifyListeners();
  }

  bool _isLogin = false;

  bool get isLogin => _isLogin;

  set isLogin(bool value) {
    _isLogin = value;
  }

  Future<void> checkUser() async {
    isLogin = false;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String check = prefs.getString("email") ?? "";

    if (check.isNotEmpty) {
      isLogin = true;
    }
  }

  int _load = 0;

  int get load => _load;

  set load(int value) {
    Future.delayed(const Duration(seconds: 3));
    _load = value;
    notifyListeners();
  }

  bool _loading = false;

  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  bool _loadingSignUp = false;

  bool get loadingSignUp => _loadingSignUp;

  setLoadingSignUp(bool value) {
    _loadingSignUp = value;
    notifyListeners();
  }

  ProductCategoriesProvider() {
    fetchUserData();
    checkUser();
    fetchData();
    loginWithApi();
    fetchUserDetail();
    loginDataFromApi();
  }






  int checkGiftBill = 0;
  Future<void> fetchDataOfGiftsCard() async {
    toggleCardCount();

    final response = await http.get(Uri.parse('https://spiceshackus.com/wp-json/wc-pimwick/v1/pw-gift-cards?consumer key=ck_33fb5dae74953e8d8f552d2ff8cccc6b48bd3e51&consumer secret=cs_a87b5c5300da75bd2e7fc8876d09cb0ec3457f06'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      //print(response.body);
      for (var data in jsonData) {
        if(data['balance'] != null && data['number'] == codeGiftCard ){
          _myDataList.add(MyData(balance: data['balance'], data: data['number']));
          if (myDataList[0].data == codeGiftCard) {
            print("OKKKKKK");
            toggleCard();

            String myString = myDataList[0].balance;
            myString = myString.substring(0, myString.indexOf("."));
            int myNumber = int.parse(myString);
            print(myNumber);
            if(myTotal >= myNumber)
            {
              _total = checkGiftBill - myNumber ;
            }else{
              _total = myNumber ;
            }
            notifyListeners();

          }
        }
        print(data['id'].toString() + data['balance']);
      }

      //myDataList.clear();
      print(myDataList[0].data);
      print(myDataList[0].balance);
    } else {
      toggleCardCount();
      throw Exception('Failed to fetch data');
    }
  }

  int myTotal = 50;
  void subtractFromTotal() {
    print("_____________________");
    if (myDataList[0].data == codeGiftCard) {
      print("OKKKKKK");
      String myString = myDataList[0].balance;
      myString = myString.substring(0, myString.indexOf("."));
      int myNumber = int.parse(myString);
      print(myNumber);
      if(myTotal >= myNumber)
      {
        _total = myTotal - myNumber ;
      }else{
        _total = myNumber ;
      }
      notifyListeners();

    }
    // for (var myData in _myDataList) {
    //   if (myDataList[0].data == input) {
    //     print(myData.data.toString());
    //     print(myData.balance.toString());
    //     print("OKKKKKK");
    //   }
    // }

    notifyListeners();
  }





  List<CartItemModel> listDemo = [];
  List<ProductListModel> menuProducts = [];
  Temp temp = Temp(ID: "", email: "", nick: "");

  static Future clearSharedPref() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('email');
    prefs.remove('password');
    prefs.remove('cart_item');
    prefs.remove('total_price');
    //await prefs.clear();
  }

  Future<ProfileModel> fetchUserDetail() async {
    final response = await https.get(Uri.parse(
        'https://spiceshackus.com/wp-json/custom-plugin/login?username=hell@gmail.com&password=12345678'));

    if (response.statusCode == 200) {
      return ProfileModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }

  int _loadVariation = 0;

  int get loadVariation => _loadVariation;

  set loadVariation(int value) {
    _loadVariation = value;
    notifyListeners();
  }

  int _loadDataAPi = 0;

  int get loadDAtaAPi => _loadDataAPi;

  set loadDataAPi(int value) {
    _loadDataAPi = value;
    notifyListeners();
  }

  String crypto = 'For 3 Persons';
  String pp = '26';
  String yy = '10';
  var currentCurrency = [
    "For 3 Persons",
    "For 5 Persons",
  ];
  List<String> selectedItemValue = <String>[];
  List<String> selectedFeastValue = <String>[];

  List<DropdownMenuItem<String>> dropDownItem() {
    List<String> ddl = ["For 3 persons", "For 5 persons"];

    return ddl
        .map((value) => DropdownMenuItem(
              value: value,
              child: Text(value),
            ))
        .toList();
  }

  // bool _feastValidate = false;
  // int _feastValidateCount = 0;
  // int get feastValidateCount => _feastValidateCount;
  // bool get feastValidate => _feastValidate;


  List<bool> _feastValidate = [];

  List<bool> get feastValidate => _feastValidate;
  void toggleFeastValidate(index) {
    _feastValidate[index] = !_feastValidate[index];
    notifyListeners();
  }
  List<DropdownMenuItem<String>> dropDownFeastItem() {
    List<String> ddl = ["Half Tray","Full Tray"];

    return ddl
        .map((value) => DropdownMenuItem(
              value: value,
              child: Text(value),
            ))
        .toList();
  }

  List<bool> _familyCateringValidate = [];

  List<bool> get familyCateringValidate => _familyCateringValidate;
  void toggleFamilyCateringValidate(index) {
    _familyCateringValidate[index] = !_familyCateringValidate[index];
    notifyListeners();
  }
  // List<DropdownMenuItem<String>> dropDownFeastItem() {
  //   List<String> ddl = ["Half Tray","Full Tray"];
  //
  //   return ddl
  //       .map((value) => DropdownMenuItem(
  //     value: value,
  //     child: Text(value),
  //   ))
  //       .toList();
  // }

  String valID = '';
  String priceVariation = '';
  String newPriceVariation = '';

  //int orderId;
  variationDetail() async {
    final response = await https.get(Uri.parse(
        'https://spiceshackus.com/wp-json/wc/v3/products/$productIdOfValidation/variations/$variationId2?consumer key=ck_33fb5dae74953e8d8f552d2ff8cccc6b48bd3e51&consumer secret=cs_a87b5c5300da75bd2e7fc8876d09cb0ec3457f06&per page=100&parent=91'));

    //4992
    loadVariation = 0;
    if (response.statusCode == 200) {
      loadVariation = 1;
      priceVariation = jsonEncode(json.decode(response.body)["price"]);
      valID = jsonEncode(json.decode(response.body)["id"]);
      return ProfileModel.fromJson(jsonDecode(response.body));
    } else {
      loadVariation = 2;
      throw Exception('Failed to load album');
    }
  }

  Future<ProfileModel> variationDetail2() async {
    final response = await https.get(Uri.parse(
        'https://spiceshackus.com/wp-json/wc/v3/products/$productIdOfValidation/variations/$variationId2?consumer key=ck_33fb5dae74953e8d8f552d2ff8cccc6b48bd3e51&consumer secret=cs_a87b5c5300da75bd2e7fc8876d09cb0ec3457f06&per page=100&parent=91'));

    if (response.statusCode == 200) {
      valID = jsonEncode(json.decode(response.body)["id"]);
      return ProfileModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }

  fetchUserData() async {
    SharedPreferences obj = await SharedPreferences.getInstance();
    String email = obj.getString("email") ?? "";
    String password = obj.getString("password") ?? "";

    final String apiUrl =
        "https://spiceshackus.com/wp-json/custom-plugin/login?username=$email&password=$password";

    var result = await https.get(Uri.parse(apiUrl));

    temp = Temp(
        ID: json.decode(result.body)["data"]["ID"],
        email: json.decode(result.body)["data"]["user_email"],
        nick: json.decode(result.body)["data"]["user_nicename"]);
  }

  String _stateEmail = '';

  String get stateEmail => _stateEmail;

  set stateEmail(String value) {
    _stateEmail = value;
    notifyListeners();
  }

  String _stateName = '';

  String get stateName => _stateName;

  set stateName(String value) {
    _stateName = value;
    notifyListeners();
  }

  loginDataFromApi() async {
    String email = emailStateData;
    String password = passwordStateData;
    final String apiUrl =
        "https://spiceshackus.com/wp-json/custom-plugin/login?username=$email&password=$password";

    var result = await https.get(Uri.parse(apiUrl));
    String encodedMapName =
        jsonEncode(json.decode(result.body)["data"]["user_nicename"]);
    String encodedMapEmail =
        jsonEncode(json.decode(result.body)["data"]["user_email"]);
    SharedPreferences user = await SharedPreferences.getInstance();
    user.setString('NameLogin', encodedMapName);
    user.setString('EmailLogin', encodedMapEmail);
    encodedMapName = user.getString('NameLogin')!;
    encodedMapEmail = user.getString('EmailLogin')!;
    String rep = encodedMapEmail;
    stateEmail = rep.replaceAll(RegExp('["]'), '');
    String repName = encodedMapName;
    stateName = repName.replaceAll(RegExp('["]'), '');
  }



  loginWithApi() async {
    setLoading(true);
    String email = emailStateData;
    String password = passwordStateData;
    var request = https.Request(
        'GET',
        Uri.parse(
            "https://spiceshackus.com/wp-json/custom-plugin/login?username=$email&password=$password"));
    https.StreamedResponse loginResponse = await request.send();
    var respon = loginResponse.statusCode;
    log = respon.toInt();
    List<LoginModel> loginData = [];

    try {
      if (kDebugMode) {
        print("Email in api :- $email");
      }
      if (kDebugMode) {
        print("Password in api :- $password");
      }

      if (respon == 200) {
        if (kDebugMode) {
          print(request);
        }
        setLoading(false);
        log = respon;

        if (kDebugMode) {
          print("Response :- ${loginResponse.statusCode.toString()}");
        }
        var rawData = await loginResponse.stream.bytesToString();
        List<dynamic> dataInJsonDecode = jsonDecode(rawData);
        for (var element in dataInJsonDecode) {
          loginData.add(element);
        }
      } else {}
      return loginData;
    } catch (e) {
      e;
    }
    return loginData;
  }

  signUpWithApi() async {
    final uri = Uri.parse(
        'https://spiceshackus.com/wp-json/wc/v3/customers?consumer key=ck_33fb5dae74953e8d8f552d2ff8cccc6b48bd3e51&consumer secret=cs_a87b5c5300da75bd2e7fc8876d09cb0ec3457f06');
    final headers = {'Content-Type': 'application/json'};
    Map<String, dynamic> body = {
      "email": emailSignup,
      "first_name": firstnameSignup,
      "last_name": lastNameSignup,
      "username": userNameSignup,
      "password": passwordSignup,
    };
    String jsonBody = json.encode(body);
    final encoding = Encoding.getByName('utf-8');
    Response response = await post(
      uri,
      headers: headers,
      body: jsonBody,
      encoding: encoding,
    );
    int statusCode = response.statusCode;
    try {
      if (statusCode == 200 || statusCode == 201) {
        setLoading(false);
        logSignup = response.statusCode;
      } else {
      }
    } catch (e) {
      if (kDebugMode) {
      }
      ToastMessage().toastMessage("please re enter data!");
    }
  }

  //all prducts
  fetchData() async {
    state = 0;
    try {
      WooCommerceAPI wooCommerceAPI = WooCommerceAPI(
        url: "https://spiceshackus.com",
        consumerKey: "ck_33fb5dae74953e8d8f552d2ff8cccc6b48bd3e51",
        consumerSecret: "cs_a87b5c5300da75bd2e7fc8876d09cb0ec3457f06",
      );

      menuProducts = [];

      List products = await wooCommerceAPI.getAsync(
        "products?&per page=100",
      );
      for (var element in products) {
        menuProducts.add(ProductListModel.fromJson(element));
      }
      state = 1;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }


  //loginData
  List<LoginModel> loginData = [];

  void updateLoginData(List<LoginModel> loginData) {
    this.loginData = loginData;
    if (loginData != []) {
      loginLoader = 1;
      notifyListeners();
    } else {
      loginLoader = 0;
      notifyListeners();
    }
  }

  List<ProfileModel> myProfileList = [];

  void updateProfileData(List<ProfileModel> myProfileList) {
    this.myProfileList = myProfileList;
    if (myProfileList != []) {
      profileLoader = 1;
      notifyListeners();
    } else {
      profileLoader = 0;
      notifyListeners();
    }
  }

  List<CouponsModel> couponsData = [];

  void updateCoupon(List<CouponsModel> couponsData) {
    this.couponsData = couponsData;
    if (couponsData != []) {
      couponState = 1;
      notifyListeners();
    } else {
      couponState = 0;
      notifyListeners();
    }
  }

  List<CartItemModel> dataProductList = [];

  void updateDataProductCategoriesModel(List<CartItemModel> dataProductList) {
    this.dataProductList = dataProductList;
    if (dataProductList != []) {
      state = 1;
      notifyListeners();
    } else {
      state = 0;
      notifyListeners();
    }
  }

  List<CartItemModel> dataCateringList = [];

  void updateDataCateringModel(List<CartItemModel> dataCateringList) {
    this.dataCateringList = dataCateringList;
    if (dataCateringList != []) {
      state = 1;
      notifyListeners();
    } else {
      state = 0;
      notifyListeners();
    }
  }

  int _loadCatering = 0;

  int get loadCatering => _loadCatering;

  set loadCatering(int value) {
    _loadCatering = value;
    notifyListeners();
  }

  List<CateringModel> cateringProductsList = [];

  void updateCateringProductsListModel(List<CateringModel> cateringProductsList) {
    this.cateringProductsList = cateringProductsList;
    loadCatering = 0;
    if (cateringProductsList != []) {
      Future.delayed(const Duration(seconds: 3));
      loadCatering = 1;
      notifyListeners();
    } else {
      Future.delayed(const Duration(seconds: 3));
      loadCatering = 0;
      notifyListeners();
    }
  }
  int _feastRamadan = 0;

  int get feastRamadan => _feastRamadan;

  set feastRamadan(int value) {
    _feastRamadan = value;
    notifyListeners();
  }
  List<CateringModel> cateringFamilyFeastList = [];

  void updateCateringFamilyFeastListModel(List<CateringModel> cateringFamilyFeastList) {
    this.cateringFamilyFeastList = cateringFamilyFeastList;
    feastRamadan = 0;
    if (cateringFamilyFeastList != []) {
      Future.delayed(const Duration(seconds: 3));
      feastRamadan = 1;
      notifyListeners();
    } else {
      Future.delayed(const Duration(seconds: 3));
      feastRamadan = 0;
      notifyListeners();
    }
  }
  int _loadRamadan = 0;

  int get loadRamadan => _loadRamadan;

  set loadRamadan(int value) {
    _loadRamadan = value;
    notifyListeners();
  }
  List<CateringModel> cateringRamadanList = [];

  void updateCateringRamadanListModel(List<CateringModel> cateringRamadanList) {
    this.cateringRamadanList = cateringRamadanList;
    loadRamadan = 0;
    if (cateringRamadanList != []) {
      Future.delayed(const Duration(seconds: 3));
      loadRamadan = 1;
      notifyListeners();
    } else {
      Future.delayed(const Duration(seconds: 3));
      loadRamadan = 0;
      notifyListeners();
    }
  }

  /// Family Feast Start


  final List<CheckboxModel> _checkApIFF = [
    CheckboxModel(label: 'None', id: ''),
    CheckboxModel(label: 'Chicken Samosa', id: ''),
    CheckboxModel(label: 'Veg Samosa', id: ''),
    CheckboxModel(label: 'Vegetable Pakoda', id: ''),
  ];

  List<CheckboxModel> get checkApIFF => _checkApIFF;

  void updateSelectedCheckApIFF(int index) {
    for (int i = 0; i < _checkApIFF.length; i++) {
      _checkApIFF[i].isSelected = i == index;
    }
    notifyListeners();
  }

  final List<CheckboxModel> _checkApIIFF = [
    CheckboxModel(label: 'None', id: ''),
    CheckboxModel(label: 'Aloo Chat', id: ''),
    CheckboxModel(label: 'Samosa Chat', id: ''),
  ];

  List<CheckboxModel> get checkApIIFF => _checkApIIFF;

  void updateSelectedCheckApIIFF(int index) {
    for (int i = 0; i < _checkApIIFF.length; i++) {
      _checkApIIFF[i].isSelected = i == index;
    }
    notifyListeners();
  }


  final List<CheckboxModel> _checkE1FF = [
    CheckboxModel(label: 'None', id: ''),
    CheckboxModel(label: 'Veg Biryani', id: ''),
    CheckboxModel(label: 'Chicken Biryani', id: ''),
    CheckboxModel(label: 'Veg Fried Rice', id: ''),
    CheckboxModel(label: 'Chicken Fried Rice', id: ''),
    CheckboxModel(label: 'Chicken Pulav', id: ''),
  ];

  List<CheckboxModel> get checkE1FF => _checkE1FF;

  void updateSelectedCheckE1FF(int index) {
    for (int i = 0; i < _checkE1FF.length; i++) {
      _checkE1FF[i].isSelected = i == index;
    }
    notifyListeners();
  }

  final List<CheckboxModel> _checkE2FF = [
    CheckboxModel(label: 'None', id: ''),
    CheckboxModel(label: 'Tandoori Chicken', id: ''),
    CheckboxModel(label: 'Pepper Chicken', id: ''),
    CheckboxModel(label: 'Reshmi Chicken Sheek Kabob', id: ''),
  ];

  List<CheckboxModel> get checkE2FF => _checkE2FF;

  void updateSelectedCheckE2FF(int index) {
    for (int i = 0; i < _checkE2FF.length; i++) {
      _checkE2FF[i].isSelected = i == index;
    }
    notifyListeners();
  }

  final List<CheckboxModel> _checkE3FF = [
    CheckboxModel(label: 'None', id: ''),
    CheckboxModel(label: 'Chicken Curry with Bone', id: ''),
    CheckboxModel(label: 'Chicken Haleem', id: ''),
  ];

  List<CheckboxModel> get checkE3FF => _checkE3FF;

  void updateSelectedCheckE3FF(int index) {
    for (int i = 0; i < _checkE3FF.length; i++) {
      _checkE3FF[i].isSelected = i == index;
    }
    notifyListeners();
  }

  final List<CheckboxModel> _checkBreadFF = [
    CheckboxModel(label: 'None', id: ''),
    CheckboxModel(label: 'Butter Naan', id: ''),
  ];

  List<CheckboxModel> get checkBreadFF => _checkBreadFF;

  void updateSelectedCheckBreadFF(int index) {
    for (int i = 0; i < _checkBreadFF.length; i++) {
      _checkBreadFF[i].isSelected = i == index;
    }
    notifyListeners();
  }


  final List<CheckboxModel> _checkC1FF = [
    CheckboxModel(label: 'None', id: ''),
    CheckboxModel(label: 'Raitha', id: ''),
  ];

  List<CheckboxModel> get checkC1FF => _checkC1FF;

  void updateSelectedCheckC1FF(int index) {
    for (int i = 0; i < _checkC1FF.length; i++) {
      _checkC1FF[i].isSelected = i == index;
    }
    notifyListeners();
  }

  final List<CheckboxModel> _checkC2FF = [
    CheckboxModel(label: 'None', id: ''),
    CheckboxModel(label: 'Mint Chutney', id: ''),
  ];

  List<CheckboxModel> get checkC2FF => _checkC2FF;

  void updateSelectedCheckC2FF(int index) {
    for (int i = 0; i < _checkC2FF.length; i++) {
      _checkC2FF[i].isSelected = i == index;
    }
    notifyListeners();
  }
  final List<CheckboxModel> _checkDessertsFF = [
    CheckboxModel(label: 'None', id: ''),
    CheckboxModel(label: 'Gulab Jamun', id: ''),
    CheckboxModel(label: 'Rice Kheer', id: ''),
    CheckboxModel(label: 'Fruit Pudding', id: ''),
    CheckboxModel(label: 'Gajar Halwa', id: ''),
  ];
  List<CheckboxModel> get checkDessertsFF => _checkDessertsFF;

  void updateSelectedCheckDessertsFF(int index) {
    for (int i = 0; i < _checkDessertsFF.length; i++) {
      _checkDessertsFF[i].isSelected = i == index;
    }
    notifyListeners();
  }
  bool _isNaanFF = false;
  int _naanCountFF = 0;
  bool get isNaanFF => _isNaanFF;
  int get naanCountFF => _naanCountFF;

  void toggleNaanFF() {
    _isNaanFF = !_isNaanFF;
    _naanCountFF += _isNaanFF ? 1 : -1;
    _updatePriceFF();
    notifyListeners();
  }
  int _counterAddOnsFF = 1;
  double naanAddOnsFF = 0.50;
  int get counterAddOnsFF => _counterAddOnsFF;
  void incrementFF() {
    _counterAddOnsFF++;
    _isNaanFF = false;
    naanAddOnsFF = naanAddOnsFF + 0.50;

    print(naanAddOnsFF.toString());
    notifyListeners();
  }


  void decrementFF() {
    _isNaanFF = false;
    if (_counterAddOnsFF > 0) {
      _counterAddOnsFF--;
      naanAddOnsFF = naanAddOnsFF - 0.50;
      print(naanAddOnsFF.toString());
      notifyListeners();
    }
  }

  bool _isPlatesFF = false;
  int _platesCountFF = 0;
  bool get isPlatesFF => _isPlatesFF;
  int get platesCountFF => _platesCountFF;

  void togglePlatesFF() {
    _isPlatesFF = !_isPlatesFF;
    _platesCountFF += _isPlatesFF ? 1 : -1;
    _updatePriceFF();
    notifyListeners();
  }
  int _counterPlatesAddOnsFF = 1;
  double platesAddOnsFF = 0.25;
  int get counterPlatesAddOnsFF => _counterPlatesAddOnsFF;
  void incrementPlatesFF() {
    _counterPlatesAddOnsFF++;
    _isPlatesFF = false;
    platesAddOnsFF = platesAddOnsFF + 0.25;

    print(platesAddOnsFF.toString());
    notifyListeners();
  }


  void decrementPlatesFF() {
    _isPlatesFF = false;
    if (_counterPlatesAddOnsFF > 0) {
      _counterPlatesAddOnsFF--;
      platesAddOnsFF = platesAddOnsFF - 0.25;
      print(platesAddOnsFF.toString());
      notifyListeners();
    }
  }

  bool _isBottleFF = false;
  int _bottleCountFF = 0;
  bool get isBottleFF => _isBottleFF;
  int get BottleCountFF => _bottleCountFF;

  void toggleBottleFF() {
    _isBottleFF = !_isBottleFF;
    _bottleCountFF += _isBottleFF ? 1 : -1;
    _updatePriceFF();
    notifyListeners();
  }
  int _counterBottleAddOnsFF = 1;
  double bottleAddOnsFF = 0.50;
  int get counterBottleAddOnsFF => _counterBottleAddOnsFF;
  void incrementBottleFF() {
    _counterBottleAddOnsFF++;
    _isBottleFF = false;
    bottleAddOnsFF = bottleAddOnsFF + 0.50;

    print(bottleAddOnsFF.toString());
    notifyListeners();
  }


  void decrementBottleFF() {
    _isBottleFF = false;
    if (_counterBottleAddOnsFF > 0) {
      _counterBottleAddOnsFF--;
      bottleAddOnsFF = bottleAddOnsFF - 0.50;
      print(bottleAddOnsFF.toString());
      notifyListeners();
    }
  }

  bool _isMangoFF = false;
  int _mangoCountFF = 0;
  bool get isMangoFF => _isMangoFF;
  int get mangoCountFF => _mangoCountFF;

  void toggleMangoFF() {
    _isMangoFF = !_isMangoFF;
    _mangoCountFF += _isMangoFF ? 1 : -1;
    _updatePriceFF();
    notifyListeners();
  }
  int _counterMangoAddOnsFF= 1;
  double mangoAddOnsFF = 1.00;
  int get counterMangoAddOnsFF => _counterMangoAddOnsFF;
  void incrementMangoFF() {
    _counterMangoAddOnsFF++;
    _isMangoFF = false;
    mangoAddOnsFF = mangoAddOnsFF + 1.00;

    print(mangoAddOnsFF.toString());
    notifyListeners();
  }


  void decrementMangoFF() {
    _isMangoFF = false;
    if (_counterMangoAddOnsFF > 0) {
      _counterMangoAddOnsFF--;
      mangoAddOnsFF = mangoAddOnsFF - 1.00;
      print(mangoAddOnsFF.toString());
      notifyListeners();
    }
  }

  double _priceFF = 39.99;


  double get priceFF => _priceFF;


  void _updatePriceFF() {
    _priceFF = 39.99;
    if (_isBottleFF) {
      _priceFF += bottleAddOnsFF;
    }
    if (_isPlatesFF) {
      _priceFF += platesAddOnsFF;
    }
    if (_isMangoFF) {
      _priceFF += mangoAddOnsFF;
    }if (_isNaanFF) {

      _priceFF += naanAddOnsFF;
    }

    notifyListeners();
  }
  /// Family Feast ended



  /// Family Feast Start


  final List<CheckboxModel> _checkApILBox = [
    CheckboxModel(label: 'None', id: ''),
    CheckboxModel(label: 'Chicken Samosa', id: ''),
    CheckboxModel(label: 'Veg Samosa', id: ''),
    CheckboxModel(label: 'Vegetable Pakoda', id: ''),
  ];

  List<CheckboxModel> get checkApILBox => _checkApILBox;

  void updateSelectedCheckApILBox(int index) {
    for (int i = 0; i < _checkApILBox.length; i++) {
      _checkApILBox[i].isSelected = i == index;
    }
    notifyListeners();
  }

  final List<CheckboxModel> _checkApIILBox = [
    CheckboxModel(label: 'None', id: ''),
    CheckboxModel(label: 'Aloo Chat', id: ''),
    CheckboxModel(label: 'Samosa Chat', id: ''),
  ];

  List<CheckboxModel> get checkApIILBox => _checkApIILBox;

  void updateSelectedCheckApIILBox(int index) {
    for (int i = 0; i < _checkApIILBox.length; i++) {
      _checkApIILBox[i].isSelected = i == index;
    }
    notifyListeners();
  }


  final List<CheckboxModel> _checkE1LBox = [
    CheckboxModel(label: 'None', id: ''),
    CheckboxModel(label: 'Veg Biryani', id: ''),
    CheckboxModel(label: 'Chicken Biryani', id: ''),
    CheckboxModel(label: 'Veg Fried Rice', id: ''),
    CheckboxModel(label: 'Chicken Fried Rice', id: ''),
    CheckboxModel(label: 'Chicken Pulav', id: ''),
  ];

  List<CheckboxModel> get checkE1LBox => _checkE1LBox;

  void updateSelectedCheckE1LBox(int index) {
    for (int i = 0; i < _checkE1LBox.length; i++) {
      _checkE1LBox[i].isSelected = i == index;
    }
    notifyListeners();
  }

  final List<CheckboxModel> _checkE2LBox = [
    CheckboxModel(label: 'None', id: ''),
    CheckboxModel(label: 'Tandoori Chicken', id: ''),
    CheckboxModel(label: 'Pepper Chicken', id: ''),
    CheckboxModel(label: 'Reshmi Chicken Sheek Kabob', id: ''),
  ];

  List<CheckboxModel> get checkE2LBox => _checkE2LBox;

  void updateSelectedCheckE2LBox(int index) {
    for (int i = 0; i < _checkE2LBox.length; i++) {
      _checkE2LBox[i].isSelected = i == index;
    }
    notifyListeners();
  }

  final List<CheckboxModel> _checkE3LBox = [
    CheckboxModel(label: 'None', id: ''),
    CheckboxModel(label: 'Chicken Curry with Bone', id: ''),
    CheckboxModel(label: 'Chicken Haleem', id: ''),
  ];

  List<CheckboxModel> get checkE3LBox => _checkE3LBox;

  void updateSelectedCheckE3LBox(int index) {
    for (int i = 0; i < _checkE3LBox.length; i++) {
      _checkE3LBox[i].isSelected = i == index;
    }
    notifyListeners();
  }

  final List<CheckboxModel> _checkBreadLBox = [
    CheckboxModel(label: 'None', id: ''),
    CheckboxModel(label: 'Butter Naan', id: ''),
  ];

  List<CheckboxModel> get checkBreadLBox => _checkBreadLBox;

  void updateSelectedCheckBreadLBox(int index) {
    for (int i = 0; i < _checkBreadLBox.length; i++) {
      _checkBreadLBox[i].isSelected = i == index;
    }
    notifyListeners();
  }


  final List<CheckboxModel> _checkC1LBox = [
    CheckboxModel(label: 'None', id: ''),
    CheckboxModel(label: 'Raitha', id: ''),
  ];

  List<CheckboxModel> get checkC1LBox => _checkC1LBox;

  void updateSelectedCheckC1LBox(int index) {
    for (int i = 0; i < _checkC1LBox.length; i++) {
      _checkC1LBox[i].isSelected = i == index;
    }
    notifyListeners();
  }

  final List<CheckboxModel> _checkC2LBox = [
    CheckboxModel(label: 'None', id: ''),
    CheckboxModel(label: 'Mint Chutney', id: ''),
  ];

  List<CheckboxModel> get checkC2LBox => _checkC2LBox;

  void updateSelectedCheckC2LBox(int index) {
    for (int i = 0; i < _checkC2LBox.length; i++) {
      _checkC2LBox[i].isSelected = i == index;
    }
    notifyListeners();
  }
  final List<CheckboxModel> _checkDessertsLBox = [
    CheckboxModel(label: 'None', id: ''),
    CheckboxModel(label: 'Gulab Jamun', id: ''),
    CheckboxModel(label: 'Rice Kheer', id: ''),
    CheckboxModel(label: 'Fruit Pudding', id: ''),
    CheckboxModel(label: 'Gajar Halwa', id: ''),
  ];
  List<CheckboxModel> get checkDessertsLBox => _checkDessertsLBox;

  void updateSelectedCheckDessertsLBox(int index) {
    for (int i = 0; i < _checkDessertsLBox.length; i++) {
      _checkDessertsLBox[i].isSelected = i == index;
    }
    notifyListeners();
  }
  bool _isNaanLBox = false;
  int _naanCountLBox = 0;
  bool get isNaanLBox => _isNaanLBox;
  int get naanCountLBox => _naanCountLBox;

  void toggleNaanLBox() {
    _isNaanLBox = !_isNaanLBox;
    _naanCountLBox += _isNaanLBox ? 1 : -1;
    _updatePriceLBox();
    notifyListeners();
  }
  int _counterAddOnsLBox = 1;
  double naanAddOnsLBox = 0.50;
  int get counterAddOnsLBox => _counterAddOnsLBox;
  void incrementLBox() {
    _counterAddOnsLBox++;
    _isNaanLBox = false;
    naanAddOnsLBox = naanAddOnsLBox + 0.50;

    print(naanAddOnsLBox.toString());
    notifyListeners();
  }


  void decrementLBox() {
    _isNaanLBox = false;
    if (_counterAddOnsLBox > 0) {
      _counterAddOnsLBox--;
      naanAddOnsLBox = naanAddOnsLBox - 0.50;
      print(naanAddOnsLBox.toString());
      notifyListeners();
    }
  }

  bool _isPlatesLBox = false;
  int _platesCountLBox = 0;
  bool get isPlatesLBox => _isPlatesLBox;
  int get platesCountLBox => _platesCountLBox;

  void togglePlatesLBox() {
    _isPlatesLBox = !_isPlatesLBox;
    _platesCountLBox += _isPlatesLBox ? 1 : -1;
    _updatePriceLBox();
    notifyListeners();
  }
  int _counterPlatesAddOnsLBox = 1;
  double platesAddOnsLBox = 0.25;
  int get counterPlatesAddOnsLBox => _counterPlatesAddOnsLBox;
  void incrementPlatesLBox() {
    _counterPlatesAddOnsLBox++;
    _isPlatesLBox = false;
    platesAddOnsLBox = platesAddOnsLBox + 0.25;

    print(platesAddOnsLBox.toString());
    notifyListeners();
  }


  void decrementPlatesLBox() {
    _isPlatesLBox = false;
    if (_counterPlatesAddOnsLBox > 0) {
      _counterPlatesAddOnsLBox--;
      platesAddOnsLBox = platesAddOnsLBox - 0.25;
      print(platesAddOnsLBox.toString());
      notifyListeners();
    }
  }

  bool _isBottleLBox = false;
  int _bottleCountLBox = 0;
  bool get isBottleLBox => _isBottleLBox;
  int get BottleCountLBox => _bottleCountLBox;

  void toggleBottleLBox() {
    _isBottleLBox = !_isBottleLBox;
    _bottleCountLBox += _isBottleLBox ? 1 : -1;
    _updatePriceLBox();
    notifyListeners();
  }
  int _counterBottleAddOnsLBox = 1;
  double bottleAddOnsLBox = 0.50;
  int get counterBottleAddOnsLBox => _counterBottleAddOnsLBox;
  void incrementBottleLBox() {
    _counterBottleAddOnsLBox++;
    _isBottleLBox = false;
    bottleAddOnsLBox = bottleAddOnsLBox + 0.50;

    print(bottleAddOnsLBox.toString());
    notifyListeners();
  }


  void decrementBottleLBox() {
    _isBottleLBox = false;
    if (_counterBottleAddOnsLBox > 0) {
      _counterBottleAddOnsLBox--;
      bottleAddOnsLBox = bottleAddOnsLBox - 0.50;
      print(bottleAddOnsLBox.toString());
      notifyListeners();
    }
  }

  bool _isMangoLBox = false;
  int _mangoCountLBox = 0;
  bool get isMangoLBox => _isMangoLBox;
  int get mangoCountLBox => _mangoCountLBox;

  void toggleMangoLBox() {
    _isMangoLBox = !_isMangoLBox;
    _mangoCountLBox += _isMangoLBox ? 1 : -1;
    _updatePriceLBox();
    notifyListeners();
  }
  int _counterMangoAddOnsLBox= 1;
  double mangoAddOnsLBox = 1.00;
  int get counterMangoAddOnsLBox => _counterMangoAddOnsLBox;
  void incrementMangoLBox() {
    _counterMangoAddOnsLBox++;
    _isMangoLBox = false;
    mangoAddOnsLBox = mangoAddOnsLBox + 1.00;

    print(mangoAddOnsLBox.toString());
    notifyListeners();
  }


  void decrementMangoLBox() {
    _isMangoLBox = false;
    if (_counterMangoAddOnsLBox > 0) {
      _counterMangoAddOnsLBox--;
      mangoAddOnsLBox = mangoAddOnsLBox - 1.00;
      print(mangoAddOnsLBox.toString());
      notifyListeners();
    }
  }

  double _priceLBox = 7.99;


  double get priceLBox => _priceLBox;


  void _updatePriceLBox() {
    _priceLBox = 7.99;
    if (_isBottleLBox) {
      _priceLBox += bottleAddOnsLBox;
    }
    if (_isPlatesLBox) {
      _priceLBox += platesAddOnsLBox;
    }
    if (_isMangoLBox) {
      _priceLBox += mangoAddOnsLBox;
    }if (_isNaanLBox) {

      _priceLBox += naanAddOnsLBox;
    }

    notifyListeners();
  }
  /// Lunch Box ended



  int _loadLunch = 0;

  int get loadLunch => _loadLunch;

  set loadLunch(int value) {
    _loadLunch = value;
    notifyListeners();
  }
  List<CateringModel> cateringLunchBoxList = [];

  void updateCateringLunchBoxListModel(List<CateringModel> cateringLunchBoxList) {
    this.cateringLunchBoxList = cateringRamadanList;
    loadLunch = 0;
    if (cateringLunchBoxList != []) {
      Future.delayed(const Duration(seconds: 3));
      loadLunch = 1;
      notifyListeners();
    } else {
      Future.delayed(const Duration(seconds: 3));
      loadLunch = 0;
      notifyListeners();
    }
  }



  int _loadEvent = 0;

  int get loadEvent => _loadEvent;

  set loadEvent(int value) {
    _loadEvent = value;
    notifyListeners();
  }
  List<CateringModel> cateringEventList = [];

  void updateCateringEventListModel(List<CateringModel> cateringEventList) {
    this.cateringEventList = cateringEventList;
    loadEvent = 0;
    if (cateringEventList != []) {
      Future.delayed(const Duration(seconds: 3));
      loadEvent = 1;
      notifyListeners();
    } else {
      Future.delayed(const Duration(seconds: 3));
      loadEvent = 0;
      notifyListeners();
    }
  }

  bool _isChecked = false;
  String _text = '';

  bool get isChecked => _isChecked;

  String get text => _text;

  void setChecked(bool isChecked) {
    _isChecked = isChecked;
    if (_isChecked) {
      _text = 'Checkbox is checked';
    } else {
      _text = '';
    }
    notifyListeners();
  }
  //check boxes Ramadan1 R1   ___________

  final List<CheckboxModel> _checkApIR1 = [
    CheckboxModel(label: 'None', id: ''),
    CheckboxModel(label: 'Veg Samosa', id: ''),
    CheckboxModel(label: 'Veg Pakora', id: ''),
  ];

  List<CheckboxModel> get checkApIR1 => _checkApIR1;

  void updateSelectedCheckApIR1(int index) {
    for (int i = 0; i < _checkApIR1.length; i++) {
      _checkApIR1[i].isSelected = i == index;
    }
    notifyListeners();
  }

  final List<CheckboxModel> _checkE1R1 = [
    CheckboxModel(label: 'None', id: ''),
    CheckboxModel(label: 'Chicken Biryani', id: ''),
    CheckboxModel(label: 'Veg Biryani', id: ''),
    CheckboxModel(label: 'Chicken Pulav', id: ''),
  ];

  List<CheckboxModel> get checkE1R1 => _checkE1R1;

  void updateSelectedCheckE1R1(int index) {
    for (int i = 0; i < _checkE1R1.length; i++) {
      _checkE1R1[i].isSelected = i == index;
    }
    notifyListeners();
  }

  final List<CheckboxModel> _checkE2R1 = [
    CheckboxModel(label: 'None', id: ''),
    CheckboxModel(label: 'Tandoori Chicken', id: ''),
    CheckboxModel(label: 'Pepper Chicken', id: ''),
  ];

  List<CheckboxModel> get checkE2R1 => _checkE2R1;

  void updateSelectedCheckE2R1(int index) {
    for (int i = 0; i < _checkE2R1.length; i++) {
      _checkE2R1[i].isSelected = i == index;
    }
    notifyListeners();
  }




  final List<CheckboxModel> _checkC1R1 = [
    CheckboxModel(label: 'None', id: ''),
    CheckboxModel(label: 'Raitha', id: ''),
  ];

  List<CheckboxModel> get checkC1R1 => _checkC1R1;

  void updateSelectedCheckC1R1(int index) {
    for (int i = 0; i < _checkC1R1.length; i++) {
      _checkC1R1[i].isSelected = i == index;
    }
    notifyListeners();
  }


  final List<CheckboxModel> _checkDessertsR1 = [
    CheckboxModel(label: 'None', id: ''),
    CheckboxModel(label: 'Gulab Jamun', id: ''),
    CheckboxModel(label: 'Rice Kheer', id: ''),
  ];

  List<CheckboxModel> get checkDessertsR1 => _checkDessertsR1;

  void updateSelectedCheckDessertsR1(int index) {
    for (int i = 0; i < _checkDessertsR1.length; i++) {
      _checkDessertsR1[i].isSelected = i == index;
    }
    notifyListeners();
  }
  //check boxes Ramadan1 R1 ended ___________
  ///R1 data
  bool _isNaanR1 = false;
  int _naanCountR1 = 0;
  bool get isNaanR1 => _isNaanR1;
  int get naanCountR1 => _naanCountR1;

  void toggleNaanR1() {
    _isNaanR1 = !_isNaanR1;
    _naanCountR1 += _isNaanR1 ? 1 : -1;
    _updatePriceR1();
    notifyListeners();
  }
  int _counterAddOnsR1 = 1;
  double naanAddOnsR1 = 0.50;
  int get counterAddOnsR1 => _counterAddOnsR1;
  void incrementR1() {
    _counterAddOnsR1++;
    _isNaanR1 = false;
    naanAddOnsR1 = naanAddOnsR1 + 0.50;

    print(naanAddOnsR1.toString());
    notifyListeners();
  }


  void decrementR1() {
    _isNaanR1 = false;
    if (_counterAddOnsR1 > 0) {
      _counterAddOnsR1--;
      naanAddOnsR1 = naanAddOnsR1 - 0.50;
      print(naanAddOnsR1.toString());
      notifyListeners();
    }
  }

  bool _isPlatesR1 = false;
  int _platesCountR1 = 0;
  bool get isPlatesR1 => _isPlatesR1;
  int get platesCountR1 => _platesCountR1;

  void togglePlatesR1() {
    _isPlatesR1 = !_isPlatesR1;
    _platesCountR1 += _isPlatesR1 ? 1 : -1;
    _updatePriceR1();
    notifyListeners();
  }
  int _counterPlatesAddOnsR1 = 1;
  double platesAddOnsR1 = 0.25;
  int get counterPlatesAddOnsR1 => _counterPlatesAddOnsR1;
  void incrementPlatesR1() {
    _counterPlatesAddOnsR1++;
    _isPlatesR1 = false;
    platesAddOnsR1 = platesAddOnsR1 + 0.25;

    print(platesAddOnsR1.toString());
    notifyListeners();
  }


  void decrementPlatesR1() {
    _isPlatesR1 = false;
    if (_counterPlatesAddOnsR1 > 0) {
      _counterPlatesAddOnsR1--;
      platesAddOnsR1 = platesAddOnsR1 - 0.25;
      print(platesAddOnsR1.toString());
      notifyListeners();
    }
  }

  bool _isBottleR1 = false;
  int _bottleCountR1 = 0;
  bool get isBottleR1 => _isBottleR1;
  int get BottleCountR1 => _bottleCountR1;

  void toggleBottleR1() {
    _isBottleR1 = !_isBottleR1;
    _bottleCountR1 += _isBottleR1 ? 1 : -1;
    _updatePriceR1();
    notifyListeners();
  }
  int _counterBottleAddOnsR1 = 1;
  double bottleAddOnsR1 = 0.50;
  int get counterBottleAddOnsR1 => _counterBottleAddOnsR1;
  void incrementBottleR1() {
    _counterBottleAddOnsR1++;
    _isBottleR1 = false;
    bottleAddOnsR1 = bottleAddOnsR1 + 0.50;

    print(bottleAddOnsR1.toString());
    notifyListeners();
  }


  void decrementBottleR1() {
    _isBottleR1 = false;
    if (_counterBottleAddOnsR1 > 0) {
      _counterBottleAddOnsR1--;
      bottleAddOnsR1 = bottleAddOnsR1 - 0.50;
      print(bottleAddOnsR1.toString());
      notifyListeners();
    }
  }

  bool _isMangoR1 = false;
  int _mangoCountR1 = 0;
  bool get isMangoR1 => _isMangoR1;
  int get mangoCountR1 => _mangoCountR1;

  void toggleMangoR1() {
    _isMangoR1 = !_isMangoR1;
    _mangoCountR1 += _isMangoR1 ? 1 : -1;
    _updatePriceR1();
    notifyListeners();
  }
  int _counterMangoAddOnsR1= 1;
  double mangoAddOnsR1 = 1.00;
  int get counterMangoAddOnsR1 => _counterMangoAddOnsR1;
  void incrementMangoR1() {
    _counterMangoAddOnsR1++;
    _isMangoR1 = false;
    mangoAddOnsR1 = mangoAddOnsR1 + 1.00;

    print(mangoAddOnsR1.toString());
    notifyListeners();
  }


  void decrementMangoR1() {
    _isMangoR1 = false;
    if (_counterMangoAddOnsR1 > 0) {
      _counterMangoAddOnsR1--;
      mangoAddOnsR1 = mangoAddOnsR1 - 1.00;
      print(mangoAddOnsR1.toString());
      notifyListeners();
    }
  }

  double _priceR1 = 7.99;


  double get priceR1 => _priceR1;


  void _updatePriceR1() {
    _priceR1 = 7.99;
    if (_isBottleR1) {
      _priceR1 += bottleAddOnsR1;
    }
    if (_isPlatesR1) {
      _priceR1 += platesAddOnsR1;
    }
    if (_isMangoR1) {
      _priceR1 += mangoAddOnsR1;
    }if (_isNaanR1) {

      _priceR1 += naanAddOnsR1;
    }

    notifyListeners();
  }
  ///R1 addons data ended

  //check boxes Ramadan2 R2   ___________

  final List<CheckboxModel> _checkApIR2 = [
    CheckboxModel(label: 'None', id: ''),
    CheckboxModel(label: 'Veg Samosa', id: ''),
    CheckboxModel(label: 'Veg Pakora', id: ''),
  ];

  List<CheckboxModel> get checkApIR2 => _checkApIR2;

  void updateSelectedCheckApIR2(int index) {
    for (int i = 0; i < _checkApIR2.length; i++) {
      _checkApIR2[i].isSelected = i == index;
    }
    notifyListeners();
  }

  final List<CheckboxModel> _checkE1R2 = [
    CheckboxModel(label: 'None', id: ''),
    CheckboxModel(label: 'Chicken Biryani', id: ''),
    CheckboxModel(label: 'Chicken Pulav', id: ''),
    CheckboxModel(label: 'Veg Biryani', id: ''),
  ];

  List<CheckboxModel> get checkE1R2 => _checkE1R2;

  void updateSelectedCheckE1R2(int index) {
    for (int i = 0; i < _checkE1R2.length; i++) {
      _checkE1R2[i].isSelected = i == index;
    }
    notifyListeners();
  }

  final List<CheckboxModel> _checkE2R2 = [
    CheckboxModel(label: 'None', id: ''),
    CheckboxModel(label: 'Tandoori Chicken', id: ''),
    CheckboxModel(label: 'Pepper Chicken', id: ''),
  ];

  List<CheckboxModel> get checkE2R2 => _checkE2R2;

  void updateSelectedCheckE2R2(int index) {
    for (int i = 0; i < _checkE2R2.length; i++) {
      _checkE2R2[i].isSelected = i == index;
    }
    notifyListeners();
  }

  final List<CheckboxModel> _checkE3R2 = [
    CheckboxModel(label: 'None', id: ''),
    CheckboxModel(label: 'Chicken Curry with Bone', id: ''),
  ];

  List<CheckboxModel> get checkE3R2 => _checkE3R2;

  void updateSelectedCheckE3R2(int index) {
    for (int i = 0; i < _checkE3R2.length; i++) {
      _checkE3R2[i].isSelected = i == index;
    }
    notifyListeners();
  }
  final List<CheckboxModel> _checkBreadR2 = [
    CheckboxModel(label: 'None', id: ''),
    CheckboxModel(label: 'Butter Naan', id: ''),
  ];

  List<CheckboxModel> get checkBreadR2 => _checkBreadR2;

  void updateSelectedCheckBreadR2(int index) {
    for (int i = 0; i < _checkBreadR2.length; i++) {
      _checkBreadR2[i].isSelected = i == index;
    }
    notifyListeners();
  }


  final List<CheckboxModel> _checkC1R2 = [
    CheckboxModel(label: 'None', id: ''),
    CheckboxModel(label: 'Raitha', id: ''),
  ];

  List<CheckboxModel> get checkC1R2 => _checkC1R2;

  void updateSelectedCheckC1R2(int index) {
    for (int i = 0; i < _checkC1R2.length; i++) {
      _checkC1R2[i].isSelected = i == index;
    }
    notifyListeners();
  }

  final List<CheckboxModel> _checkC2R2 = [
    CheckboxModel(label: 'None', id: ''),
    CheckboxModel(label: 'Mint Chutney', id: ''),
  ];

  List<CheckboxModel> get checkC2R2 => _checkC2R2;

  void updateSelectedCheckC2R2(int index) {
    for (int i = 0; i < _checkC2R2.length; i++) {
      _checkC2R2[i].isSelected = i == index;
    }
    notifyListeners();
  }
  final List<CheckboxModel> _checkDessertsR2 = [
    CheckboxModel(label: 'None', id: ''),
    CheckboxModel(label: 'Gulab Jamun', id: ''),
    CheckboxModel(label: 'Rice Kheer', id: ''),
    CheckboxModel(label: 'Fruit Pudding', id: ''),
  ];

  List<CheckboxModel> get checkDessertsR2 => _checkDessertsR2;

  void updateSelectedCheckDessertsR2(int index) {
    for (int i = 0; i < _checkDessertsR2.length; i++) {
      _checkDessertsR2[i].isSelected = i == index;
    }
    notifyListeners();
  }
  //check boxes Ramadan2 R2 ended ___________
  ///R2 data
  bool _isNaanR2 = false;
  int _naanCountR2 = 0;
  bool get isNaanR2 => _isNaanR2;
  int get naanCountR2 => _naanCountR2;

  void toggleNaanR2() {
    _isNaanR2 = !_isNaanR2;
    _naanCountR2 += _isNaanR2 ? 1 : -1;
    _updatePriceR2();
    notifyListeners();
  }
  int _counterAddOnsR2 = 1;
  double naanAddOnsR2 = 0.50;
  int get counterAddOnsR2 => _counterAddOnsR2;
  void incrementR2() {
    _counterAddOnsR2++;
    _isNaanR2 = false;
    naanAddOnsR2 = naanAddOnsR2 + 0.50;

    print(naanAddOnsR2.toString());
    notifyListeners();
  }


  void decrementR2() {
    _isNaanR2 = false;
    if (_counterAddOnsR2 > 0) {
      _counterAddOnsR2--;
      naanAddOnsR2 = naanAddOnsR2 - 0.50;
      print(naanAddOnsR2.toString());
      notifyListeners();
    }
  }

  bool _isPlatesR2 = false;
  int _platesCountR2 = 0;
  bool get isPlatesR2 => _isPlatesR2;
  int get platesCountR2 => _platesCountR2;

  void togglePlatesR2() {
    _isPlatesR2 = !_isPlatesR2;
    _platesCountR2 += _isPlatesR2 ? 1 : -1;
    _updatePriceR2();
    notifyListeners();
  }
  int _counterPlatesAddOnsR2 = 1;
  double platesAddOnsR2 = 0.25;
  int get counterPlatesAddOnsR2 => _counterPlatesAddOnsR2;
  void incrementPlatesR2() {
    _counterPlatesAddOnsR2++;
    _isPlatesR2 = false;
    platesAddOnsR2 = platesAddOnsR2 + 0.25;

    print(platesAddOnsR2.toString());
    notifyListeners();
  }


  void decrementPlatesR2() {
    _isPlatesR2 = false;
    if (_counterPlatesAddOnsR2 > 0) {
      _counterPlatesAddOnsR2--;
      platesAddOnsR2 = platesAddOnsR2 - 0.25;
      print(platesAddOnsR2.toString());
      notifyListeners();
    }
  }

  bool _isBottleR2 = false;
  int _bottleCountR2 = 0;
  bool get isBottleR2 => _isBottleR2;
  int get BottleCountR2 => _bottleCountR2;

  void toggleBottleR2() {
    _isBottleR2 = !_isBottleR2;
    _bottleCountR2 += _isBottleR2 ? 1 : -1;
    _updatePriceR2();
    notifyListeners();
  }
  int _counterBottleAddOnsR2 = 1;
  double bottleAddOnsR2 = 0.50;
  int get counterBottleAddOnsR2 => _counterBottleAddOnsR2;
  void incrementBottleR2() {
    _counterBottleAddOnsR2++;
    _isBottleR2 = false;
    bottleAddOnsR2 = bottleAddOnsR2 + 0.50;

    print(bottleAddOnsR2.toString());
    notifyListeners();
  }


  void decrementBottleR2() {
    _isBottleR2 = false;
    if (_counterBottleAddOnsR2 > 0) {
      _counterBottleAddOnsR2--;
      bottleAddOnsR2 = bottleAddOnsR2 - 0.50;
      print(bottleAddOnsR2.toString());
      notifyListeners();
    }
  }

  bool _isMangoR2 = false;
  int _mangoCountR2 = 0;
  bool get isMangoR2 => _isMangoR2;
  int get mangoCountR2 => _mangoCountR2;

  void toggleMangoR2() {
    _isMangoR2 = !_isMangoR2;
    _mangoCountR2 += _isMangoR2 ? 1 : -1;
    _updatePriceR2();
    notifyListeners();
  }
  int _counterMangoAddOnsR2= 1;
  double mangoAddOnsR2 = 1.00;
  int get counterMangoAddOnsR2 => _counterMangoAddOnsR2;
  void incrementMangoR2() {
    _counterMangoAddOnsR2++;
    _isMangoR2 = false;
    mangoAddOnsR2 = mangoAddOnsR2 + 1.00;

    print(mangoAddOnsR2.toString());
    notifyListeners();
  }


  void decrementMangoR2() {
    _isMangoR2 = false;
    if (_counterMangoAddOnsR2 > 0) {
      _counterMangoAddOnsR2--;
      mangoAddOnsR2 = mangoAddOnsR2 - 1.00;
      print(mangoAddOnsR2.toString());
      notifyListeners();
    }
  }

  double _priceR2 = 8.99;


  double get priceR2 => _priceR2;


  void _updatePriceR2() {
    _priceR2 = 8.99;
    if (_isBottleR2) {
      _priceR2 += bottleAddOnsR2;
    }
    if (_isPlatesR2) {
      _priceR2 += platesAddOnsR2;
    }
    if (_isMangoR2) {
      _priceR2 += mangoAddOnsR2;
    }if (_isNaanR2) {

      _priceR2 += naanAddOnsR2;
    }

    notifyListeners();
  }
  ///R2 addons data ended
  //check boxes Ramadan3 R3   ___________

  final List<CheckboxModel> _checkApIR3 = [
    CheckboxModel(label: 'None', id: ''),
    CheckboxModel(label: 'Chicken Samosa', id: ''),
    CheckboxModel(label: 'Veg Samosa', id: ''),
    CheckboxModel(label: 'Vegetable Pakoda', id: ''),
  ];

  List<CheckboxModel> get checkApIR3 => _checkApIR3;

  void updateSelectedCheckApIR3(int index) {
    for (int i = 0; i < _checkApIR3.length; i++) {
      _checkApIR3[i].isSelected = i == index;
    }
    notifyListeners();
  }

  final List<CheckboxModel> _checkApIIR3 = [
    CheckboxModel(label: 'None', id: ''),
    CheckboxModel(label: 'Aloo Chat', id: ''),
    CheckboxModel(label: 'Samosa Chat', id: ''),
  ];

  List<CheckboxModel> get checkApIIR3 => _checkApIIR3;

  void updateSelectedCheckApIIR3(int index) {
    for (int i = 0; i < _checkApIIR3.length; i++) {
      _checkApIIR3[i].isSelected = i == index;
    }
    notifyListeners();
  }


  final List<CheckboxModel> _checkE1R3 = [
    CheckboxModel(label: 'None', id: ''),
    CheckboxModel(label: 'Veg Biryani', id: ''),
    CheckboxModel(label: 'Chicken Biryani', id: ''),
    CheckboxModel(label: 'Veg Fried Rice', id: ''),
    CheckboxModel(label: 'Chicken Fried Rice', id: ''),
    CheckboxModel(label: 'Chicken Pulav', id: ''),
  ];

  List<CheckboxModel> get checkE1R3 => _checkE1R3;

  void updateSelectedCheckE1R3(int index) {
    for (int i = 0; i < _checkE1R3.length; i++) {
      _checkE1R3[i].isSelected = i == index;
    }
    notifyListeners();
  }

  final List<CheckboxModel> _checkE2R3 = [
    CheckboxModel(label: 'None', id: ''),
    CheckboxModel(label: 'Tandoori Chicken', id: ''),
    CheckboxModel(label: 'Pepper Chicken', id: ''),
    CheckboxModel(label: 'Reshmi Chicken Sheek Kabob', id: ''),
  ];

  List<CheckboxModel> get checkE2R3 => _checkE2R3;

  void updateSelectedCheckE2R3(int index) {
    for (int i = 0; i < _checkE2R3.length; i++) {
      _checkE2R3[i].isSelected = i == index;
    }
    notifyListeners();
  }

  final List<CheckboxModel> _checkE3R3 = [
    CheckboxModel(label: 'None', id: ''),
    CheckboxModel(label: 'Chicken Curry with Bone', id: ''),
    CheckboxModel(label: 'Chicken Haleem', id: ''),
  ];

  List<CheckboxModel> get checkE3R3 => _checkE3R3;

  void updateSelectedCheckE3R3(int index) {
    for (int i = 0; i < _checkE3R2.length; i++) {
      _checkE3R3[i].isSelected = i == index;
    }
    notifyListeners();
  }

  final List<CheckboxModel> _checkBreadR3 = [
    CheckboxModel(label: 'None', id: ''),
    CheckboxModel(label: 'Butter Naan', id: ''),
  ];

  List<CheckboxModel> get checkBreadR3 => _checkBreadR3;

  void updateSelectedCheckBreadR3(int index) {
    for (int i = 0; i < _checkBreadR3.length; i++) {
      _checkBreadR3[i].isSelected = i == index;
    }
    notifyListeners();
  }


  final List<CheckboxModel> _checkC1R3 = [
    CheckboxModel(label: 'None', id: ''),
    CheckboxModel(label: 'Raitha', id: ''),
  ];

  List<CheckboxModel> get checkC1R3 => _checkC1R3;

  void updateSelectedCheckC1R3(int index) {
    for (int i = 0; i < _checkC1R3.length; i++) {
      _checkC1R3[i].isSelected = i == index;
    }
    notifyListeners();
  }

  final List<CheckboxModel> _checkC2R3 = [
    CheckboxModel(label: 'None', id: ''),
    CheckboxModel(label: 'Mint Chutney', id: ''),
  ];

  List<CheckboxModel> get checkC2R3 => _checkC2R3;

  void updateSelectedCheckC2R3(int index) {
    for (int i = 0; i < _checkC2R3.length; i++) {
      _checkC2R3[i].isSelected = i == index;
    }
    notifyListeners();
  }
  final List<CheckboxModel> _checkDessertsR3 = [
    CheckboxModel(label: 'None', id: ''),
    CheckboxModel(label: 'Gulab Jamun', id: ''),
    CheckboxModel(label: 'Rice Kheer', id: ''),
    CheckboxModel(label: 'Fruit Pudding', id: ''),
    CheckboxModel(label: 'Gajar Halwa', id: ''),
  ];
  bool _isNaan = false;
  int _naanCount = 0;
  bool get isNaan => _isNaan;
  int get naanCount => _naanCount;

  void toggleNaan() {
    _isNaan = !_isNaan;
    _naanCount += _isNaan ? 1 : -1;
    _updatePrice();
    notifyListeners();
  }
  int _counterAddOns = 1;
  double naanAddOns = 0.50;
  int get counterAddOns => _counterAddOns;
  void increment() {
    _counterAddOns++;
    _isNaan = false;
    naanAddOns = naanAddOns + 0.50;

    print(naanAddOns.toString());
    notifyListeners();
  }


  void decrement() {
    _isNaan = false;
    if (_counterAddOns > 0) {
      _counterAddOns--;
      naanAddOns = naanAddOns - 0.50;
      print(naanAddOns.toString());
      notifyListeners();
    }
  }

  bool _isPlates = false;
  int _platesCount = 0;
  bool get isPlates => _isPlates;
  int get platesCount => _platesCount;

  void togglePlates() {
    _isPlates = !_isPlates;
    _platesCount += _isPlates ? 1 : -1;
    _updatePrice();
    notifyListeners();
  }
  int _counterPlatesAddOns = 1;
  double platesAddOns = 0.25;
  int get counterPlatesAddOns => _counterPlatesAddOns;
  void incrementPlates() {
    _counterPlatesAddOns++;
    _isPlates = false;
    platesAddOns = platesAddOns + 0.25;

    print(platesAddOns.toString());
    notifyListeners();
  }


  void decrementPlates() {
    _isPlates = false;
    if (_counterPlatesAddOns > 0) {
      _counterPlatesAddOns--;
      platesAddOns = platesAddOns - 0.25;
      print(platesAddOns.toString());
      notifyListeners();
    }
  }

  bool _isBottle = false;
  int _bottleCount = 0;
  bool get isBottle => _isBottle;
  int get BottleCount => _bottleCount;

  void toggleBottle() {
    _isBottle = !_isBottle;
    _bottleCount += _isBottle ? 1 : -1;
    _updatePrice();
    notifyListeners();
  }
  int _counterBottleAddOns = 1;
  double bottleAddOns = 0.50;
  int get counterBottleAddOns => _counterBottleAddOns;
  void incrementBottle() {
    _counterBottleAddOns++;
    _isBottle = false;
    bottleAddOns = bottleAddOns + 0.50;

    print(bottleAddOns.toString());
    notifyListeners();
  }


  void decrementBottle() {
    _isBottle = false;
    if (_counterBottleAddOns > 0) {
      _counterBottleAddOns--;
      bottleAddOns = bottleAddOns - 0.50;
      print(bottleAddOns.toString());
      notifyListeners();
    }
  }

  bool _isMango = false;
  int _mangoCount = 0;
  bool get isMango => _isMango;
  int get mangoCount => _mangoCount;

  void toggleMango() {
    _isMango= !_isMango;
    _mangoCount += _isMango ? 1 : -1;
    _updatePrice();
    notifyListeners();
  }
  int _counterMangoAddOns = 1;
  double mangoAddOns = 1.00;
  int get counterMangoAddOns => _counterMangoAddOns;
  void incrementMango() {
    _counterMangoAddOns++;
    _isMango = false;
    mangoAddOns = mangoAddOns + 1.00;

    print(mangoAddOns.toString());
    notifyListeners();
  }


  void decrementMango() {
    _isMango = false;
    if (_counterMangoAddOns > 0) {
      _counterMangoAddOns--;
      mangoAddOns = mangoAddOns - 1.00;
      print(mangoAddOns.toString());
      notifyListeners();
    }
  }



  ///R3 data
  bool _isNaanR3 = false;
  int _naanCountR3 = 0;
  bool get isNaanR3 => _isNaanR3;
  int get naanCountR3 => _naanCountR3;

  void toggleNaanR3() {
    _isNaanR3 = !_isNaanR3;
    _naanCountR3 += _isNaanR3 ? 1 : -1;
    _updatePriceR3();
    notifyListeners();
  }
  int _counterAddOnsR3 = 1;
  double naanAddOnsR3 = 0.50;
  int get counterAddOnsR3 => _counterAddOnsR3;
  void incrementR3() {
    _counterAddOnsR3++;
    _isNaanR3 = false;
    naanAddOnsR3 = naanAddOnsR3 + 0.50;

    print(naanAddOnsR3.toString());
    notifyListeners();
  }


  void decrementR3() {
    _isNaanR3 = false;
    if (_counterAddOnsR3 > 0) {
      _counterAddOnsR3--;
      naanAddOnsR3 = naanAddOnsR3 - 0.50;
      print(naanAddOnsR3.toString());
      notifyListeners();
    }
  }

  bool _isPlatesR3 = false;
  int _platesCountR3 = 0;
  bool get isPlatesR3 => _isPlatesR3;
  int get platesCountR3 => _platesCountR3;

  void togglePlatesR3() {
    _isPlatesR3 = !_isPlatesR3;
    _platesCountR3 += _isPlatesR3 ? 1 : -1;
    _updatePriceR3();
    notifyListeners();
  }
  int _counterPlatesAddOnsR3 = 1;
  double platesAddOnsR3 = 0.25;
  int get counterPlatesAddOnsR3 => _counterPlatesAddOnsR3;
  void incrementPlatesR3() {
    _counterPlatesAddOnsR3++;
    _isPlatesR3 = false;
    platesAddOnsR3 = platesAddOnsR3 + 0.25;

    print(platesAddOnsR3.toString());
    notifyListeners();
  }


  void decrementPlatesR3() {
    _isPlatesR3 = false;
    if (_counterPlatesAddOnsR3 > 0) {
      _counterPlatesAddOnsR3--;
      platesAddOnsR3 = platesAddOnsR3 - 0.25;
      print(platesAddOnsR3.toString());
      notifyListeners();
    }
  }

  bool _isBottleR3 = false;
  int _bottleCountR3 = 0;
  bool get isBottleR3 => _isBottleR3;
  int get BottleCountR3 => _bottleCountR3;

  void toggleBottleR3() {
    _isBottleR3 = !_isBottleR3;
    _bottleCountR3 += _isBottleR3 ? 1 : -1;
    _updatePriceR3();
    notifyListeners();
  }
  int _counterBottleAddOnsR3 = 1;
  double bottleAddOnsR3 = 0.50;
  int get counterBottleAddOnsR3 => _counterBottleAddOnsR3;
  void incrementBottleR3() {
    _counterBottleAddOnsR3++;
    _isBottleR3 = false;
    bottleAddOnsR3 = bottleAddOnsR3 + 0.50;

    print(bottleAddOnsR3.toString());
    notifyListeners();
  }


  void decrementBottleR3() {
    _isBottleR3 = false;
    if (_counterBottleAddOnsR3 > 0) {
      _counterBottleAddOnsR3--;
      bottleAddOnsR3 = bottleAddOnsR3 - 0.50;
      print(bottleAddOnsR3.toString());
      notifyListeners();
    }
  }

  bool _isMangoR3 = false;
  int _mangoCountR3 = 0;
  bool get isMangoR3 => _isMangoR3;
  int get mangoCountR3 => _mangoCountR3;

  void toggleMangoR3() {
    _isMangoR3 = !_isMangoR3;
    _mangoCountR3 += _isMangoR3 ? 1 : -1;
    _updatePriceR3();
    notifyListeners();
  }
  int _counterMangoAddOnsR3= 1;
  double mangoAddOnsR3 = 1.00;
  int get counterMangoAddOnsR3 => _counterMangoAddOnsR3;
  void incrementMangoR3() {
    _counterMangoAddOnsR3++;
    _isMangoR3 = false;
    mangoAddOnsR3 = mangoAddOnsR3 + 1.00;

    print(mangoAddOnsR3.toString());
    notifyListeners();
  }


  void decrementMangoR3() {
    _isMangoR3 = false;
    if (_counterMangoAddOnsR3 > 0) {
      _counterMangoAddOnsR3--;
      mangoAddOnsR3 = mangoAddOnsR3 - 1.00;
      print(mangoAddOnsR3.toString());
      notifyListeners();
    }
  }

  double _priceR3 = 9.99;


  double get priceR3 => _priceR3;


  void _updatePriceR3() {
    _priceR3 = 9.99;
    if (_isBottleR3) {
      _priceR3 += bottleAddOnsR3;
    }
    if (_isPlatesR3) {
      _priceR3 += platesAddOnsR3;
    }
    if (_isMangoR3) {
      _priceR3 += mangoAddOnsR3;
    }if (_isNaanR3) {

      _priceR3 += naanAddOnsR3;
    }

    notifyListeners();
  }
  ///R3 data ended
  List<CheckboxModel> get checkDessertsR3 => _checkDessertsR3;

  void updateSelectedCheckDessertsR3(int index) {
    for (int i = 0; i < _checkDessertsR3.length; i++) {
      _checkDessertsR3[i].isSelected = i == index;
    }
    notifyListeners();
  }
  //check boxes Ramadan3 R3 ended ___________
  double _price = 11.99;


  double get price => _price;


  void _updatePrice() {
    _price = 11.99;
    if (_isBottle) {
      _price += bottleAddOns;
    }
    if (_isPlates) {
      _price += platesAddOns;
    }
    if (_isMango) {
      _price += mangoAddOns;
    }if (_isNaan) {

      _price += naanAddOns;
    }

    notifyListeners();
  }



  //check boxes Ramadan4 R4   ___________
  final List<CheckboxModel> _checkboxes = [
    CheckboxModel(label: 'None', id: ''),
    CheckboxModel(label: 'Chicken Samosa', id: ''),
    CheckboxModel(label: 'Veg Samosa', id: ''),
    CheckboxModel(label: 'Vegetable Pakoda', id: ''),
  ];

  List<CheckboxModel> get checkboxes => _checkboxes;

  void updateSelectedCheckbox(int index) {
    for (int i = 0; i < _checkboxes.length; i++) {
      _checkboxes[i].isSelected = i == index;
    }
    print(checkboxes);
    notifyListeners();
  }

  final List<CheckboxModel> _checkApIIR4 = [
    CheckboxModel(label: 'None', id: ''),
    CheckboxModel(label: 'Aloo Chat', id: ''),
    CheckboxModel(label: 'Samosa Chat', id: ''),
    CheckboxModel(label: 'Chicken -65', id: ''),
    CheckboxModel(label: 'Mango Chicken', id: ''),
    CheckboxModel(label: 'Honey Chicken', id: ''),
    CheckboxModel(label: 'Chilly Chicken ‘Boneless', id: ''),
  ];

  List<CheckboxModel> get checkApIIR4 => _checkApIIR4;

  void updateSelectedCheckApIIR4(int index) {
    for (int i = 0; i < _checkApIIR4.length; i++) {
      _checkApIIR4[i].isSelected = i == index;
    }
    notifyListeners();
  }

  final List<CheckboxModel> _checkE1R4 = [
    CheckboxModel(label: 'None', id: ''),
    CheckboxModel(label: 'Veg Biryani', id: ''),
    CheckboxModel(label: 'Chicken Biryani', id: ''),
    CheckboxModel(label: 'Veg Fried Rice', id: ''),
    CheckboxModel(label: 'Chicken Fried Rice', id: ''),
    CheckboxModel(label: 'Chicken Pulav', id: ''),
  ];

  List<CheckboxModel> get checkE1R4 => _checkE1R4;

  void updateSelectedCheckE1R4(int index) {
    for (int i = 0; i < _checkE1R4.length; i++) {
      _checkE1R4[i].isSelected = i == index;
    }
    notifyListeners();
  }

  final List<CheckboxModel> _checkE2R4 = [
    CheckboxModel(label: 'None', id: ''),
    CheckboxModel(label: 'Tandoori Chicken', id: ''),
    CheckboxModel(label: 'Pepper Chicken', id: ''),
    CheckboxModel(label: 'Reshmi Chicken Sheek Kabob', id: ''),
    CheckboxModel(label: 'Beef Sheek Kabob', id: ''),
  ];

  List<CheckboxModel> get checkE2R4 => _checkE2R4;

  void updateSelectedCheckE2R4(int index) {
    for (int i = 0; i < _checkE2R4.length; i++) {
      _checkE2R4[i].isSelected = i == index;
    }
    notifyListeners();
  }

  final List<CheckboxModel> _checkE3R4 = [
    CheckboxModel(label: 'None', id: ''),
    CheckboxModel(label: 'Chicken Curry with Bone', id: ''),
    CheckboxModel(label: 'Beef Curry', id: ''),
    CheckboxModel(label: 'Goat Curry', id: ''),
    CheckboxModel(label: 'Chicken Haleem', id: ''),
    CheckboxModel(label: 'Beef Haleem', id: ''),
    CheckboxModel(label: 'Lamb Haleem', id: ''),
    CheckboxModel(label: 'Chicken Haleem', id: ''),
    CheckboxModel(label: 'Beef Nihari', id: ''),
  ];

  List<CheckboxModel> get checkE3R4 => _checkE3R4;

  void updateSelectedCheckE3R4(int index) {
    for (int i = 0; i < _checkE3R4.length; i++) {
      _checkE3R4[i].isSelected = i == index;
    }
    notifyListeners();
  }

  final List<CheckboxModel> _checkBreadR4 = [
    CheckboxModel(label: 'None', id: ''),
    CheckboxModel(label: 'Butter Naan', id: ''),
    CheckboxModel(label: 'Garlic Naan', id: ''),
  ];

  List<CheckboxModel> get checkBreadR4 => _checkBreadR4;

  void updateSelectedCheckBreadR4(int index) {
    for (int i = 0; i < _checkBreadR4.length; i++) {
      _checkBreadR4[i].isSelected = i == index;
    }
    notifyListeners();
  }

  final List<CheckboxModel> _checkC1R4 = [
    CheckboxModel(label: 'None', id: ''),
    CheckboxModel(label: 'Raitha', id: ''),
  ];

  List<CheckboxModel> get checkC1R4 => _checkC1R4;

  void updateSelectedCheckC1R4(int index) {
    for (int i = 0; i < _checkC1R4.length; i++) {
      _checkC1R4[i].isSelected = i == index;
    }
    notifyListeners();
  }

  final List<CheckboxModel> _checkC2R4 = [
    CheckboxModel(label: 'None', id: ''),
    CheckboxModel(label: 'Mint Chutney', id: ''),
  ];

  List<CheckboxModel> get checkC2R4 => _checkC2R4;

  void updateSelectedCheckC2R4(int index) {
    for (int i = 0; i < _checkC2R4.length; i++) {
      _checkC2R4[i].isSelected = i == index;
    }
    notifyListeners();
  }

  final List<CheckboxModel> _checkDessertsR4 = [
    CheckboxModel(label: 'None', id: ''),
    CheckboxModel(label: 'Gulab Jamun', id: ''),
    CheckboxModel(label: 'Rice Kheer', id: ''),
    CheckboxModel(label: 'Fruit Pudding', id: ''),
    CheckboxModel(label: 'Gajar Halwa', id: ''),
  ];

  List<CheckboxModel> get checkDessertsR4 => _checkDessertsR4;

  void updateSelectedCheckDessertsR4(int index) {
    for (int i = 0; i < _checkDessertsR4.length; i++) {
      _checkDessertsR4[i].isSelected = i == index;
    }
    notifyListeners();
  }
  //check boxes Ramadan4 R4 ended ___________

  List<ProductListModel> productsCategoriesList = [];

  void updateDataProductCategoriesListModel(
      List<ProductListModel> productsCategoriesList) {
    productState = 0;
    this.productsCategoriesList = productsCategoriesList;
    if (productsCategoriesList != []) {
      productState = 1;
      notifyListeners();
    } else {
      productState = 0;
      notifyListeners();
    }
  }

  List<CartItemModel> cartList = [];

  void updateCartList(List<CartItemModel> cartList) {
    this.cartList = cartList;
    if (cartList != []) {
      state = 1;
      notifyListeners();
    } else {
      state = 0;
      notifyListeners();
    }
  }

  int activeIndex = 0;

  void updateSlider(int index) {
    activeIndex = index;
  }

//--------------------------------------------------------------------

  DBHelper dbHelper = DBHelper();
  int _counter = 0;
  int _quantity = 1;

  int get counter => _counter;

  int get quantity => _quantity;

  double _totalPrice = 0.0;

  double get totalPrice => _totalPrice;

  List<Cart> cart = [];

  Future<List<Cart>> getData() async {
    cart = await dbHelper.getCartList();
    notifyListeners();
    return cart;
  }

  void _setPrefsItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('cart_items', _counter);
    prefs.setInt('item_quantity', _quantity);
    prefs.setDouble('total_price', _totalPrice);
    notifyListeners();
  }

  void _getPrefsItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _counter = prefs.getInt('cart_items') ?? 0;
    _quantity = prefs.getInt('item_quantity') ?? 1;
    _totalPrice = prefs.getDouble('total_price') ?? 0;
  }

  void addCounter() {
    _counter++;
    _setPrefsItems();
    notifyListeners();
  }

  void removeCounter() {
    _counter--;
    _setPrefsItems();
    notifyListeners();
  }

  int getCounter() {
    _getPrefsItems();
    return _counter;
  }

  void addQuantity(int id) {
    final index = cart.indexWhere((element) => element.id == id);
    cart[index].quantity!.value = cart[index].quantity!.value + 1;
    _setPrefsItems();
    notifyListeners();
  }

  void deleteQuantity(int id) {
    final index = cart.indexWhere((element) => element.id == id);
    final currentQuantity = cart[index].quantity!.value;
    if (currentQuantity <= 1) {
      currentQuantity == 1;
    } else {
      cart[index].quantity!.value = currentQuantity - 1;
    }
    _setPrefsItems();
    notifyListeners();
  }

  void removeItem(int id) {
    final index = cart.indexWhere((element) => element.id == id);
    cart.removeAt(index);
    _setPrefsItems();
    notifyListeners();
  }

  int getQuantity(int quantity) {
    _getPrefsItems();
    return _quantity;
  }

  void addTotalPrice(double productPrice) {
    _totalPrice = _totalPrice + productPrice;
    _setPrefsItems();
    notifyListeners();
  }

  void removeTotalPrice(double productPrice) {
    _totalPrice = _totalPrice - productPrice;
    _setPrefsItems();
    notifyListeners();
  }

  double getTotalPrice() {
    _getPrefsItems();
    return _totalPrice;
  }

  static Cart of(BuildContext context, {bool listen = false}) {
    return Provider.of<Cart>(context, listen: listen);
  }

  //For Current Location
  String location = 'Null, Press Button';
  String searchLocation = 'Null';
  String Address = 'search';
  late Position position;
  final Completer<GoogleMapController> mapController = Completer();

  Future<Position> getGeoLocationPosition( context) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();







      if (permission == LocationPermission.denied) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const CartScreen(),
          ),
        );
        return Future.error('Location permissions are denied');
      }
    }


    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<void> getAddressFromLatLong(Position position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    final List<Marker> marker = <Marker>[
      Marker(
        markerId: const MarkerId("1"),
        position: LatLng(position.latitude, position.longitude),
        infoWindow: const InfoWindow(
          title: "Current Position",
        ),
      ),
    ];
    Placemark place = placemarks[0];
    Address =
        '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode} ${place.country}';
    // setState(()  {
    // });
    final Uint8List markerIcon =
        await getBytesFromAssets('assets/images/logo/person.png', 100);
    getUserCurrentLocation().then((position) async {
      marker.add(
        Marker(
          markerId: const MarkerId("2"),
          icon: BitmapDescriptor.fromBytes(markerIcon),
          position: LatLng(position.latitude, position.longitude),
          infoWindow: const InfoWindow(
            title: "User Current Location",
          ),
        ),
      );
      CameraPosition cameraPosition = CameraPosition(
        zoom: 14,
        target: LatLng(position.latitude, position.longitude),
      );
      final GoogleMapController controller = await mapController.future;
      controller.animateCamera(
        CameraUpdate.newCameraPosition(cameraPosition),
      );
    });
  }

  final Completer<GoogleMapController> _controller = Completer();

  final List<Marker> marker = <Marker>[
    const Marker(
      markerId: MarkerId("1"),
      // icon: Icon(Icons.location_history),
      position: LatLng(31.48462325, 74.29710848648166),
      infoWindow: InfoWindow(
        title: "Current Position",
      ),
    ),
  ];

  Future<Uint8List> getBytesFromAssets(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetHeight: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) {
    });
    return await Geolocator.getCurrentPosition();
  }

  loadData() async {
    // for(int i=0;i<image.length;i++){
    //
    // }

    final Uint8List markerIcon =
        await getBytesFromAssets('assets/images/logo/person.png', 100);
    getUserCurrentLocation().then((value) async {
      marker.add(
        Marker(
          markerId: const MarkerId("2"),
          icon: BitmapDescriptor.fromBytes(markerIcon),
          position: LatLng(value.latitude, value.longitude),
          infoWindow: const InfoWindow(
            title: "User Current Location",
          ),
        ),
      );
      CameraPosition cameraPosition = CameraPosition(
        zoom: 14,
        target: LatLng(value.latitude, value.longitude),
      );
      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(
        CameraUpdate.newCameraPosition(cameraPosition),
      );
    });
  }

  int _delayState = 0;

  int get delayState => _delayState;

  set delayState(int value) {
    _delayState = value;
    notifyListeners();
  }

  delay() async {
    Future.delayed(const Duration(seconds: 5), () {
      return true;
    });
  }


  Future<void> saveStringToPrefs(String key, String value) async {
    // Get the shared preferences instance
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Save the string value with the given key
    await prefs.setString(key, value);
  }

  Future<String> getStringFromPrefs(String key) async {
    // Get the shared preferences instance
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Get the string value with the given key. If the value is null, return an empty string.
    return prefs.getString(key) ?? '';
  }
}
