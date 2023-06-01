class Demo {
  late int id;
  late String name;
  late String price;

  Demo({
    required this.id,
    required this.name,
    required this.price,
  });

  Demo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
  }
}
