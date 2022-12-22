// ignore: camel_case_types
import 'package:app/layout/shop_app/cubit/shopapp_cubit.dart';
import 'package:app/models/users/shopapp/homemodels.dart';
import 'package:app/shared/componets/compontes.dart';
import 'package:app/shared/styles/colors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';

// ignore: camel_case_types
class Products_Screeen extends StatelessWidget {
  const Products_Screeen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopappCubit, ShopappState>(
      listener: (context, state) {
        if (state is ShopappScsufllyfav) {
          if (!state.model.status!) {
            showtoast(msg: state.model.message!, state: ToastStates.ERROR);
          }
        }
      },
      builder: (context, state) {
        return Conditional.single(
            context: context,
            conditionBuilder: (BuildContext context) =>
                ShopappCubit.get(context).homemodel != null &&
                ShopappCubit.get(context).catmodels != null,
            widgetBuilder: (context) =>
                productsbuilder(ShopappCubit.get(context).homemodel!, context),
            fallbackBuilder: (context) =>
                const Center(child: CircularProgressIndicator()));
      },
    );
  }

  Widget productsbuilder(Home_Model model, context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
            items: model.data.banners
                .map((e) => Image(
                      image: NetworkImage(e.image),
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ))
                .toList(),
            options: CarouselOptions(
              height: 200,
              initialPage: 0,
              viewportFraction: 1.0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayAnimationDuration: const Duration(seconds: 1),
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              'NEW PRODUCTS',
              style: TextStyle(
                  color: defultcolor,
                  fontSize: 20,
                  fontWeight: FontWeight.w800),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            color: Colors.grey.shade300,
            child: GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 1,
              crossAxisSpacing: 1,
              childAspectRatio: 1 / 1.72,
              crossAxisCount: 2,
              children: (List.generate(model.data.products.length,
                  (index) => griditem(model.data.products[index], context))),
            ),
          )
        ],
      ),
    );
  }

  Widget griditem(BroductsModel model, context) {
          return  Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                 width: double.infinity,
                image: NetworkImage(model.image),
                height: 200,
              ),
              if (model.discount != 0)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  color: Colors.red,
                  child: const Text(
                    'DISCOUNT',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 8,
                    ),
                  ),
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 14, height: 1.3),
                ),
                Row(
                  children: [
                    Text(
                      '${model.price.round()}',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.deepOrange,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    if (model.discount != 0)
                      Text(
                        '${model.old_price.round()}',
                        style: const TextStyle(
                            fontSize: 10,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough),
                      ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        ShopappCubit.get(context).changefavbootom(model.id);
                      },
                      icon: CircleAvatar(
                        radius: 15.0,
                        backgroundColor:
                            ShopappCubit.get(context).favourets[model.id]!
                                ? defultcolor
                                : Colors.grey,
                        child: const Icon(
                          Icons.favorite_border,
                          size: 14,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );    
  }
}
