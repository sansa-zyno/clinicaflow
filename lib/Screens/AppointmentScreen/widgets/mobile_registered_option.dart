import 'package:flutter/material.dart';
import 'package:healtether_clinic_app/Screens/AppointmentScreen/widgets/option_container.dart';

class MobileRegisteredRow extends StatelessWidget {
  final VoidCallback onTapYes;
  final VoidCallback onTapNo;

  const MobileRegisteredRow({super.key, required this.onTapYes, required this.onTapNo});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('The mobile is already registered.',
            style: TextStyle(
              fontSize: 13,
              color: Color(0xff740AC7),
              fontWeight: FontWeight.w500,
            )),
        const SizedBox(height: 10),
        Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.3,
              child: Text(
                'Do you want to add new patient?',
                style: TextStyle(fontSize: 12, color: Colors.grey[800]),
              ),
            ),
            GestureDetector(
              onTap: onTapYes,
              child: OptionContainer(text: 'Yes', color: const Color(0xff03BF9C)),
            ),
            const SizedBox(width: 10),
            GestureDetector(
              onTap: onTapNo,
              child: OptionContainer(text: 'No', color: const Color(0xffF5F5F5)),
            ),
          ],
        ),
      ],
    );
  }
}
