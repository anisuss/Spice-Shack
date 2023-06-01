class CustomerModel {
  String email;
  String firstName;
  String lastName;
  String password;
  String total;

  CustomerModel({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.password,
    required this.total,
  });

  Map<String, dynamic> toJson(){
    Map<String, dynamic> map = {};
    map.addAll({
      'email' : email,
      'first_name' : firstName,
      "last_name" : lastName,
      "user_name" : email,
      "total" : total,
    });
    return map;
  }
}
