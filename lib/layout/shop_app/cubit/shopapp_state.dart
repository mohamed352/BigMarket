part of 'shopapp_cubit.dart';

abstract class ShopappState {}

class ShopappInitial extends ShopappState {}

class ShopappCangeBootmNav extends ShopappState {}

class ShopappLoadScreen extends ShopappState {}

class ShopappScsuflly extends ShopappState {}

class ShopappErorrDatat extends ShopappState {}

class ShopappLoadScreencat extends ShopappState {}

class ShopappScsufllycat extends ShopappState {}

class ShopappErorrDatatcat extends ShopappState {}

class ShopappLoadScreenfav extends ShopappState {}

class ShopappScsufllyfav extends ShopappState {
  final ChangeFavoritesModel model;

  ShopappScsufllyfav(this.model);
}

class ShopappErorrDatatfav extends ShopappState {}

class Shopappchangebootm extends ShopappState {}

class ShopappLoadScreenfa extends ShopappState {}

class ShopappScsufllyfa extends ShopappState {}

class ShopappErorrDatatfa extends ShopappState {}

class ShopappLoadScreenUser extends ShopappState {}

class ShopappScsufllyUser extends ShopappState {}

class ShopappErorrDatatUser extends ShopappState {}



class RegistercubitLoadStatemodel extends ShopappState {}

class RegistercubitSucsfullyStatemodel extends ShopappState {
   final Shop_App_Login loginmodel;

  RegistercubitSucsfullyStatemodel(this.loginmodel);
}

class RegistercubitErorStatemodel extends ShopappState {
  final String? error;
  RegistercubitErorStatemodel({this.error});
}
 