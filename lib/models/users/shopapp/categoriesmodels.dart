class CategoriesModels {
  late bool status;
  late Datat1Cat data;
  CategoriesModels.fromjason(Map<String, dynamic> json) {
    status = json['status'];
    data = Datat1Cat.fromjason(json['data']);
  }
}

class Datat1Cat {
  // ignore: non_constant_identifier_names
  late int current_page;
  List<Data2Cat> data = [];
  Datat1Cat.fromjason(Map<String, dynamic> json) {
    current_page = json['current_page'];
    json['data'].forEach((elemnt) {
      data.add(Data2Cat.fromjason(elemnt));
    });
  }
}

class Data2Cat {
  late int id;
  late String name;
  late String image;
  Data2Cat.fromjason(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}
