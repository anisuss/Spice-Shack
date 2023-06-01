class ProfileModel {
  final int ID;
  final Map<String,dynamic>? data;

  const ProfileModel({
    required this.ID,
    required this.data,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      ID: json['ID'],
      data: json['data'] ?? [],
    );
  }

  Map<String , Object? > toMap() {
    return {
      'ID' : ID,
      'data' : data,
    };
  }
}
