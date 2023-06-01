import 'dart:convert';

import 'package:spice_shack/screens/checkOut%20screen/model%20places%20api/prediction_model.dart';

class PlacesAutoCompleteResponse{
  final String? status;
  final List<AutoCompletePrediction>? predictions;
  PlacesAutoCompleteResponse({this.status,this.predictions});
  factory PlacesAutoCompleteResponse.fromJson(Map<String,dynamic>json){
    return PlacesAutoCompleteResponse(
      status: json['status'] as String?,
      predictions: json['predictions'] != null? json['predictions'].map<AutoCompletePrediction>((json) => AutoCompletePrediction.fromJson(json)).toList():null,
    );
  }

  static PlacesAutoCompleteResponse parseAutoCompleteResult(String responseBody){
    final parsed = json.decode(responseBody).cast<String, dynamic>();
    return PlacesAutoCompleteResponse.fromJson(parsed);
}
}
