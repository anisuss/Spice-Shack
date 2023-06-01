class ProductCategoriesModel {
  int? id;
  String? name;
  String? description;
  String? price;
  List? image;

  ProductCategoriesModel({
    this.id,
    this.name,
    this.description,
    this.price,
    this.image,
    //required this.image,
  });

  ProductCategoriesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    image = json['images'];
  }

  Map<String , Object? > toMap() {
    return {
      // 'id' : id,
      'id' : id,
      'name' : name,
      'description' : description,
      'price' : price,
      'images' : image,
    };
  }
}
