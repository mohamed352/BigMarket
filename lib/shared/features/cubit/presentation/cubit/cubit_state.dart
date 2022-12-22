part of 'cubit_cubit.dart';

abstract class AppState extends Equatable {
  

  @override
  List<Object> get props => [];
}

class AppInitialstate extends AppState {}
class AppChangeBootmNavgtorState extends AppState{}
class AppCereatDataBase extends AppState {}
class AppInserTODataBase extends AppState {}
class AppGetFromDataBase extends AppState {}
class AppChangeBootmSheetState extends AppState{}
class AppGetFromDataBaseLodng extends AppState {}
class AppUdateTODataBase extends AppState {}
class AppDeletTODataBase extends AppState {}
class AppChangeMode extends AppState {}
class AppIconChangeMode extends AppState {}