part of 'logincubit_cubit.dart';

abstract class ShopLoginState {}

class LogincubitInitialState extends ShopLoginState {}

class LogincubitLoadState extends ShopLoginState {}

class LogincubitSucsfullyState extends ShopLoginState {
   final Shop_App_Login loginmodel;

  LogincubitSucsfullyState(this.loginmodel);
}

class LogincubitErorState extends ShopLoginState {
  final String? error;
  LogincubitErorState({this.error});
}

class LogincubitChangeIconState extends ShopLoginState {}

