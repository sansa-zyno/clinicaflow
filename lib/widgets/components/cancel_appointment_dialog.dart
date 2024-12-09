import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healtether_clinic_app/Screens/AppointmentScreen/appointment_detail.dart';
import 'package:healtether_clinic_app/business_logic/cubits/appointment_cubit/appointment_cubit.dart';
import 'package:healtether_clinic_app/data_layer/models/helper_models/schedule_helper.dart';
import 'package:healtether_clinic_app/constants/app_colors.dart';
import 'package:healtether_clinic_app/utils/enums/bloc_enums.dart';
import 'package:healtether_clinic_app/utils/extensions.dart/widget_extensions.dart';
import 'package:healtether_clinic_app/utils/snackbar.dart';
import 'package:healtether_clinic_app/widgets/buttons/my_elevated_button.dart';
import 'package:healtether_clinic_app/widgets/components/my_schedule_dialog.dart';
import '../../data_layer/models/appointment_models/appointment_model.dart';

class CancelAppointmentDialog extends StatelessWidget {
  const CancelAppointmentDialog({
    super.key,
    required this.schedule,
    required this.appointment,
  });

  final ScheduleHelper schedule;
  final Appointment appointment;

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (BuildContext context, setState) {
        return BlocListener<AppointmentCubit, AppointmentState>(
          listener: (context, state) {
            if (state.state == AppointmentStates.appointmentCancelled) {
              showSnackbar("Appointment cancelled successfully", context);
              context.read<AppointmentCubit>().fetchAppointments(status: 'Upcoming');
              context.pop();
              context.pop();
            }
          },
          child: Padding(
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
                    BlocBuilder<AppointmentCubit, AppointmentState>(builder: (context, state) {
                      if (state.state == AppointmentStates.cancellingAppointment) {
                        return const SizedBox(height: 50, child: Center(child: CircularProgressIndicator()));
                      } else {
                        return Row(
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
                                  context.read<AppointmentCubit>().cancellAppointment(id: appointment.id!);
                                },
                              ),
                            )
                          ],
                        );
                      }
                    }),

                    const SizedBox(height: 16),

                    NotifyPatientCheckboxTile(
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              // schedule.cancelAppointment = value;
                            });
                          }
                        },
                        checkboxValue: true)
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
