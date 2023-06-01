import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../model/api data model/api_data_model.dart';

class CheckData extends StatefulWidget {
  const CheckData({Key? key}) : super(key: key);

  @override
  State<CheckData> createState() => _CheckDataState();
}

class _CheckDataState extends State<CheckData> {
  List<ApiDataModel> postList = [];

  Future<List<ApiDataModel>> getPostApi() async {
    final response = await http.get(
      Uri.parse("https://apple.ucstestserver.xyz/wp-json/wc/v3/products?consumer_key=ck_87860d0f591236ec0de227efa65bf09b4948f044&consumer_secret=cs_bb998b659fe1da56eaba855b06aa8707f7b0c3ed"),
    );
    var data = jsonDecode(
      response.body.toString(),
    );
    if (response.statusCode == 200) {
      postList.clear();
      for (Map<String, dynamic> i in data) {
        postList.add(ApiDataModel.fromJson(i));
      }
      return postList;
    } else {
      return postList;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                  future: getPostApi(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Text("Loading");
                    } else {
                      return ListView.builder(
                          itemCount: postList.length,
                          itemBuilder: (context, index){
                            return Text(postList[index].name.toString());
                          });
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
