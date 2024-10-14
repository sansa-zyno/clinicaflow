import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healtether_clinic_app/data_layer/models/appointment_models/appointment_model.dart';
// import 'package:healtether_clinic_app/Screens/AppointmentScreen/widgets/custom_textfield.dart';
// import 'package:healtether_clinic_app/data_layer/models/appointment_models/appointment_log.dart';

import 'package:healtether_clinic_app/data_layer/models/helper_models/schedule_helper.dart';
import 'package:healtether_clinic_app/data_layer/sample_objects/sample_objects.dart';
import 'package:healtether_clinic_app/constants/app_icons.dart';
import 'package:healtether_clinic_app/utils/extensions.dart/widget_extensions.dart';
import 'package:healtether_clinic_app/utils/helper_functions/log.dart';
import 'package:healtether_clinic_app/utils/mixins/app_bar_mixin.dart';
import 'package:healtether_clinic_app/utils/mixins/ui_info_mixin.dart';
import 'package:healtether_clinic_app/widgets/appointment_log_item.dart';
import 'package:healtether_clinic_app/widgets/buttons/my_elevated_button.dart';
// import 'package:healtether_clinic_app/widgets/buttons/my_selectable_container.dart';
import 'package:healtether_clinic_app/widgets/components/appointment_summary_card.dart';
import 'package:healtether_clinic_app/constants/constants.dart';
import 'package:healtether_clinic_app/widgets/components/cancel_appointment_dialog.dart';
import 'package:healtether_clinic_app/widgets/components/my_schedule_dialog.dart';
import 'package:healtether_clinic_app/widgets/components/scrollable_row.dart';
import 'package:healtether_clinic_app/widgets/section_text.dart';
// import 'package:intl/intl.dart';

class AppointmentDetail extends StatefulWidget {
  const AppointmentDetail({super.key});

  @override
  State<AppointmentDetail> createState() => _AppointmentDetailState();
}

class _AppointmentDetailState extends State<AppointmentDetail>
    with AppBarMixin, UiInfoMixin {
  Appointment get appointment => SampleObjects.appointmentResponseObject;

  // late TextEditingController followUpTimeController;

  final followUpSchedule = ScheduleHelper();
  final rescheduleFollowUpSchedule = ScheduleHelper();
  final cancelAppointmentSchedule = ScheduleHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context,
          title: 'Appointments', automaticallyImplyLeading: true),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 7,
          ),

          //? APPOINTMENT SUMMARY CARD
          AppointmentSummaryCard(appointment: appointment).pSymmetric(),

          //? ACTIONS
          ScrollableRow(children: [
            const SizedBox(width: 16),

            //? FOLLOW UP
            MyElevatedButton(
                text: "Follow up",
                textStyle: const TextStyle(color: AppColors.lightGrey2),
                onPressed: () => followUp(context),
                backgroundColor: AppColors.whiteSmoke),

            const SizedBox(width: 8),

            //? RESCHEDULE
            MyElevatedButton(
                text: "Reschedule",
                textStyle: const TextStyle(color: AppColors.lightGrey2),
                onPressed: rescheduleAppointment,
                backgroundColor: AppColors.whiteSmoke),

            const SizedBox(width: 8),

            //? CANCEL APPOINTMENT
            MyElevatedButton(
                text: "Cancel Appointment",
                textStyle: const TextStyle(color: AppColors.lightGrey2),
                onPressed: cancelAppointment,
                backgroundColor: AppColors.whiteSmoke),

            const SizedBox(width: 16)
          ]).pOnly(top: 16, bottom: 16),

          //? APPOINTMENT LOGS
          const SectionText(
            "APPOINTMENTS LOG",
          ).pSymmetric(),

          const SizedBox(height: 12),

          //? LISTVIEW OF APPOINTMENTS LOG
          Expanded(
            child: ListView.builder(
              itemCount: appointment.appointmentLogs?.length ?? 0,
              itemBuilder: (BuildContext context, int index) {
                final appointmentLog = appointment.appointmentLogs![index];

                return AppointmentLogItem(appointmentLog: appointmentLog)
                    .pOnly(left: 16, right: 16, bottom: 16);
              },
            ),
          ),

          const SizedBox(
            height: 24,
          ),
        ],
      ),
    );
  }

  void followUp(BuildContext context) {
    log("Follow up");
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return MyScheduleDialog(
            title: const SectionText("SCHEDULE FOLLOW-UP"),
            schedule: followUpSchedule,
            // followUpTimeController: followUpTimeController,
            // onDone: () {

            //   context.pop();
            // },
            onExit: context.pop, dateTitle: "Follow-up date",
          );
        });
  }

  void cancelAppointment() {
    log("Cancel appointment");
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CancelAppointmentDialog(schedule: cancelAppointmentSchedule);
        });
  }

  void rescheduleAppointment() {
    log("Reschedule appointment");
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return MyScheduleDialog(
            title: const SectionText("RESCHEDULE FOLLOW-UP"),
            schedule: rescheduleFollowUpSchedule,
            // onDone: () {
            //   log(rescheduleFollowUpSchedule.toMap());
            //   context.pop();
            // },
            onExit: context.pop,
            dateTitle: "Set up a date",
          );
        });
  }

  void scheduleFollowUp() {
    print("Scheduling follow up...");
  }
}

class SectionText2 extends StatelessWidget {
  const SectionText2(
    this.text, {
    super.key,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.roboto(
          textStyle: const TextStyle(
              fontWeight: FontWeight.w500, fontSize: 16, height: 22.08 / 16)),
    );
  }
}

class MyCloseIconButton extends StatelessWidget {
  const MyCloseIconButton({super.key, this.onPressed, this.showShadow = true});
  final bool showShadow;

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed ?? context.pop,
      child: Container(
        width: 28,
        height: 28,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            border: Border.all(color: AppColors.darkBlueViolet),
            color: Colors.white,
            boxShadow: !showShadow
                ? null
                : [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        blurRadius: 4,
                        offset: const Offset(0, 4))
                  ]),
        child: AppIcons.close,
      ),
    );
  }
}
