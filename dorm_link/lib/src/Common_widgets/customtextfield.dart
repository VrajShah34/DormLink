import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField(
      {super.key, required this.controller, required this.hintText, this.isPassword=false});

  final TextEditingController controller;
  final String hintText;
  bool isPassword=false;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      cursorColor: Color(0xFF4A9DFF),
      style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
      decoration: InputDecoration(
          hintText: hintText,
          fillColor: Colors.white,
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xFFE8ECF4)),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey.shade400,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.red,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(8),
          )),
    );
  }
}
