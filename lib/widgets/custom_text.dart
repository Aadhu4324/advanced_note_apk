import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String data;
  const CustomText({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return  AnimatedTextKit(
                              totalRepeatCount: 1,
                              animatedTexts: [
                            TyperAnimatedText(
                                speed: const Duration(milliseconds: 100),
                               data,
                                textStyle: const TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red))
                          ]);
  }
}