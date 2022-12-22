part of 'registercubit_cubit.dart';

abstract class ShopRegisterState {}

class RegistercubitInitialState extends ShopRegisterState {}

class RegistercubitLoadState extends ShopRegisterState {}

class RegistercubitSucsfullyState extends ShopRegisterState {
   
   final Shop_App_Login registermodel;

  RegistercubitSucsfullyState(this.registermodel);
}

class RegistercubitErorState extends ShopRegisterState {
  final String? error;
  RegistercubitErorState({this.error});
}

class RegistercubitChangeIconState extends ShopRegisterState {}
