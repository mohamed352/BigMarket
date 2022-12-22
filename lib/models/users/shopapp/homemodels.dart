// ignore: camel_case_types
class Home_Model {
 late bool status;
  late Data_HomeModel data;
  Home_Model.fromjason(Map<String, dynamic> json) {
    status = json['status'];
    data = Data_HomeModel.fromjason(json['data']);
  }
}

// ignore: camel_case_types
class Data_HomeModel {
  List<BannerModel> banners = [];
  List<BroductsModel> products = [];
  Data_HomeModel.fromjason(Map<String, dynamic> json) {
    
    json['banners'].forEach((elment) {
      banners.add(BannerModel.fromjason(elment));
    });
    json['products'].forEach((elment) {
      products.add(BroductsModel.fromjason(elment));
    });
  }
}

// ignore: camel_case_types
class BannerModel {
   late int id;
  late String image;

  BannerModel.fromjason(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }
}

class BroductsModel {
  late int id;
  late String image;
  dynamic price;
  late String name;
  // ignore: non_constant_identifier_names
  dynamic old_price;
  dynamic discount;
  // ignore: non_constant_identifier_names
  late bool in_favorites;
  // ignore: non_constant_identifier_names
  late bool in_cart;

  BroductsModel.fromjason(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    price = json['price'];
    name = json['name'];
    old_price = json['old_price'];
    discount = json['discount'];
    in_favorites = json['in_favorites'];
    in_cart = json['in_cart'];
  }
}
