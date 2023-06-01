class LoginModel {
  late int id;
  List? data;

  LoginModel({
    required this.id,
    required this.data,
  });

  LoginModel.fromJson(Map<String, dynamic> json) {
    id = json['ID'];
    data = json['data'];
  }

  Map<String , Object? > toMap() {
    return {
      'ID' : id,
      'data' : data,
    };
  }
}



