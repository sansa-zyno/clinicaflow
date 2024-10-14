import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healtether_clinic_app/constants/app_colors.dart';
import 'package:healtether_clinic_app/data_layer/models/appointment_models/appointment_model.dart';
import 'package:healtether_clinic_app/utils/extensions.dart/widget_extensions.dart';

class AppointmentLogItem extends StatelessWidget {
  const AppointmentLogItem({super.key, required this.appointmentLog});
  final AppointmentLog appointmentLog;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: const BoxDecoration(
              shape: BoxShape.circle, color: AppColors.blueViolet),
        ).pAll(4),
        const SizedBox(
          width: 4,
        ),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //? time
              Text(
                appointmentLog.time,
                style: GoogleFonts.roboto(
                    textStyle: const TextStyle(
                        color: AppColors.blueViolet,
                        fontWeight: FontWeight.w500,
                        fontSize: 11,
                        height: 14.3 / 11)),
              ),

              //? appointment
              Text(appointmentLog.message),
            ],
          ),
        ),
      ],
    );
  }
}
