// ignore_for_file: constant_identifier_names

import 'package:app/layout/shop_app/cubit/shopapp_cubit.dart';
import 'package:app/modules/login/loginshobapp.dart';
import 'package:app/shared/features/cubit/presentation/cubit/cubit_cubit.dart';
import 'package:app/shared/network/local/shareprefrences.dart';
import 'package:app/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget defultbutton({
  double width = double.infinity,
  required Function function,
  required String text,
  bool isUpaercase = true,
  double raduis = 0.0,
  double? height,
MaterialColor? color,
}) =>
    Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(raduis), color: color),
      width: width,
      height: height,
      child: MaterialButton(
        onPressed: () {
          function();
        },
        child: Text(
          isUpaercase ? text.toUpperCase() : text,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
Widget textfromfielde({
  required String label,
  TextEditingController? controller,
  required TextInputType type,
  required IconData prefix,
  required Function vildate,
  Function? onchange,
  Function? onsubmaited,
  bool isscure = false,
  IconData? suffixicon,
  Function? onpressedicon,
  Function? ontap,
}) =>
    TextFormField(
      onTap: () {
        if (ontap != null) {
          ontap();
        }
      },

      onFieldSubmitted: (value) {
        onsubmaited != null ? onsubmaited(value) : null;
      },
      // ignore: unnecessary_null_comparison
      onChanged: (value) {
        if (onchange != null) {
          onchange(value);
        }
      },
      validator: (value) {
        return vildate(value);
      },
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        prefixIcon: Icon(prefix),
        suffixIcon: suffixicon != null
            ? IconButton(
                onPressed: () {
                  onpressedicon!();
                },
                icon: Icon(suffixicon))
            : null,
      ),
      keyboardType: type,
      controller: controller,
      obscureText: isscure,
    );
vildateemail(value) {
  if (value!.isEmpty) {
    return 'failed is reuierd';
  }
  String pattern = r'\w+@\w+\.\w+';
  if (!RegExp(pattern).hasMatch(value)) {
    return 'Invalid E-mail Address format.';
  }
  return null;
}

Widget buildtaskitem(Map model, context) {
  return Dismissible(
    key: Key(model['id'].toString()),
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor:
                AppCubit.get(context).colors[AppCubit.get(context).cureent],
            child: Text(
              '${model['time']}',
              style: const TextStyle(
                  fontSize: 17,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${model['titles']}',
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${model['data']}',
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            width: 14,
          ),
          IconButton(
              onPressed: () {
                AppCubit.get(context)
                    .updateData(state: 'done', id: model['id']);
              },
              icon: const Icon(Icons.check_box)),
          IconButton(
              onPressed: () {
                AppCubit.get(context)
                    .updateData(state: 'archive', id: model['id']);
              },
              icon: const Icon(Icons.archive_rounded)),
        ],
      ),
    ),
    onDismissed: (direction) {
      AppCubit.get(context).deletData(id: model['id']);
    },
  );
}
/*
Widget newsAppbuild(articles, context) {
  return InkWell(
    onTap: () {
      navigetto(
        context,
        Web_view(articles['url']),
      );
    },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Container(
            height: 120,
            width: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                  image: NetworkImage('${articles['urlToImage']}'),
                  fit: BoxFit.cover),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(left: 17),
              height: 120,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('${articles['title']}',
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyText1),
                  Text(
                    '${articles['publishedAt']}',
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, color: Colors.grey),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
*/
Widget speeratedbuilder() {
  return Container(
    width: double.infinity,
    height: 1,
    color: Colors.grey,
  );
}

void navigetto(context, widget) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
}

void navigetandfinsh(context, widget) {
  Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (Route<dynamic> route) => false);
}
/*
Widget articleBuilder(list, context, {isSewarch = false}) => Conditional.single(
      context: context,
      conditionBuilder: (BuildContext context) => list.isNotEmpty,
      widgetBuilder: (BuildContext context) => ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) => newsAppbuild(list[index], context),
        separatorBuilder: (context, index) => speeratedbuilder(),
        itemCount: list.length,
      ),
      fallbackBuilder: (BuildContext context) => isSewarch
          ? Container()
          : const Center(child: CircularProgressIndicator()),
    );
*/
void showtoast({
  required String msg,
  required ToastStates state,
}) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: choosetoastcolor(state),
      textColor: Colors.white,
      fontSize: 16.0);
}


enum ToastStates { WARRING, ERROR, SUCCESS }

Color? choosetoastcolor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARRING:
      color = Colors.amber;
      break;
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
  }
  return color;
}

void logoutonpreseed(context) {
  CacheHelper.removedatae(key: 'token').then((value) {
    if (value) {
      navigetandfinsh(context, Login_ShopApp());
    }
  });
}
Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 20.0,
      ),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
    );
Widget buildListProduct(
  model,
  context,
   {
  bool isOldPrice = true,
}) =>
    Container(
      padding: const EdgeInsets.all(10.0),
      height: 120.0,
      child: Row(
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage(model.image),
                width: 120.0,
                height: 120.0,
              ),
              if (model.discount != 0 && isOldPrice)
                Container(
                  color: Colors.red,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 5.0,
                  ),
                  child: const Text(
                    'DISCOUNT',
                    style: TextStyle(
                      fontSize: 8.0,
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(
            width: 20.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14.0,
                    height: 1.3,
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    Text(
                      model.price.toString(),
                      style: TextStyle(
                        fontSize: 12.0,
                        color: defultcolor,
                      ),
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    if (model.discount != 0 && isOldPrice)
                      Text(
                        model.oldPrice.toString(),
                        style: const TextStyle(
                          fontSize: 10.0,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
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
                          size: 14.0,
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
