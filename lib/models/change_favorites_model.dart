class ChangeFavoritesModel {
  dynamic status;
  dynamic message;

  ChangeFavoritesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}
