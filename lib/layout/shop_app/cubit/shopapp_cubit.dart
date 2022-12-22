import 'package:app/models/users/shopapp/categoriesmodels.dart';
import 'package:app/models/users/shopapp/favourets.dart';
import 'package:app/models/users/shopapp/favouretsmodel.dart';
import 'package:app/models/users/shopapp/homemodels.dart';
import 'package:app/models/users/shopapp/loginmodel.dart';
import 'package:app/shared/componets/constnts.dart';
import 'package:app/shared/network/endpoints.dart';
import 'package:app/shared/network/remot/diohelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../modules/catgeory/catgeory.dart';
import '../../../modules/favourets/favourets.dart.dart';
import '../../../modules/products/productsscreeen.dart';
import '../../../modules/settings/settingsscreeen.dart';

part 'shopapp_state.dart';

class ShopappCubit extends Cubit<ShopappState> {
  ShopappCubit() : super(ShopappInitial());
  static ShopappCubit get(context) => BlocProvider.of(context);
   int currentindex = 0;
  List<Widget> screen = [
    const Products_Screeen(),
    const Categores_Screen(),
    const Favourets_Screen(),
    const Settings_Screen(),
  ];

  void changebootm(int index) {
    emit(ShopappInitial());
    currentindex = index;
    emit(ShopappCangeBootmNav());
  }

  Home_Model? homemodel;
  Map<int, bool> favourets = {};

  void getdata() {
    emit(ShopappLoadScreen());
    Dio_Helper.get(
      url: HOME,
      token: token,
    ).then((value) {
      homemodel = Home_Model.fromjason(value.data);
      for (var element in homemodel!.data.products) {
        favourets.addAll({element.id: element.in_favorites});
      }

      emit(ShopappScsuflly());
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(ShopappErorrDatat());
    });
  }

  CategoriesModels? catmodels;
  void getdatacatgeory() {
    emit(ShopappLoadScreen());
    Dio_Helper.get(
      url: Categories,
      token: token,
    ).then((value) {
      catmodels = CategoriesModels.fromjason(value.data);

      emit(ShopappScsufllycat());
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(ShopappErorrDatatcat());
    });
  }

  ChangeFavoritesModel? favouretsmodels;
  void changefavbootom(int productid) {
    favourets[productid] = !favourets[productid]!;
    emit(ShopappLoadScreenfav());
    Dio_Helper.post(
            url: FAVOURETS, data: {'product_id': productid}, token: token)
        .then((value) {
      favouretsmodels = ChangeFavoritesModel.fromJson(value.data);
      if (!favouretsmodels!.status!) {
        favourets[productid] = !favourets[productid]!;
      } else {
        getdatafavourets();
      }

      emit(ShopappScsufllyfav(favouretsmodels!));
    }).catchError((error) {
      favourets[productid] = !favourets[productid]!;
      emit(ShopappErorrDatatfav());
    });
  }

  FavoritesModel? favouretsmodel;
  void getdatafavourets() {
    emit(ShopappLoadScreenfa());
    Dio_Helper.get(
      url: FAVOURETS,
      token: token,
    ).then((value) {
      favouretsmodel = FavoritesModel.fromJson(value.data);

      emit(ShopappScsufllyfa());
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(ShopappErorrDatatfa());
    });
  }

  
  void getdatasetting() {
    emit(ShopappLoadScreenUser());
    Dio_Helper.get(
      url: USER,
      token: token,
    ).then((value) {
    registermodel =  Shop_App_Login.fromjason(value.data);
      if (kDebugMode) {
        print(registermodel!.data!.name);
      }
      emit(ShopappScsufllyUser());
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(ShopappErorrDatatUser());
    });
  }
  Shop_App_Login? registermodel;
  void putdataupdatat({
   required String name,
   required String email,
   required String phone,
  }) {
    emit(RegistercubitLoadStatemodel());
    Dio_Helper.put(
      url: UPDATAE,
      token: token,
      data: {
        'name':name,
        'email':email,
        'phone':phone,
      }

    ).then((value) {
    registermodel =  Shop_App_Login.fromjason(value.data);
      if (kDebugMode) {
        print(registermodel!.data?.name);
      }
      emit(RegistercubitSucsfullyStatemodel(registermodel!));
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(RegistercubitErorStatemodel());
    });
  }
}
