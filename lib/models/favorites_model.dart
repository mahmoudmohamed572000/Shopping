class FavoritesModel {
  dynamic status;
  dynamic message;
  late Data data;

  FavoritesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = Data.fromJson(json['data']);
  }
}

class Data {
  List<FavoritesData> data = [];

  Data.fromJson(Map<String, dynamic> json) {
    json['data'].forEach((element) {
      data.add(FavoritesData.fromJson(element));
    });
  }
}

class FavoritesData {
  dynamic id;
  late Product product;

  FavoritesData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product = Product.fromJson(json['product']);
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
