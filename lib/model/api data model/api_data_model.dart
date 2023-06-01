class ApiDataModel{
  late int id;
  late String name;
  ApiDataModel(this.id,this.name);
  ApiDataModel.fromJson(Map<String, dynamic>json){
    id = json["id"];
    name = json["name"];
  }
}