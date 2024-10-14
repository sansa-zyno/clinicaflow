// ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:app/presentation/widgets/controllers/listing_container_controller.dart';
import 'package:flutter/material.dart';
import 'package:healtether_clinic_app/constants/app_colors.dart';

class SelectableContainer extends StatelessWidget {
  const SelectableContainer(
      {super.key,
      this.leading,
      this.selectedLeading,
      this.title,
      this.selectedTitle,
      this.subtitle,
      this.selectedSubtitle,
      this.trailing,
      this.selectedTrailing,
      this.onTap,
      this.borderColor,
      this.height,
      this.width,
      this.selected = false,
      this.expanded = false,
      this.backgroundColor});

  final Color? backgroundColor;
  final Color? borderColor;

  final Widget? leading;
  final Widget? selectedLeading;

  final Widget? title;
  final Widget? selectedTitle;

  final Widget? subtitle;
  final Widget? selectedSubtitle;

  final Widget? trailing;
  final Widget? selectedTrailing;

  final bool selected;
  final void Function()? onTap;

  final bool expanded;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
          height: height,
          width: width,
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
              color: selected
                  ? AppColors.darkTeal
                  : backgroundColor ?? AppColors.whiteSmoke,
              border: Border.all(
                  color: selected
                      ? AppColors.darkTeal
                      : borderColor ?? AppColors.whiteSmoke),
              borderRadius: BorderRadius.circular(7)),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // leading
              (selected ? selectedLeading : leading) ?? const SizedBox(),

              // col | title and subtitle
              expanded
                  ? Expanded(
                      child: buildTitleAndSubtitle(),
                    )
                  : buildTitleAndSubtitle(),

              // trailing
              (selected ? selectedTrailing : trailing) ?? const SizedBox(),
            ],
          )),
    );
  }

  Padding buildTitleAndSubtitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          // title
          (selected ? selectedTitle : title) ?? const SizedBox(),

          // const SizedBox(height: 16,),

          // subtitle
          (selected ? selectedSubtitle : subtitle) ?? const SizedBox(),
        ],
      ),
    );
  }
}
