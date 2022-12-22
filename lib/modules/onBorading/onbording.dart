import 'package:app/modules/login/loginshobapp.dart';
import 'package:app/shared/componets/compontes.dart';
import 'package:app/shared/network/local/shareprefrences.dart';
import 'package:app/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// ignore: camel_case_types
class Boarding_Model {
  final String? image;
  final String? title;
  final String? body;
  Boarding_Model(
      {required this.image, required this.body, required this.title});
}

// ignore: camel_case_types, must_be_immutable
class OnBording_Screen extends StatefulWidget {
  const OnBording_Screen({Key? key}) : super(key: key);

  @override
  State<OnBording_Screen> createState() => _OnBording_ScreenState();
}

// ignore: camel_case_types
class _OnBording_ScreenState extends State<OnBording_Screen> {
  List<Boarding_Model> bording = [
    Boarding_Model(
        image: 'assets/images/splash_1.png',
        body: 'on board body 1',
        title: 'on board title 1'),
    Boarding_Model(
        image: 'assets/images/splash_2.png',
        body: 'on board body 2',
        title: 'on board title 2'),
    Boarding_Model(
        image: 'assets/images/splash_3.png',
        body: 'on board body 3',
        title: 'on board title 3'),
  ];

  var pageControelr = PageController();

  bool islast = false;
  void submiet() {
    CacheHelper.savedata(key: 'onBoarding', value: true).then((value) {
      if (value) {
        navigetandfinsh(context, Login_ShopApp());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(
                onPressed: () {
                  submiet();
                },
                child: const Text('SKIP'))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  onPageChanged: (int index) {
                    if (index == bording.length - 1) {
                      setState(() {
                        islast = true;
                      });
                    } else {
                      setState(() {
                        islast = false;
                      });
                    }
                  },
                  physics: const BouncingScrollPhysics(),
                  controller: pageControelr,
                  itemBuilder: (context, index) => itembuild(bording[index]),
                  itemCount: bording.length,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  SmoothPageIndicator(
                    controller: pageControelr,
                    count: bording.length,
                    effect: ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      activeDotColor: defultcolor,
                      dotHeight: 10,
                      dotWidth: 10,
                      expansionFactor: 3,
                      spacing: 8,
                    ),
                  ),
                  const Spacer(),
                  FloatingActionButton(
                      onPressed: () {
                        if (islast) {
                          submiet();
                        } else {
                          pageControelr.nextPage(
                            duration: const Duration(
                              milliseconds: 750,
                            ),
                            curve: Curves.fastLinearToSlowEaseIn,
                          );
                        }
                      },
                      child: const Icon(Icons.navigate_next))
                ],
              )
            ],
          ),
        ));
  }

  Widget itembuild(Boarding_Model model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Image(image: AssetImage('${model.image}'))),
          const SizedBox(
            height: 24,
          ),
          Text(
            '${model.title}',
            style: const TextStyle(fontSize: 30),
          ),
          const SizedBox(
            height: 14,
          ),
          Text(
            '${model.body}',
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(
            height: 18,
          ),
        ],
      );
}
