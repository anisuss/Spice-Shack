class FamilyFeastModel {
  final String name;
  final int id;

  FamilyFeastModel({required this.name, required this.id});

  factory FamilyFeastModel.fromJson(Map<String, dynamic> json) {
    return FamilyFeastModel(
      name: json['name'],
      id: json['id'],
    );
  }
}