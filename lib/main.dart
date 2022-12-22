import 'package:app/modules/login/loginshobapp.dart';
import 'package:app/modules/onBorading/onbording.dart';
import 'package:app/shared/bloc_observer.dart';
import 'package:app/shared/features/cubit/presentation/cubit/cubit_cubit.dart';
import 'package:app/shared/network/local/shareprefrences.dart';
import 'package:app/shared/network/remot/diohelper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'layout/shop_app/cubit/shopapp_cubit.dart';
import 'layout/shop_app/homelayout.dart';
import 'shared/componets/constnts.dart';
import 'shared/styles/them.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  
  bool? isDark = CacheHelper.getData(key: 'isDark');
  Widget widget;
  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token');

  Bloc.observer = MyBlocObserver();
  if (kDebugMode) {
    print(token);
  }
  Dio_Helper.intal();
  //widget = const Splach_View();
  if (onBoarding != null) {
    if (token != null) {
      widget = const Home_LayoutShop();
    } else {
      widget = Login_ShopApp();
    }
  } else {
    widget = const OnBording_Screen();
  }

  runApp(Application(
    isDark: isDark,
    startwidget: widget,
  ));
}

class Application extends StatelessWidget {
  final bool? isDark;
  final Widget? startwidget;
  const Application({Key? key, this.isDark, this.startwidget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
       
        BlocProvider(
          create: (BuildContext context) =>
              AppCubit()..changmod(fromShared: isDark),
        ),
        BlocProvider(
            create: (BuildContext context) => ShopappCubit()
              ..getdata()
              ..getdatacatgeory()
              ..getdatafavourets()
              ..getdatasetting())
      ],
      child: BlocConsumer<AppCubit, AppState>(
          listener: (BuildContext context, state) {},
          builder: (BuildContext context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: themlight,
              darkTheme: themdark,
              themeMode: AppCubit.get(context).isDark!
                  ? ThemeMode.dark
                  : ThemeMode.light,
              home: startwidget,
            );
          }),
    );
  }
}
