import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healtether_clinic_app/constants/app_colors.dart';
import 'package:healtether_clinic_app/constants/app_icons.dart';
import 'package:healtether_clinic_app/data_layer/models/appointment_models/appointment_model.dart';
import 'package:healtether_clinic_app/utils/enums/route_enums.dart';
import 'package:healtether_clinic_app/utils/extensions.dart/string_extensions.dart';
import 'package:healtether_clinic_app/utils/extensions.dart/widget_extensions.dart';
import 'package:healtether_clinic_app/utils/helper_functions/log.dart';
import 'package:healtether_clinic_app/widgets/buttons/my_elevated_icon_button.dart';
import 'package:healtether_clinic_app/widgets/components/scrollable_row.dart';
import 'package:healtether_clinic_app/widgets/icon_text.dart';
import 'package:url_launcher/url_launcher.dart';

class AppointmentSummaryCard extends StatelessWidget {
  const AppointmentSummaryCard({super.key, required this.appointment});

  final Appointment appointment;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: AppColors.lightAqua,
          borderRadius: BorderRadius.circular(7),
          border: Border.all(color: AppColors.lightGrey)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          //? PATIENT INFO
          buildPatientInfo(),
          const SizedBox(
            height: 8,
          ),
          //? APPOINTMENT INFO
          buildAppointmentInfo().pOnly(top: 8, bottom: 10),

          const SizedBox(
            height: 16,
          ),

          ScrollableRow(
            height: 34,
            children: [
              //? CHAT
              MyElevatedIconButton(
                text: "Chat",
                icon: AppIcons.whatsapp,
                onPressed: () {
                  log("navigate to chat");
                  context.pushNamed(AppRoutes.chatDetails.name);
                },
              ),

              const SizedBox(width: 8),

              //? CHAT
              MyElevatedIconButton(
                text: "Call",
                icon: AppIcons.call,
                textStyle: const TextStyle(color: AppColors.eerieBlack),
                backgroundColor: Colors.white,
                onPressed: () {
                  log("call patient");

                  launchUrl(Uri.parse('tel:+2341234567890'));
                },
              ),

              const SizedBox(width: 8),

              //? CHAT
              MyElevatedIconButton(
                text: "View bills",
                icon: AppIcons.bill,
                textStyle: const TextStyle(color: AppColors.eerieBlack),
                backgroundColor: Colors.white,
                onPressed: () {
                  log("navigate to view bills page");
                },
              )
            ],
          )
        ],
      ),
    );
  }

  Widget buildAppointmentInfo() {
    return Column(
      children: [
        //? TIME SLOT
        IconText(leading: AppIcons.clock, title: "${appointment.timeSlot}"),

        const SizedBox(
          height: 8,
        ),

        //? ATTENDING DOCTOR
        IconText(
            leading: AppIcons.stethoscope, title: "${appointment.doctorName}"),
      ],
    );
  }

  Widget buildPatientInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //? PATIENT ID
        Text(
          "PATIENT ID - ${appointment.getPatientId}",
          style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              height: 16.8 / 14,
              color: AppColors.deepAqua),
        ),

        //? PATIENT NAME
        Text(
          appointment.name!,
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, height: 24 / 20),
        ).pSymmetric(horizontal: 0, vertical: 4),

        //? PATIENT AGE AND GENDER
        Text(
          "${appointment.age} ${appointment.age == 1 ? 'yr' : 'yrs'} old, ${appointment.gender?.capitalize}",
          style: GoogleFonts.urbanist(
              textStyle: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  height: 17.36 / 14)),
        ).pOnly(bottom: 10),
      ],
    );
  }
}
