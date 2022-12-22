import 'package:flutter/material.dart';

// ignore: camel_case_types
class Splach_Body extends StatefulWidget {
  const Splach_Body({super.key});

  @override
  State<Splach_Body> createState() => _Splach_BodyState();
}

// ignore: camel_case_types
class _Splach_BodyState extends State<Splach_Body>
    with SingleTickerProviderStateMixin {
  AnimationController? animationController;
  Animation? fadeanimation;
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));
    fadeanimation =
        Tween<double>(begin: 0.2, end: 1).animate(animationController!);
    animationController?.repeat(reverse: true);
    
  }

  @override
  void dispose() {
    animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // const Spacer(),
        AnimatedBuilder(
          animation: fadeanimation!,
          builder: (context, _) => Opacity(
            opacity: fadeanimation?.value,
            child: const Text(
              'Big Market',
              style: TextStyle(
                color: Colors.deepOrange,
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 30,
        ),

        Image.asset('assets/images/splach_splach.jpg'),
        
       
         
         
      ],
    );
  }
}


