import 'package:flutter/material.dart';
import 'package:healtether_clinic_app/Screens/AppointmentScreen/widgets/custom_textfield.dart';
import 'package:healtether_clinic_app/Screens/DigitalScreensAll/sx&dx_screen.dart';

class MySearchBar extends StatelessWidget {
  const MySearchBar({
    super.key,
    required this.searchController,
    required this.hintText,
    required this.onChanged,
    this.fillColor,
    this.focusNode,
    this.onEditingComplete,
  });

  final TextEditingController searchController;
  final String hintText;
  final void Function(String query) onChanged;
  final FocusNode? focusNode;
  final void Function()? onEditingComplete;
  final Color? fillColor;

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
        controller: searchController,
        hintText: hintText,
        focusNode: focusNode,
        fillColor: fillColor,
        onChanged: onChanged,
        onEditingComplete: onEditingComplete,
        borderRadius: 2,
        usePadding: false,
        contentPadding: const EdgeInsets.all(8),
        prefixIcon: const Icon(Icons.search, color: Colors.black87));
  }
}
