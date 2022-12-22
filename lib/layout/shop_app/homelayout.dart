import 'package:app/layout/shop_app/cubit/shopapp_cubit.dart';
import 'package:app/shared/componets/compontes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../modules/search/serchscreeen.dart';
import '../../shared/features/cubit/presentation/cubit/cubit_cubit.dart';

// ignore: camel_case_types
class Home_LayoutShop extends StatelessWidget {
  const Home_LayoutShop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopappCubit, ShopappState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopappCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                  onPressed: () {
                    navigetto(context, const Search_Screen());
                  },
                  icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: (){
              AppCubit.get(context).changmod();
            },
             icon:const Icon(Icons.dark_mode_outlined)
             )
          ],
            title: const Text('Big Market'),
          ),
          body: cubit.screen[cubit.currentindex],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,

              currentIndex: cubit.currentindex,
              onTap: (int index) {
                cubit.changebootm(index);
              },
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home_filled), label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.category), label: 'category'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.favorite), label: 'favorite'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.settings), label: 'settings'),
              ]),
        );
      },
    );
  }
}
