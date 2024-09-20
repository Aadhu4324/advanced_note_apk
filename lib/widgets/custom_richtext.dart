import 'package:flutter/material.dart';

class CustomRichtext extends StatelessWidget {
  final String data1;
  final String data2;
  const CustomRichtext({super.key, required this.data1, required this.data2});

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(
            style: const TextStyle(color: Colors.black, fontSize: 20),
            children: [
          TextSpan(text: data1),
          TextSpan(
              text: data2,
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold))
        ]));
  }
}
