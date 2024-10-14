import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final double? width;
  final TextInputType? type;
  final TextInputType? keyboardType;
  final Widget? suffIcon;
  final String? suff;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final int? numberLength;
  final bool obscureText;

  const CustomTextField(
      {super.key,
      this.hintText = '',
      this.width,
      this.type,
      this.suff,
      this.suffIcon,
      this.controller,
      this.validator,
      this.keyboardType,
      this.numberLength,
      this.obscureText = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
height: 50,
      //color: Color(0xffF5F5F5),

      child: TextFormField(
        keyboardType: keyboardType,
        controller: controller,
        validator: validator,
        obscureText: obscureText,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        inputFormatters: [
          LengthLimitingTextInputFormatter(numberLength),
        ],
        //  keyboardType: TextFormField,
        decoration: InputDecoration(
          suffixIcon: suffIcon,
          suffixText: suff,
          hintText: hintText,
          fillColor: const Color(0xFFEAE8EE), //TODO: MAKE FILL COLOR SWAPPABLE
          filled: true,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7),
              borderSide: const BorderSide(color: Colors.transparent)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7),
              borderSide: const BorderSide(color: Colors.transparent)),
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7),
              borderSide: const BorderSide(color: Colors.transparent)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7),
              borderSide: const BorderSide(color: Colors.transparent)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7),
              borderSide: const BorderSide(color: Colors.transparent)),
        ),
      ),
    );
  }
}
