import 'dart:async';


import 'package:app/modules/onBorading/onbording.dart';
import 'package:flutter/material.dart';

import 'widgets/splachbbody.dart';

// ignore: camel_case_types
class Splach_View extends StatefulWidget {
  const Splach_View({super.key});

  @override
  State<Splach_View> createState() => _Splach_ViewState();
}

// ignore: camel_case_types
class _Splach_ViewState extends State<Splach_View> {
  @override
  void initState() {
  
    super.initState();
    Timer(const Duration(seconds: 5),
    ()=>Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context)=> const OnBording_Screen()))
    );
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.white,
      body:const Splach_Body() ,
    );
  }
}
