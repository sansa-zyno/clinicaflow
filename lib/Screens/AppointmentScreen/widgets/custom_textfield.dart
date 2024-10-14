import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:healtether_clinic_app/constants/constants.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final double? height;
  final double? width;
  final ValueChanged<String>? onChanged;
  final TextInputType? keyBoardType;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool readOnly;
  final void Function()? onTap;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final EdgeInsetsGeometry? contentPadding;
  final bool obscureText;
  final Color? fillColor;
  final double borderRadius;
  final String? suffixText;
  final TextStyle? hintStyle;
  final bool? usePadding;
  final FocusNode? focusNode;
  final void Function()? onEditingComplete;
  final int? maxLines;
  final int? minLines;

  const CustomTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      this.obscureText = false,
      this.maxLines = 1,
      this.minLines = 1,
      this.focusNode,
      this.onEditingComplete,
      this.borderRadius = 7,
      this.hintStyle,
      this.height,
      this.width,
      this.onChanged,
      this.suffixText,
      this.suffixIcon,
      this.prefixIcon,
      this.readOnly = false,
      this.fillColor,
      this.validator,
      this.onTap,
      this.inputFormatters,
      this.keyBoardType,
      this.usePadding,
      this.contentPadding});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: (usePadding ?? false) == false ? 0 : 10.0),
        child: TextFormField(
          keyboardType: keyBoardType,
          controller: controller,
          onChanged: onChanged,
          readOnly: readOnly,
          onEditingComplete: onEditingComplete,
          focusNode: focusNode,
          inputFormatters: inputFormatters,
          onTap: onTap,
          validator: validator,
          obscureText: obscureText,
          maxLines: maxLines,
          minLines: minLines,
          decoration: InputDecoration(
            hintText: hintText,
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
            suffixText: suffixText,
            fillColor: fillColor ?? AppColors.textFieldFillColor,
            contentPadding: contentPadding,
            filled: true,
            hintStyle: hintStyle ??
                const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: const BorderSide(color: Colors.transparent)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: const BorderSide(color: Colors.transparent)),
            disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: const BorderSide(color: Colors.transparent)),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: const BorderSide(color: Colors.transparent)),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: const BorderSide(color: Colors.transparent)),
          ),
        ),
      ),
    );
  }
}
