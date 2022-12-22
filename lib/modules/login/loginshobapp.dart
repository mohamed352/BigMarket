import 'package:app/layout/shop_app/homelayout.dart';
import 'package:app/modules/login/cubit/logincubit_cubit.dart';
import 'package:app/modules/register/register.dart';
import 'package:app/shared/componets/compontes.dart';
import 'package:app/shared/componets/constnts.dart';
import 'package:app/shared/network/local/shareprefrences.dart';
import 'package:app/shared/styles/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';

// ignore: camel_case_types, must_be_immutable
class Login_ShopApp extends StatelessWidget {
  Login_ShopApp({Key? key}) : super(key: key);
  var emailcontroelr = TextEditingController();
  var passwordcontroelr = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginState>(
        listener: (context, state) {
          if (state is LogincubitSucsfullyState) {
            if (state.loginmodel.status!) {
              if (kDebugMode) {
                print(state.loginmodel.message);
                print(state.loginmodel.data!.token);
                CacheHelper.savedata(
                        key: 'token', value: state.loginmodel.data!.token)
                    .then((value) {
                  token = state.loginmodel.data!.token;
                  navigetandfinsh(context, const Home_LayoutShop());
                });
              }
            } else {
              if (kDebugMode) {
                print(state.loginmodel.message);
                showtoast(
                    msg: '${state.loginmodel.message}',
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
                            'Login',
                            style: Theme.of(context)
                                .textTheme
                                .headline4
                                ?.copyWith(color: Colors.deepOrangeAccent),
                          ),
                          Text(
                            'Login Now to Get Offers',
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                ?.copyWith(color: Colors.deepOrange),
                          ),
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
                              suffixicon: ShopLoginCubit.get(context).iconlog,
                              label: 'password',
                              isscure: ShopLoginCubit.get(context).ispaswored,
                              onpressedicon: () {
                                ShopLoginCubit.get(context)
                                    .changeiconpassword();
                              },
                              onsubmaited: (value) {
                                if (formKey.currentState!.validate()) {
                                  return ShopLoginCubit.get(context).userlogin(
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
                          Conditional.single(
                            context: context,
                            conditionBuilder: (BuildContext context) =>
                                state is! LogincubitLoadState,
                            widgetBuilder: (context) => defultbutton(
                                color: defultcolor,
                                function: () {
                                  if (formKey.currentState!.validate()) {
                                    ShopLoginCubit.get(context).userlogin(
                                      email: emailcontroelr.text,
                                      password: passwordcontroelr.text,
                                    );
                                  }
                                },
                                text: 'Login',
                                isUpaercase: true),
                            fallbackBuilder: (context) => const Center(
                                child: CircularProgressIndicator()),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Don\'t Have an account'),
                              const SizedBox(
                                width: 10,
                              ),
                              TextButton(
                                  onPressed: () {
                                    navigetto(
                                        context,Register_ShopApp());
                                  },
                                  child: const Text('Register')),
                            ],
                          )
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
