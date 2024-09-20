import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  final TextEditingController controller;
  final String error;
  final String hintText;
   final bool expandOrNot;

  CustomFormField(
      {super.key,
     required this.expandOrNot,
      required this.controller,
      required this.error,
      required this.hintText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: expandOrNot ? 20 : 1,
      validator: (value) {
        if (value!.isEmpty) {
          return error;
        } else {
          return null;
        }
      },
      controller: controller,
      decoration: InputDecoration(
          hintText: hintText,
          border: OutlineInputBorder(),
          enabledBorder:
              OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          focusedBorder:
              OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
    );
  }
}
