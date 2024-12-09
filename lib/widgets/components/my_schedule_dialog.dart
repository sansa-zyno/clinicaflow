import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healtether_clinic_app/Screens/AppointmentScreen/appointment_detail.dart';
import 'package:healtether_clinic_app/Screens/AppointmentScreen/widgets/custom_textfield.dart';
import 'package:healtether_clinic_app/Screens/ScheduleAppointment/timeslot_gridview.dart';
import 'package:healtether_clinic_app/business_logic/cubits/appointment_cubit/appointment_cubit.dart';
import 'package:healtether_clinic_app/data_layer/models/appointment_models/appointment_model.dart';
import 'package:healtether_clinic_app/data_layer/models/helper_models/schedule_helper.dart';
import 'package:healtether_clinic_app/constants/app_colors.dart';
import 'package:healtether_clinic_app/data_layer/services/appointment_service/appointment_service.dart';
import 'package:healtether_clinic_app/utils/enums/bloc_enums.dart';
import 'package:healtether_clinic_app/utils/mixins/ui_info_mixin.dart';
import 'package:healtether_clinic_app/utils/snackbar.dart';
import 'package:healtether_clinic_app/widgets/buttons/my_elevated_button.dart';
import 'package:healtether_clinic_app/widgets/buttons/my_selectable_container.dart';
// import 'package:healtether_clinic_app/widgets/section_text.dart';

class MyScheduleDialog extends StatefulWidget {
  const MyScheduleDialog(
      {super.key,
      required this.type,
      required this.title,
      required this.schedule,
      required this.dateTitle,
      required this.appointment,
      // required this.onDone,
      required this.onExit});

  final String type;
  final ScheduleHelper schedule;
  final Widget title;
  final String? dateTitle;
  final Appointment appointment;
  // final void Function() onDone;
  final void Function() onExit;

  @override
  State<MyScheduleDialog> createState() => _MyScheduleDialogState();
}

class _MyScheduleDialogState extends State<MyScheduleDialog> with UiInfoMixin {
  late final TextEditingController timeController;
  Map? selectedDoctor;
  DateTime? newAppointmentDateTime;

  @override
  void initState() {
    super.initState();
    timeController = TextEditingController(text: widget.appointment.timeSlot ?? '');
    fetchDoctorWithTimeSlots();
    newAppointmentDateTime = DateTime.parse(widget.appointment.appointmentDate!);
  }

  fetchDoctorWithTimeSlots() async {
    List<Map<String, dynamic>>? doctors = await AppointmentServices().fetchDoctorsWithTimeSlots();
    selectedDoctor = doctors.where((element) => '${element['firstName']} ${element['lastName']}' == widget.appointment.doctorName!).toList()[0];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, setState) {
      return BlocListener<AppointmentCubit, AppointmentState>(
        listener: (context, state) {
          if (state.state == AppointmentStates.appointmentFollowedup) {
            showSnackbar("Appointment followup completed successfully", context);
            context.read<AppointmentCubit>().getAppointmentById(id: widget.appointment.id!).then((value) {
              if (context.read<AppointmentCubit>().state.state == AppointmentStates.appointmentByIdFetched) {
                context.read<AppointmentCubit>().fetchAppointments(status: 'Upcoming');
              }
            });
            context.pop();
          } else if (state.state == AppointmentStates.appointmentRescheduled) {
            showSnackbar("Appointment reschedule completed successfully", context);
            context.read<AppointmentCubit>().getAppointmentById(id: widget.appointment.id!).then((value) {
              if (context.read<AppointmentCubit>().state.state == AppointmentStates.appointmentByIdFetched) {
                context.read<AppointmentCubit>().fetchAppointments(status: 'Upcoming');
              }
            });
            context.pop();
          } else {}
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widget.title,
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                // height: 300,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      //? FOLLOW UP DATE
                      if (widget.dateTitle != null) SectionText2(widget.dateTitle!),

                      const SizedBox(
                        height: 8,
                      ),

                      // dates
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: List<Widget>.generate(widget.schedule.durations.length, (index) {
                          final duration = widget.schedule.durations[index];

                          return SelectableContainer(
                            width: 110,
                            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                            title: Text(duration,
                                style: GoogleFonts.urbanist(
                                    textStyle: const TextStyle(
                                  color: AppColors.eerieBlack,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  height: 23.12 / 17,
                                ))),
                            selectedTitle: Text(
                              duration,
                              style: GoogleFonts.urbanist(
                                  textStyle: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                height: 23.12 / 17,
                              )),
                            ),
                            selected: duration == widget.schedule.selectedDuration,
                            onTap: () async {
                              final durationsLength = widget.schedule.durations.length;

                              // if last item was pressed OR the first item when
                              // the list is 5 items was pressed.
                              print((index == 0 && durationsLength == 5));
                              if (index != durationsLength - 1) {
                                switch (duration) {
                                  case 'None':
                                    newAppointmentDateTime = DateTime.parse(widget.appointment.appointmentDate!);
                                    break;
                                  case 'After 3 days':
                                    newAppointmentDateTime = DateTime.parse(widget.appointment.appointmentDate!).add(Duration(days: 3));
                                    break;
                                  case 'After a week':
                                    newAppointmentDateTime = DateTime.parse(widget.appointment.appointmentDate!).add(Duration(days: 7));
                                    break;
                                  default:
                                    List<String> dateParts = duration.split('-');
                                    int day = int.parse(dateParts[0]);
                                    int month = int.parse(dateParts[1]);
                                    int year = int.parse(dateParts[2]);
                                    newAppointmentDateTime = DateTime(year, month, day);
                                    break;
                                }
                                setState(() {
                                  widget.schedule.selectedDuration = duration;
                                });
                              } else {
                                DateTime? date = await pickDate(context, returnDateObject: true);
                                if (date != null) {
                                  if (widget.schedule.durations.length > 4) {
                                    widget.schedule.durations[0] =
                                        '${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}';
                                    newAppointmentDateTime = date;
                                  } else {
                                    widget.schedule.durations
                                        .insert(0, '${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}');
                                    newAppointmentDateTime = date;
                                  }
                                  setState(() {
                                    widget.schedule.selectedDuration =
                                        '${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}';
                                  });
                                }
                              }
                            },
                          );
                        }),
                      ),

                      const SizedBox(height: 24),

                      //? SELECT TIME

                      Row(
                        children: [
                          const Expanded(child: SectionText2("Time")),
                          const SizedBox(
                            width: 16,
                          ),
                          Expanded(
                              flex: 2,
                              child: CustomTextField(
                                controller: timeController,
                                hintText: "Select",
                                readOnly: true,
                                onTap: () async {
                                  if (selectedDoctor != null && newAppointmentDateTime != null) {
                                    await showModalBottomSheet(
                                        context: context,
                                        builder: (ctx) => TimeSlotGridView(
                                            availableTimeSlots: List<Map<String, dynamic>>.from(selectedDoctor!['availableTimeSlot']),
                                            appointmentDate: newAppointmentDateTime,
                                            onSelected: (timeSlot) {
                                              setState(() {
                                                timeController.text = timeSlot;
                                                widget.schedule.selectedTimeSlot = timeSlot;
                                              });
                                            }));
                                  }
                                },
                                suffixIcon: const Icon(Icons.arrow_drop_down),
                                height: 54,
                              ))
                        ],
                      ),

                      const SizedBox(
                        height: 16,
                      ),

                      //? DONE | EXIT
                      BlocBuilder<AppointmentCubit, AppointmentState>(builder: (context, state) {
                        if (state.state == AppointmentStates.reschedulingAppointment || state.state == AppointmentStates.followingupAppointment) {
                          return const SizedBox(height: 50, child: Center(child: CircularProgressIndicator()));
                        } else {
                          return Row(children: [
                            Expanded(
                                child: MyElevatedButton(
                              text: 'Exit',
                              height: 54,
                              onPressed: widget.onExit,
                              backgroundColor: AppColors.whiteSmoke,
                              textStyle: const TextStyle(color: AppColors.eerieBlack),
                            )),
                            const SizedBox(width: 16),
                            Expanded(
                                child: MyElevatedButton(
                                    text: 'Done',
                                    height: 54,
                                    onPressed: () async {
                                      if (widget.type == 'followup') {
                                        context.read<AppointmentCubit>().followupAppointment(
                                            id: widget.appointment.id!,
                                            appointmentDate: newAppointmentDateTime!.toIso8601String(),
                                            timeSlot: timeController.text);
                                      } else {
                                        context.read<AppointmentCubit>().reScheduleAppointment(
                                            id: widget.appointment.id!,
                                            appointmentDate: newAppointmentDateTime!.toIso8601String(),
                                            timeSlot: timeController.text);
                                      }
                                    })),
                          ]);
                        }
                      }),

                      const SizedBox(height: 16),

                      //? NOTIFY PATIENT ON WHATSAPP
                      NotifyPatientCheckboxTile(
                          onChanged: (value) {
                            if (value != null) {
                              setState(() {
                                // widget.schedule.notifyOnWhatsapp = value;
                              });
                            }
                          },
                          checkboxValue: true)
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}

class NotifyPatientCheckboxTile extends StatelessWidget {
  const NotifyPatientCheckboxTile({
    super.key,
    required this.onChanged,
    required this.checkboxValue,
  });

  final void Function(bool? value) onChanged;
  final bool checkboxValue;
  @override
  Widget build(BuildContext context) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      // Checkbox.adaptive(
      //     value: checkboxValue,
      //     activeColor: AppColors.primaryColor,
      //     onChanged: onChanged),

      // text
      Expanded(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Notify patient on whatsapp",
                style: GoogleFonts.roboto(textStyle: const TextStyle(fontSize: 16, color: AppColors.grey, height: 22.08 / 16))),
            const SizedBox(
              height: 4,
            ),
            Text(
              "This would automatically send a reminder to the patient's whatsapp 20hrs to visit again.",
              style:
                  GoogleFonts.roboto(textStyle: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: AppColors.grey, height: 14.3 / 11)),
            )
          ],
        ),
      )
    ]);
  }
}
