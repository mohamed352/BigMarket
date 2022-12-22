// ignore: camel_case_types
class Shop_App_Login {
  bool? status;
  String? message;
  User_Data? data;
  Shop_App_Login.fromjason(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = (json['data'] != null ? User_Data.fromjason(json['data']) : null)!;
  }
}

// ignore: camel_case_types
class User_Data {
  int? id;
  String? message;
  String? name;
  String? email;
  String? phone;
  String? image;
  int? points;
  int? credit;
  String? token;
  User_Data.fromjason(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    points = json['points'];
    credit = json['credit'];
    token = json['token'];
  }
}
