class CategoriesModel {
  dynamic status;
  CategoriesDataModel? data;

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) data = CategoriesDataModel.fromJson(json['data']);
  }
}

class CategoriesDataModel {
  List<DataModel> data = [];

  CategoriesDataModel.fromJson(Map<String, dynamic> json) {
    json['data'].forEach((element) {
      data.add(DataModel.fromJson(element));
    });
  }
}

class DataModel {
  dynamic id;
  dynamic name;
  dynamic image;

  DataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}
