// ignore: camel_case_types
import 'package:app/layout/shop_app/cubit/shopapp_cubit.dart';
import 'package:app/shared/componets/compontes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';

// ignore: camel_case_types
class Favourets_Screen extends StatelessWidget
{
  const Favourets_Screen({super.key});

  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<ShopappCubit, ShopappState>(
      listener: (context, state) {},
      builder: (context, state)
      {
        return Conditional.single(
          context: (context),
          
          conditionBuilder: (context) => state is! ShopappLoadScreenfa,
          widgetBuilder: (context) => ListView.separated(
            physics:const BouncingScrollPhysics(),
            itemBuilder:(context, index) => buildListProduct(ShopappCubit.get(context).favouretsmodel!.data!.data![index].product, context),
            separatorBuilder: (context, index) => myDivider(),
            itemCount: ShopappCubit.get(context).favouretsmodel!.data!.data!.length,
          ),
          fallbackBuilder:(context) => const  Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
