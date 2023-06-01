class CartItemModel {
  late int id;
  late String name;
  late String description;
  Map<String,dynamic>? image;

  CartItemModel({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
  });

  CartItemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    image = json['image'] ?? [];
  }

  Map<String , Object? > toMap() {
    return {
      'id' : id,
      'name' : name,
      'description' : description,
      'image' : image,
    };
  }
}



