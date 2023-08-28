class SearchModel {
  dynamic status;
  dynamic message;
  Data? data;

  SearchModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) data = Data.fromJson(json['data']);
  }
}

class Data {
  List<Product> data = [];

  Data.fromJson(Map<String, dynamic> json) {
    json['data'].forEach((element) {
      data.add(Product.fromJson(element));
    });
  }
}

class Product {
  dynamic id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  dynamic image;
  dynamic name;
  dynamic description;

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }
}
