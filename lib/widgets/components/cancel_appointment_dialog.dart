import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healtether_clinic_app/Screens/AppointmentScreen/appointment_detail.dart';
import 'package:healtether_clinic_app/data_layer/models/helper_models/schedule_helper.dart';
import 'package:healtether_clinic_app/constants/app_colors.dart';
import 'package:healtether_clinic_app/utils/extensions.dart/widget_extensions.dart';
import 'package:healtether_clinic_app/utils/helper_functions/log.dart';
import 'package:healtether_clinic_app/widgets/buttons/my_elevated_button.dart';
import 'package:healtether_clinic_app/widgets/components/my_schedule_dialog.dart';

class CancelAppointmentDialog extends StatelessWidget {
  const CancelAppointmentDialog({super.key, required this.schedule});

  final ScheduleHelper schedule;

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (BuildContext context, setState) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionText2("Do you want to cancel scheduled appointment?").pOnly(right: 50),
              const SizedBox(
                height: 8,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // description
                  Text(
                    "The appointment history would be deleted permanently",
                    style: GoogleFonts.roboto(
                        textStyle: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      color: Color(0xff686868),
                    )),
                  ),

                  const SizedBox(height: 16),

                  // actions
                  Row(
                    children: [
                      Expanded(
                        child: MyElevatedButton(
                          text: "No",
                          onPressed: context.pop,
                          height: 54,
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: MyElevatedButton(
                          text: "Yes",
                          height: 54,
                          textStyle: const TextStyle(color: AppColors.eerieBlack),
                          backgroundColor: AppColors.whiteSmoke,
                          onPressed: () {
                            log("Cancel appointment");
                            log(schedule.toMap());
                            context.pop(true);
                          },
                        ),
                      )
                    ],
                  ),

                  const SizedBox(height: 16),

                  NotifyPatientCheckboxTile(
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            schedule.cancelAppointment = value;
                          });
                        }
                      },
                      checkboxValue: schedule.cancelAppointment)
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
