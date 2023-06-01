class ProductListModel {
  late int id;
  late String name;
  late String short_description;
  String? price;
  List? images;

  ProductListModel({
    required this.id,
    required this.name,
    required this.short_description,
    required this.price,
    this.images,
  });

  ProductListModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    short_description = json['short_description'];
    price = json['price'];
    images = json['images'] ?? [];
  }

  Map<String , Object? > toMap() {
    return {
      'id' : id,
      'name' : name,
      'short_description' : short_description,
      'price' : price,
      'images' : images,
    };
  }
}



