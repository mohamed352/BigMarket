
import 'package:app/shared/network/local/shareprefrences.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sqflite/sqflite.dart';
part 'cubit_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitialstate());
  static AppCubit get(context) => BlocProvider.of(context);
  Database? database;
  List<Map> newtasks = [];
  List<Map> donetasks = [];
  List<Map> archivetasks = [];
  bool isbottomshow = false;
  IconData iconbotom = Icons.edit;
  List<MaterialColor> colors = [
    Colors.deepOrange,
    Colors.green,
    Colors.indigo,
  ];

  int cureent = 0;
  // List<Widget> screen = [
  //   const NewTasks(),
  //   const DoneTasks(),
  //   const ArchiveTasks(),
  // ];

  void changeinedx(int index) {
    emit(AppInitialstate());
    cureent = index;
    emit(AppChangeBootmNavgtorState());
  }

  void creatdatabase() {
    //emit(AppInitialstate());
    openDatabase('TodoApp.db', version: 1,
        onCreate: (Database db, int version) {
      debugPrint('database ceratd');

      db
          .execute(
              'CREATE TABLE Tasks (id INTEGER PRIMARY KEY, titles TEXT, data TEXT, time TEXT,state TEXT)')
          .then((value) {
        debugPrint('tables ceraetd');
      }).catchError((error) {
        if (kDebugMode) {
          print('error when table cereat is${error.toString()}');
        }
      });
    }, onOpen: (database) {
      getdatafromdatabase(database);
      debugPrint('database opend');
    }).then((value) {
      database = value;
      emit(AppCereatDataBase());
    });
  }

  Future insertdatabase({
    required String title,
    required String date,
    required String time,
  }) async {
    return await database?.transaction((txn) async {
      int id1 = await txn.rawInsert(
          'INSERT INTO Tasks (titles, data, time , state) VALUES("$title", "$date", "$time" , "new")');
      if (kDebugMode) {
        print('inserted1: $id1');
        emit(AppInserTODataBase());
        getdatafromdatabase(database);
      }
    });
  }

  void getdatafromdatabase(database) {
    newtasks = [];
    donetasks = [];
    archivetasks = [];
    emit(AppGetFromDataBaseLodng());

    database.rawQuery('SELECT * FROM  Tasks').then((value) {
      value.forEach((element) {
        if (element['state'] == 'new') {
          newtasks.add(element);
        } else if (element['state'] == 'done') {
          donetasks.add(element);
        } else {
          archivetasks.add(element);
        }
      });
      emit(AppGetFromDataBase());
    });
  }

  void changebottomsheer({required bool isshow, required IconData icon}) {
    emit(AppInitialstate());
    isbottomshow = isshow;
    iconbotom = icon;
    emit(AppChangeBootmSheetState());
  }

  void updateData({
    required String state,
    required int id,
  }) async {
    database?.rawUpdate(
      'UPDATE Tasks SET state = ? WHERE id = ?',
      [state, id],
    ).then((value) {
      getdatafromdatabase(database);
      emit(AppUdateTODataBase());
    });
  }

  void deletData({
    required int id,
  }) async {
    database?.rawDelete('DELETE FROM Tasks WHERE id = ?', [id]).then((value) {
      getdatafromdatabase(database);
      emit(AppDeletTODataBase());
    });
  }

  bool? isDark = true;
  void changmod({bool? fromShared}) {
    emit(AppInitialstate());
    if (fromShared != null) {
      isDark = fromShared;
      emit(AppChangeMode());
    } else {
      isDark = !isDark!;
      CacheHelper.savedata(key: 'isDark', value: isDark!).then((value) {
        emit(AppChangeMode());
      });
    }
  }
}
