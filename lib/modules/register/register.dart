import 'package:app/layout/shop_app/homelayout.dart';
import 'package:app/modules/register/cubit/registercubit_cubit.dart';
import 'package:app/shared/componets/compontes.dart';
import 'package:app/shared/componets/constnts.dart';
import 'package:app/shared/network/local/shareprefrences.dart';
import 'package:app/shared/styles/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';

// ignore: camel_case_types, must_be_immutable
class Register_ShopApp extends StatelessWidget {
  Register_ShopApp({Key? key}) : super(key: key);
  var emailcontroelr = TextEditingController();
  var passwordcontroelr = TextEditingController();
  var namecontroelr = TextEditingController();
  var phonecontroelr = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterState>(
        listener: (context, state) {
          if (state is RegistercubitSucsfullyState) {
            if (state.registermodel.status!) {
              if (kDebugMode) {
                print(state.registermodel.message);
                print(state.registermodel.data!.token);
                CacheHelper.savedata(
                        key: 'token', value: state.registermodel.data!.token)
                    .then((value) {
                  token = state.registermodel.data!.token;
                  navigetandfinsh(context, const Home_LayoutShop());
                });
              }
            } else {
              if (kDebugMode) {
                print(state.registermodel.message);
                showtoast(
                    msg: '${state.registermodel.message}',
                    state: ToastStates.ERROR);
              }
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Register',
                            style: Theme.of(context)
                                .textTheme
                                .headline4
                                ?.copyWith(color: Colors.deepOrangeAccent),
                          ),
                          Text(
                            'Register Now to  Start',
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                ?.copyWith(color: Colors.deepOrange),
                          ),
                         const SizedBox(height: 10,),
                           textfromfielde(
                              controller: namecontroelr,
                              label: 'Name',
                              type: TextInputType.name,
                              prefix: Icons.person,
                              vildate: (String value) {
                                if (value.isEmpty) {
                                  return 'Name is Empty ';
                                }
                                // String pattern = r'\w+@\w+\.\w+';
                                //if (!RegExp(pattern).hasMatch(value)) {
                                //return 'Invalid E-mail Address format.';
                                //}
                                return null;
                              }),
                          const SizedBox(
                            height: 12,
                          ),
                          textfromfielde(
                              controller: emailcontroelr,
                              label: 'EmailAdress',
                              type: TextInputType.emailAddress,
                              prefix: Icons.email_rounded,
                              vildate: (String value) {
                                if (value.isEmpty) {
                                  return 'EmailAdress is Empty ';
                                }
                                 String pattern = r'\w+@\w+\.\w+';
                                if (!RegExp(pattern).hasMatch(value)) {
                                return 'Invalid E-mail Address format.';
                                }
                                return null;
                              }),
                          const SizedBox(
                            height: 15,
                          ),
                          textfromfielde(
                              controller: passwordcontroelr,
                              suffixicon: ShopRegisterCubit.get(context).iconlog,
                              label: 'password',
                              isscure: ShopRegisterCubit.get(context).ispaswored,
                              onpressedicon: () {
                                ShopRegisterCubit.get(context)
                                    .changeiconpassword();
                              },
                              onsubmaited: (value) {
                                if (formKey.currentState!.validate()) {
                                  return ShopRegisterCubit.get(context).userRegister(
                                    email: emailcontroelr.text,
                                    password: passwordcontroelr.text,
                                  );
                                }
                              },
                              type: TextInputType.visiblePassword,
                              prefix: Icons.password_rounded,
                              vildate: (String value) {
                                if (value.isEmpty) {
                                  return 'password is Empty';
                                }
                                
                              }),
                          const SizedBox(
                            height: 20,
                          ),
                           textfromfielde(
                              controller: phonecontroelr,
                              label: 'Phone',
                              type: TextInputType.phone,
                              prefix: Icons.phone_android,
                              vildate: (String value) {
                                if (value.isEmpty) {
                                  return 'Phone is Empty ';
                                }
                                // String pattern = r'\w+@\w+\.\w+';
                                //if (!RegExp(pattern).hasMatch(value)) {
                                //return 'Invalid E-mail Address format.';
                                //}
                                return null;
                              }),
                          const SizedBox(
                            height: 12,
                          ),
                          Conditional.single(
                            context: context,
                            conditionBuilder: (BuildContext context) =>
                                state is! RegistercubitLoadState,
                            widgetBuilder: (context) => defultbutton(
                                color: defultcolor,
                                function: () {
                                  if (formKey.currentState!.validate()) {
                                    ShopRegisterCubit.get(context).userRegister(
                                      email: emailcontroelr.text,
                                      password: passwordcontroelr.text,
                                      name: namecontroelr.text,
                                      phone: phonecontroelr.text
                                    );
                                  }
                                },
                                text: 'Register',
                                isUpaercase: true),
                            fallbackBuilder: (context) => const Center(
                                child: CircularProgressIndicator()),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                         
                        ]),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

