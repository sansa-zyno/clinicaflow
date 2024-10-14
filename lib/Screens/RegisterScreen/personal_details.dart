import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healtether_clinic_app/widgets/CustomTextField.dart';

class PersonalDetailsRegisterScreen extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController numberController;

  const PersonalDetailsRegisterScreen(
      {super.key,
      required this.nameController,
      required this.numberController});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          const Text(
            "Personal Details",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Enter your Name*",
            style: TextStyle(fontSize: 14),
          ),
          const SizedBox(
            height: 8,
          ),
          CustomTextField(
            controller: nameController,
            hintText: "Enter your Name",
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "Enter your mobile number *",
            style: TextStyle(fontSize: 14),
          ),
          const SizedBox(
            height: 8,
          ),
          CustomTextField(
            controller: numberController,
            hintText: "Mobile No.",
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
