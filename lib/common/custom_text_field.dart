import 'package:amazon_clone/Constants/Constants.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {Key? key,
      required this.hintText,
      required this.controller,
      required this.callback})
      : super(key: key);

  final TextEditingController controller;
  final String hintText;
  final ValueChanged<String> callback;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          hintText: hintText,
          border:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: GlobalVariables.secondaryColor))),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter $hintText.";
        }
        return null;
      },
      onChanged: (value) {
        callback(value);
      },
    );
  }
}
