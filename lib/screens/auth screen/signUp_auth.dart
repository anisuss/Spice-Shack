import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class logScreen extends StatefulWidget {
  const logScreen({Key? key}) : super(key: key);

  @override
  _logScreenState createState() => _logScreenState();
}

class _logScreenState extends State<logScreen> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String email = "";
  String password = "";

  void getCategories() async {
    try{
      var request = http.Request('GET', Uri.parse("https://spiceshackus.com/wp-json/custom-plugin/login?username=$email&password=$password"));
      http.StreamedResponse productCategoriesResponse = await request.send();
      if(productCategoriesResponse.statusCode == 200){
        if (kDebugMode) {
          print("Response :- ${productCategoriesResponse.statusCode.toString()}");
        }
        var rawData = await productCategoriesResponse.stream.bytesToString();
        if (kDebugMode) {
          print("Data :- $rawData");
        }
      }else {
      }
    }catch(e){
    }
  }

  void login() async {

    try{

      Response response = await get(
          Uri.parse('https://spiceshackus.com/wp-json/custom-plugin/login?username=$email&password=$password'),
      );

      if(response.statusCode == 200){

        var data = jsonDecode(response.body.toString());

      }else {
      }
    }catch(e){
      e;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up Api'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                  hintText: 'Email'
              ),
            ),
            const SizedBox(height: 20,),
            TextFormField(
              controller: passwordController,
              decoration: const InputDecoration(
                  hintText: 'Password'
              ),
            ),
            const SizedBox(height: 40,),
            GestureDetector(
              onTap: (){
                email = emailController.text.toString();
                password = passwordController.text.toString();
                getCategories();
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: const Center(child: Text('Login'),),
              ),
            )
          ],
        ),
      ),
    );
  }
}
