import 'package:app/models/users/shopapp/searchmodel.dart';
import 'package:app/shared/componets/constnts.dart';
import 'package:app/shared/network/endpoints.dart';
import 'package:app/shared/network/remot/diohelper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());
  static SearchCubit get(context) => BlocProvider.of(context);
  SearchModel? searchmodel;
  void searchdata(String text) {
    emit(SearchInitialLoadData());
    Dio_Helper.post(
      url: Search,
      token: token,
       data: {'text': text})
       .then((value) {

      searchmodel = SearchModel.fromJson(value.data);

      emit(SearchInitialScsfulltData());
    }).catchError((error) {
      emit(SearchInitialErorrData());
      if (kDebugMode) {
        
          print(error.toString());
        
      }
    });
  }
}
