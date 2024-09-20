import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  final String data;
 final  Color? textColor;
final  FontWeight? textWeight;
 final double textSize;

  MyText(
      {super.key,
      required this.data,
      this.textColor,
      this.textWeight,
      required this.textSize});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: TextStyle(
          color: textColor ?? Colors.black,
          fontWeight: textWeight ?? FontWeight.normal,
          fontSize: textSize),
    );
  }
}
