import 'package:app/models/users/shopapp/loginmodel.dart';
import 'package:app/shared/network/endpoints.dart';
import 'package:app/shared/network/remot/diohelper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'registercubit_state.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterState> {
  ShopRegisterCubit() : super(RegistercubitInitialState());
  static ShopRegisterCubit get(context) => BlocProvider.of(context);
  IconData iconlog = Icons.visibility;
  bool ispaswored = true;
  // ignore: non_constant_identifier_names
  Shop_App_Login? registermodel;
  void changeiconpassword() {
    emit(RegistercubitInitialState());
    ispaswored = !ispaswored;
    iconlog = ispaswored ? Icons.visibility : Icons.visibility_off_outlined;

    emit(RegistercubitChangeIconState());
  }

  void userRegister({
    final String? email,
    final String? password,
    final String? name,
    final String? phone,
  }) {
    emit(RegistercubitLoadState());
    Dio_Helper.post(
      url: REGISTER,
      data: {
        'name': name,
        'email': email,
       'password': password,
       'phone':phone,
       },
    ).then((value) {
      registermodel = Shop_App_Login.fromjason(value.data);
     if (kDebugMode) {
       print(value.data);
        print(registermodel?.status);
        print(registermodel?.data?.token);
      }

      emit(RegistercubitSucsfullyState(registermodel!));
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(RegistercubitErorState(error: error.toString()));
    });
  }
}
