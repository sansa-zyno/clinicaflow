import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:clinica_flow/core/constants/app_colors.dart';

class MyImageContainer extends StatelessWidget {
  const MyImageContainer(
      {super.key,
      this.child,
      this.file,
      this.size = 80,
      this.padding,
      this.onTap});

  final Widget? child;
  final XFile? file;
  final double size;
  final EdgeInsets? padding;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        padding: file != null ? null : padding ?? const EdgeInsets.all(20),
        decoration: const BoxDecoration(
            color: AppColors.lightGrey5, shape: BoxShape.circle),
        child: file != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.file(File(file!.path), fit: BoxFit.cover))
            : child,
      ),
    );
  }
}
