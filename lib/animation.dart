import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';

import 'main_controller.dart';

class Animation extends StatefulWidget {
  const Animation({super.key});

  @override
  State<Animation> createState() => _AnimationState();
}
final controller c = Get.put(controller());

class _AnimationState extends State<Animation> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    c.delay();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2F4F4F), // Slate Gray background
      body: Center(
        child: Lottie.asset(
          "assets/animations/my_animation.json",
          width: 300, // Adjust width as needed
          height: 300, // Adjust height as needed
        ),
      ),
    );
  }

}

