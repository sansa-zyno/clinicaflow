import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:clinica_flow/features/appointment/viewmodel/appointment_cubit.dart';
import 'package:clinica_flow/features/appointment/model/appointment_model.dart';
// import 'package:clinica_flow/Screens/AppointmentScreen/widgets/custom_textfield.dart';
// import 'package:clinica_flow/data_layer/models/appointment_models/appointment_log.dart';
import 'package:clinica_flow/core/utils/helper_models/schedule_helper.dart';
import 'package:clinica_flow/core/constants/app_icons.dart';
import 'package:clinica_flow/core/utils/enums/bloc_enums.dart';
import 'package:clinica_flow/core/utils/extensions.dart/widget_extensions.dart';
import 'package:clinica_flow/core/utils/helper_functions/log.dart';
import 'package:clinica_flow/core/utils/mixins/app_bar_mixin.dart';
import 'package:clinica_flow/core/utils/mixins/ui_info_mixin.dart';
import 'package:clinica_flow/shared/widgets/appointment_log_item.dart';
import 'package:clinica_flow/shared/widgets/buttons/my_elevated_button.dart';
// import 'package:clinica_flow/widgets/buttons/my_selectable_container.dart';
import 'package:clinica_flow/shared/widgets/components/appointment_summary_card.dart';
import 'package:clinica_flow/core/constants/app_colors.dart';
import 'package:clinica_flow/shared/widgets/components/cancel_appointment_dialog.dart';
import 'package:clinica_flow/shared/widgets/components/my_schedule_dialog.dart';
import 'package:clinica_flow/shared/widgets/components/scrollable_row.dart';
import 'package:clinica_flow/shared/widgets/section_text.dart';
// import 'package:intl/intl.dart';

class AppointmentDetail extends StatefulWidget {
  final String id;
  const AppointmentDetail({required this.id, super.key});

  @override
  State<AppointmentDetail> createState() => _AppointmentDetailState();
}

class _AppointmentDetailState extends State<AppointmentDetail>
    with AppBarMixin, UiInfoMixin {
  //Appointment get appointment => SampleObjects.appointmentResponseObject;
  //Appointment get appointment => widget.appointment;

  // late TextEditingController followUpTimeController;

  final followUpSchedule = ScheduleHelper();
  final rescheduleFollowUpSchedule = ScheduleHelper();
  final cancelAppointmentSchedule = ScheduleHelper();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<AppointmentCubit>().getAppointmentById(id: widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: buildAppBar(
          context,
          title: 'Appointments',
        ),
        body: BlocBuilder<AppointmentCubit, AppointmentState>(
            builder: (context, state) {
          if (state.state == AppointmentStates.fetchingAppointmentById) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.state ==
              AppointmentStates.fetchingAppointmentByIdFailed) {
            return const Center(
                child: Text('Error fetching appointment details'));
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 7,
                ),

                //? APPOINTMENT SUMMARY CARD
                AppointmentSummaryCard(appointment: state.appointmentDetails!)
                    .pSymmetric(),

                //? ACTIONS
                ScrollableRow(children: [
                  const SizedBox(width: 16),

                  //? FOLLOW UP
                  MyElevatedButton(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 12),
                      text: "Follow up",
                      textStyle: const TextStyle(color: AppColors.lightGrey2),
                      onPressed: () =>
                          followUp(context, state.appointmentDetails!),
                      backgroundColor: AppColors.whiteSmoke),

                  const SizedBox(width: 8),
                  //? CANCEL APPOINTMENT
                  MyElevatedButton(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 12),
                      text: "Cancel Appointment",
                      textStyle: const TextStyle(color: AppColors.lightGrey2),
                      onPressed: () =>
                          cancelAppointment(state.appointmentDetails!),
                      backgroundColor: AppColors.whiteSmoke),
                  const SizedBox(width: 8),
                  //? RESCHEDULE
                  MyElevatedButton(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 12),
                      text: "Reschedule",
                      textStyle: const TextStyle(color: AppColors.lightGrey2),
                      onPressed: () =>
                          rescheduleAppointment(state.appointmentDetails!),
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
                    itemCount:
                        state.appointmentDetails!.appointmentLogs?.length ?? 0,
                    itemBuilder: (BuildContext context, int index) {
                      final appointmentLog =
                          state.appointmentDetails!.appointmentLogs![index];
                      return AppointmentLogItem(appointmentLog: appointmentLog)
                          .pOnly(left: 16, right: 16, bottom: 16);
                    },
                  ),
                ),

                const SizedBox(
                  height: 24,
                ),
              ],
            );
          }
        }),
      ),
    );
  }

  void followUp(BuildContext context, Appointment appointment) {
    showModalBottomSheet(
        context: context,
        constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height / 1.91),
        //shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16))),
        builder: (BuildContext context) {
          return MyScheduleDialog(
            type: 'followup',
            appointment: appointment,
            title: const SectionText("SCHEDULE FOLLOW-UP"),
            dateTitle: "Follow-up date",
            schedule: followUpSchedule,
            onExit: context.pop,
          );
        });
  }

  void cancelAppointment(Appointment appointment) {
    log("Cancel appointment");
    showModalBottomSheet(
        context: context,
        constraints:
            BoxConstraints(maxHeight: MediaQuery.of(context).size.height / 3),
        builder: (BuildContext context) {
          return CancelAppointmentDialog(
            schedule: cancelAppointmentSchedule,
            appointment: appointment,
          );
        });
  }

  void rescheduleAppointment(Appointment appointment) {
    log("Reschedule appointment");
    showModalBottomSheet(
        context: context,
        constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height / 1.91),
        builder: (BuildContext context) {
          return MyScheduleDialog(
            type: 'reschedule',
            appointment: appointment,
            title: const SectionText("RESCHEDULE APPOINTMENT"),
            dateTitle: "Set up a date",
            schedule: rescheduleFollowUpSchedule,
            onExit: context.pop,
          );
        });
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
