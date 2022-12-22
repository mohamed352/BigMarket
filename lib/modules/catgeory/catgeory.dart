

// ignore: camel_case_types
import 'package:app/layout/shop_app/cubit/shopapp_cubit.dart';
import 'package:app/models/users/shopapp/categoriesmodels.dart';
import 'package:app/shared/componets/compontes.dart';
import 'package:app/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: camel_case_types
class Categores_Screen extends StatelessWidget {
  const Categores_Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopappCubit, ShopappState>(
      listener: (context, state) {},
      builder: (context, state) {
        return ListView.separated(
          physics: const BouncingScrollPhysics(),
          padding:const EdgeInsets.symmetric(horizontal: 5),
          itemBuilder: (context, index) =>
              buildcatitem(ShopappCubit.get(context).catmodels!.data.data[index]),
          separatorBuilder: (context, index) => speeratedbuilder(),
          itemCount: ShopappCubit.get(context).catmodels!.data.data.length,
        );
      },
    );
  }

  Widget buildcatitem(Data2Cat model) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
          children: [
           Image(image: NetworkImage(model.image),
          
          fit: BoxFit.cover,
          height: 80,
          width: 80,),
      
          const SizedBox(width: 15,),
          Text(model.name,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style:TextStyle(
            
            color: defultcolor,
            fontSize: 20,
            fontWeight: FontWeight.bold

          )
          ),
          const Spacer(),
          IconButton(onPressed: (){},
           icon:const  Icon(
            Icons.arrow_forward_ios,
                  ),
           )
        

        ],
      ),
    );
  }
}
