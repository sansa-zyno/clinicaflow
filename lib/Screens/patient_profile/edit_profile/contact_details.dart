import 'package:flutter/material.dart';
import 'package:healtether_clinic_app/widgets/CustomTextField.dart';

class ContactsEdit extends StatefulWidget {
  const ContactsEdit({super.key});

  @override
  State<ContactsEdit> createState() => _ContactsEditState();
}

class _ContactsEditState extends State<ContactsEdit> {
  final TextEditingController _number1controller =
      TextEditingController(text: "+91 9865 632142");

  final TextEditingController _number2controller =
      TextEditingController(text: "+91 9865 632142");

  final TextEditingController _emailcontroller =
      TextEditingController(text: "Jana Doe");

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Contact Details ",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 7,
            ),
            CustomTextField(
              controller: _number1controller,
              hintText: "write new number",
             
              suffIcon: IconButton(
                  onPressed: () {
                    _number1controller.clear();
                  },
                  icon: const Icon(
                    Icons.minimize_outlined,
                    color: Colors.black,
                  )),
            ),
            const SizedBox(
              height: 7,
            ),
            CustomTextField(
              controller: _number2controller,
             hintText: "write new number",
              suffIcon: IconButton(
                  onPressed: () {
                    _number2controller.clear();
                  },
                  icon: const Icon(
                    Icons.minimize_outlined,
                    color: Colors.black,
                  )),
            ),
            TextButton(
                onPressed: () {},
                child: const Text(
                  "+  Add another number",
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Color(0xff009394),
                      fontSize: 16,
                      fontWeight: FontWeight.w700),
                )),
            CustomTextField(
              controller: _emailcontroller,
              hintText: "Add mail",
              suffIcon: IconButton(
                  onPressed: () {_emailcontroller.clear();},
                  icon: const Icon(
                    Icons.minimize_outlined,
                    color: Colors.black,
                  )),
            ),
            TextButton(
                onPressed: () {},
                child: const Text(
                  "+  Add another Email",
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Color(0xff009394),
                      fontSize: 16,
                      fontWeight: FontWeight.w700),
                )),
            const Text(
              "Address",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            CustomTextField(
                hintText: "Shridhamam Pvt society, Room 503", suff: "-"),
            const SizedBox(
              height: 7,
            ),
            CustomTextField(hintText: "Opp. BHEL R&D gate", suff: "-"),
            const SizedBox(
              height: 7,
            ),
            CustomTextField(hintText: "BalaNagar", suff: "-"),
            const SizedBox(
              height: 7,
            ),
            CustomTextField(hintText: "Hyderabad", suff: "-"),
          ],
        ),
      ),
    );
  }
}
