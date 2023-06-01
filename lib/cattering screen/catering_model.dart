class CateringModel {
  int? id;
  String? name;
  String? price_html;
  String? short_description;
  String? price;
  List? images;
  List? variations;
  List? meta_data;

  CateringModel({
    this.id,
    this.name,
    this.price_html,
    this.short_description,
    this.price,
    this.images,
    this.variations,
    this.meta_data,
  });

  CateringModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price_html = json['price_html'];
    short_description = json['short_description'];
    price = json['price'];
    images = json['images'];
    variations = json['variations'];
    meta_data = json['meta_data'];
  }

  Map<String , Object? > toMap() {
    return {
      'id' : id,
      'name' : name,
      'price_html' : price_html,
      'short_description' : short_description,
      'price' : price,
      'images' : images,
      'variations' : variations,
      'meta_data' : meta_data,
    };
  }

}
