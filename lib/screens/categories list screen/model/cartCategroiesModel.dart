
class ProductModel{
  late final int? id;
  final String? productId;
  final String? name;
  final double? initialPrice;
  final double? productPrice;
  final int? quantity;
  final String? varData;
  final String? image;
  //final String? varData;

  ProductModel({
    required this.id ,
    required this.productId,
    required this.name,
    required this.initialPrice,
    required this.productPrice,
    required this.quantity,
    required this.varData,
    required this.image,

  });

  ProductModel.fromMap(Map<dynamic , dynamic>  res)
      : id = res['id'],
        productId = res["productId"],
        name = res["productName"],
        initialPrice = res["initialPrice"],
        productPrice = res["productPrice"],
        quantity = res["quantity"],
        //unitTag = res["unitTag"],
        image = res["image"],
        varData = res["varData"];

  Map<String, Object?> toMap(){
    return {
      'id' : id ,
      'productId' : productId,
      'productName' :name,
      'initialPrice' : initialPrice,
      'productPrice' : productPrice,
      'quantity' : quantity,
      'image' : image,
      'varData' : varData,
    };
  }
}