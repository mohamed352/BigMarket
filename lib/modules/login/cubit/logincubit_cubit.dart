import 'package:app/models/users/shopapp/loginmodel.dart';
import 'package:app/shared/network/endpoints.dart';
import 'package:app/shared/network/remot/diohelper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'logincubit_state.dart';

class ShopLoginCubit extends Cubit<ShopLoginState> {
  ShopLoginCubit() : super(LogincubitInitialState());
  static ShopLoginCubit get(context) => BlocProvider.of(context);
  IconData iconlog = Icons.visibility;
  bool ispaswored = true;
  Shop_App_Login? loginmodel;
  void changeiconpassword() {
    emit(LogincubitInitialState());
    ispaswored = !ispaswored;
    iconlog = ispaswored ? Icons.visibility : Icons.visibility_off_outlined;

    emit(LogincubitChangeIconState());
  }

  void userlogin({
    final String? email,
    final String? password,
  }) {
    emit(LogincubitLoadState());
    Dio_Helper.post(
      url: LOGIN,
      data: {
        'email': email,
       'password': password,
       },
    ).then((value) {
      loginmodel = Shop_App_Login.fromjason(value.data);
     // if (kDebugMode) {
       // print(value.data);
        //print(loginmodel?.status);
        //print(loginmodel?.data?.token);
      //}

      emit(LogincubitSucsfullyState(loginmodel!));
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(LogincubitErorState(error: error.toString()));
    });
  }
}
