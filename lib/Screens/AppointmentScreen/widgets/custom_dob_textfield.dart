import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomTextDOBContainer extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final double height;
  final Function(DateTime)? onDOBSelected;

  const CustomTextDOBContainer({super.key,
    required this.controller,
    required this.hintText,
    required this.height,
    this.onDOBSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      color: const Color(0xffF5F5F5),
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 15,
          bottom: 10,
          left: 10,
          right: 30,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: CustomDateOfBirthTextField(
                controller: controller,
                hintText: hintText,
                onDOBSelected:
                    onDOBSelected, // Pass the callback to the child widget
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomDateOfBirthTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final Function(DateTime)? onDOBSelected; // Renamed from onDateSelected

  const CustomDateOfBirthTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.onDOBSelected,
  }) : super(key: key);

  @override
  CustomDateOfBirthTextFieldState createState() =>
      CustomDateOfBirthTextFieldState();
}

class CustomDateOfBirthTextFieldState
    extends State<CustomDateOfBirthTextField> {
  DateTime? _dob;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _pickDate(context),
      child: AbsorbPointer(
        child: TextFormField(
          controller: widget.controller,
          decoration: InputDecoration(
            hintText: widget.hintText,
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  Future<void> _pickDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null && pickedDate != _dob) {
      setState(() {
        _dob = pickedDate;
        widget.controller.text = DateFormat('yyyy-MM-dd').format(_dob!);
        widget.onDOBSelected?.call(_dob!);
      });
    }
  }
}
