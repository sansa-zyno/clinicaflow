import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:healtether_clinic_app/Screens/ChatScreen/cancel_appointment_screen.dart';
import 'package:healtether_clinic_app/Screens/ChatScreen/custom_screen.dart';
import 'package:healtether_clinic_app/Screens/ChatScreen/reschedule_appointment_screen.dart';
import 'package:healtether_clinic_app/Screens/ChatScreen/schedule_new_appointment_screen.dart';
import 'package:healtether_clinic_app/constants/constants.dart';
import 'package:healtether_clinic_app/constants/app_text.dart';

class DraftTemplatesScreen extends StatelessWidget {
  const DraftTemplatesScreen({super.key});

  Widget _buildTemplateButton(
      BuildContext context, String text, Color bgColor, VoidCallback onTap) {
    return Container(
      width: 358,
      height: 54,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(7),
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            text,
            style: const TextStyle(
              color: AppColors.blackColor,
              fontSize: 13,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        // centerTitle: true,
        title: const Text(
          AppText.draftTemplates,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        actions: [
          Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.blackColor),
              borderRadius: BorderRadius.circular(6),
            ),
            child: InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: const Icon(
                Icons.close_rounded,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              // Handle three dots action
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CustomScreen()),
                );
              },
              child: Container(
                width: 358,
                height: 55,
                decoration: BoxDecoration(
                  color: AppColors.greenColor,
                  borderRadius: BorderRadius.circular(7),
                ),
                padding: const EdgeInsets.fromLTRB(19, 16, 19, 16),
                child: const Center(
                  child: Text(
                    'Create Custom Message',
                    style: TextStyle(
                      color: AppColors.whiteColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            _buildTemplateButton(
              context,
              'Schedule new appointment',
              AppColors.whiteColor,
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ScheduleNewAppointmentScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 8),
            _buildTemplateButton(
              context,
              'Reschedule appointment',
              AppColors.whiteColor,
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RescheduleAppointmentScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 8),
            _buildTemplateButton(
              context,
              'Cancel appointment',
              AppColors.whiteColor,
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CancelAppointmentScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 8),
            _buildTemplateButton(
              context,
              'Custom message 1',
              AppColors.whiteColor,
              () {
                if (kDebugMode) {
                  print("Now");
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
