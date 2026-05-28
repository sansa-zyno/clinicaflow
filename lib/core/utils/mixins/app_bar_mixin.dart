import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:clinica_flow/core/constants/app_colors.dart';
import 'package:clinica_flow/core/utils/helper_functions/log.dart';

mixin AppBarMixin {
  PreferredSizeWidget buildAppBar(BuildContext context,
      {required String title,
      void Function()? onLeadingPressed,
      final List<Widget>? actions,
      bool showDefaultActions = false,
      Color? backgroundColor,
      double? leadingWidth,
      Widget? leading}) {
    return AppBar(
        leadingWidth: leadingWidth,
        leading: GestureDetector(
          onTap: onLeadingPressed ??
              () {
                log("pop context");
                context.pop();
              },
          child: leading ?? const Icon(Icons.arrow_back),
        ),
        surfaceTintColor: AppColors.whiteColor,
        backgroundColor: backgroundColor,
        title: Text(
          title,
          style:
              GoogleFonts.urbanist(fontWeight: FontWeight.w500, fontSize: 20),
        ),
        actions: showDefaultActions == false
            ? actions
            : [
                // close icon
                /*  const MyCloseIconButton(showShadow: false),

                // pop up menu
                PopupMenuButton<String>(
                  onSelected: (String value) {
                    if (value == 'option_1') {
                      // Handle option 1
                    } else if (value == 'option_2') {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => const ScheduleFollowUp(),
                      );
                    } else if (value == 'option_3') {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => const RescheduleAppointment(),
                      );
                    } else if (value == 'option_4') {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return CancelAppointmentDialog(
                                schedule: ScheduleHelper());
                          });
                    } else if (value == 'option_5') {
                      print("Moving to patients page");

                      context.pushNamed(AppRoutes.patientRecordsScreen.name,
                          extra: patient);
                    }
                  },
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<String>>[
                    PopupMenuItem<String>(
                      value: 'option_1',
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xff5DDCB8),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 8),
                        child: const Row(
                          children: [
                            Text(
                              'Menu',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
                            ),
                            Spacer(),
                            Icon(
                              Icons.cancel,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const PopupMenuItem<String>(
                      value: 'option_2',
                      child: ListTile(
                        title: Text(
                          'Schedule Follow-up',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                      ),
                    ),
                    const PopupMenuItem<String>(
                      value: 'option_3',
                      child: ListTile(
                        title: Text(
                          'Reschedule Appointment',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                      ),
                    ),
                    const PopupMenuItem<String>(
                      value: 'option_4',
                      child: ListTile(
                        title: Text(
                          'Cancel Appointment',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                      ),
                    ),
                    const PopupMenuItem<String>(
                      value: 'option_5',
                      child: ListTile(
                        title: Text(
                          'View Patient Details',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 5,
                ),*/
              ]);
  }
}
