import 'package:app/layout/shop_app/cubit/shopapp_cubit.dart';
import 'package:app/shared/componets/compontes.dart';
import 'package:app/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';

// ignore: camel_case_types
class Settings_Screen extends StatelessWidget {
  const Settings_Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopappCubit, ShopappState>(
      listener: (context, state) {
        if (state is RegistercubitSucsfullyStatemodel) {
          showtoast(msg: 'Data Edit Scsfully',
           state:ToastStates.SUCCESS
          );
        }
        if (state is RegistercubitErorStatemodel) {

          showtoast(msg: ShopappCubit.get(context).registermodel!.message!,
           state:ToastStates.ERROR
          );
           
        }

      },
      builder: (context, state) {
        var nameControelr = TextEditingController();
        var emailControelr = TextEditingController();
        var phoneControelr = TextEditingController();
        var model = ShopappCubit.get(context).registermodel;
        var fromkey = GlobalKey<FormState>();
        emailControelr.text = model!.data!.email!;
        phoneControelr.text = model.data!.phone!;
        nameControelr.text = model.data!.name!;
        return Conditional.single(
            context: (context),
            conditionBuilder: (context) =>
                ShopappCubit.get(context).registermodel != null,
            widgetBuilder: (context) => Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SingleChildScrollView(
                    child: Form(
                      key: fromkey,
                      child: Column(
                        children: [
                          if (state is RegistercubitLoadStatemodel)
                            const LinearProgressIndicator(),
                          const SizedBox(
                            height: 20,
                          ),
                          textfromfielde(
                            label: 'Name',
                            type: TextInputType.name,
                            prefix: Icons.person,
                            vildate: (String value) {
                              if (value.isEmpty) {
                                return 'Name Must Not Be Empty';
                              }
                            },
                            controller: nameControelr,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          textfromfielde(
                            label: 'EmailAddress',
                            type: TextInputType.emailAddress,
                            prefix: Icons.email,
                            vildate: (String value) {
                              if (value.isEmpty) {
                                return 'email Must Not Be Empty';
                              }
                            },
                            controller: emailControelr,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          textfromfielde(
                            label: 'Phone',
                            type: TextInputType.phone,
                            prefix: Icons.phone_android,
                            vildate: (String value) {
                              if (value.isEmpty) {
                                return 'phone Must Not Be Empty';
                              }
                            },
                            controller: phoneControelr,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          defultbutton(
                            function: () {
                              if (fromkey.currentState!.validate()) {
                                ShopappCubit.get(context).putdataupdatat(
                                    name: nameControelr.text,
                                    email: emailControelr.text,
                                    phone: phoneControelr.text);
                              }
                            },
                            text: 'Updata',
                            color: defultcolor,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          defultbutton(
                            function: () {
                              logoutonpreseed(context);
                            },
                            text: 'Logout',
                            color: defultcolor,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
            fallbackBuilder: (context) =>
                const Center(child: CircularProgressIndicator()));
      },
    );
  }
}
