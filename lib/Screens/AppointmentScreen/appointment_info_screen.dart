/*import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healtether_clinic_app/Screens/AppointmentScreen/widgets/cancel_appoinments.dart';
import 'package:healtether_clinic_app/Screens/AppointmentScreen/widgets/re_schedule_appointment.dart';
import 'package:healtether_clinic_app/Screens/AppointmentScreen/widgets/time_line_item_screen.dart';
import 'package:healtether_clinic_app/Screens/ChatScreen/chat_detailes_screen.dart';
import 'package:healtether_clinic_app/constants/constants.dart';
import 'package:healtether_clinic_app/data_layer/models/appointment_models/appointment_model.dart';
import 'package:healtether_clinic_app/data_layer/models/patient_records_model/patient_model.dart';
import 'package:intl/intl.dart';
import 'widgets/schedule_follow_up.dart';

class AppointmentInfoScreen extends StatefulWidget {
  final Appointment appointmentResponse;

  const AppointmentInfoScreen({Key? key, required this.appointmentResponse})
      : super(key: key);

  @override
  State<AppointmentInfoScreen> createState() => _AppointmentInfoScreenState();
}

class _AppointmentInfoScreenState extends State<AppointmentInfoScreen> {
  late PatientOverviewModel patient;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: -4,
        surfaceTintColor: AppColors.whiteColor,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back),
            ),
            Text(
              'Appointments',
              style: GoogleFonts.urbanist(
                  fontWeight: FontWeight.w500, fontSize: 20),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xffF5F5F5),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppointmentInfo(appointmentResponse: widget.appointmentResponse),
              Container(
                color: Colors.white,
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  backgroundColor: Colors.transparent,
                                  context: context,
                                  builder: (BuildContext context) {
                                    return const ScheduleFollowUp();
                                  },
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: AppColors.white1Color,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Text(
                                      "Follow-up",
                                      style: GoogleFonts.urbanist(
                                        textStyle: const TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xff928F9E),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 6),
                            InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                  backgroundColor: Colors.transparent,
                                  context: context,
                                  builder: (BuildContext context) {
                                    return const CancelAppointment();
                                  },
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: AppColors.white1Color,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Text(
                                      "Cancel Appointment",
                                      style: GoogleFonts.urbanist(
                                        textStyle: const TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xff928F9E)),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 6),
                            InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                  backgroundColor: Colors.transparent,
                                  context: context,
                                  builder: (BuildContext context) {
                                    return const ReScheduleAppointment();
                                  },
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: AppColors.white1Color,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Text(
                                      "Reschedule",
                                      style: GoogleFonts.urbanist(
                                        textStyle: const TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xff928F9E)),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Text(
                      'APPOINTMENTS LOG',
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    const GreenLine(),
                  ],
                ),
              ),
              const TimelineItem(
                date: '23 July 2023',
                description:
                    'Appointment of 25 July, 2023 at 6:30pm in the evening has been cancelled.',
              ),
              const TimelineItem(
                date: '23 July 2023',
                description:
                    'Appointment of 12 July, 2023 is rescheduled as of 25 July 2023 at 6:30pm in the evening.',
              ),
              const TimelineItem(
                date: '10 July 2023',
                description:
                    'Follow-up appointment scheduled on 12 July,2023 at 3:20pm in the afternoon.',
              ),
              const TimelineItem(
                date: '05 July 2023',
                description:
                    'Appointment scheduled on 10July,2023 at 3:20pm in the afternoon.',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AppointmentInfo extends StatefulWidget {
  final Appointment appointmentResponse;

  const AppointmentInfo({Key? key, required this.appointmentResponse})
      : super(key: key);

  @override
  State<AppointmentInfo> createState() => _AppointmentInfoState();
}

class _AppointmentInfoState extends State<AppointmentInfo> {
  int _selectedIndex = 0;
  bool isSelected = false;
  late PatientOverviewModel patient;

  String formatDate(String dateString) {
    try {
      DateTime dateTime = DateTime.parse(dateString);
      return DateFormat('d MMM yy').format(dateTime);
    } catch (e) {
      return 'Invalid date';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: const BoxDecoration(
          color: Color(0xFFC9F0E5),
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'PATIENT ID - 103456',
                        style: GoogleFonts.urbanist(
                          textStyle: const TextStyle(
                              // fontFamily: "Poppins",
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff1B9C85)),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.appointmentResponse.name.toString(),
                        style: GoogleFonts.urbanist(
                          textStyle: const TextStyle(
                            // fontFamily: "Poppins",
                            fontSize: 20,
                            color: Color(0xff000000),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "34, Female",
                        style: GoogleFonts.urbanist(
                          textStyle: const TextStyle(
                            // fontFamily: "Poppins",
                            fontSize: 14,
                            color: Color(0xff000000),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          const Icon(
                            Icons.access_alarm,
                            size: 18,
                            color: Color(0xff413D56),
                          ),
                          // SvgPicture.asset(
                          //   'assets/homeimages/Vector (11).svg',
                          //   color: Colors.black,
                          // ),
                          const SizedBox(width: 10),
                          Text(
                            widget.appointmentResponse.timeSlot.toString(),
                            style: GoogleFonts.urbanist(
                              textStyle: const TextStyle(
                                // fontFamily: "Poppins",
                                fontSize: 17,
                                color: Color(0xff0F0B28),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Image.asset(
                            'assets/homeimages/stethscope.png',
                            height: 18,
                            width: 18,
                            color: const Color(0xff413D56),
                          ),
                          // SvgPicture.asset(
                          //   'assets/homeimages/Vector (12).svg',
                          //   color: Colors.black,
                          // ),
                          const SizedBox(width: 10),
                          Text(
                            "Dr. ${widget.appointmentResponse.doctorName.toString()}",
                            style: GoogleFonts.urbanist(
                              textStyle: const TextStyle(
                                // fontFamily: "Poppins",
                                fontSize: 17,
                                color: Color(0xff0F0B28),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  // Column(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     Padding(
                  //       padding: const EdgeInsets.only(left: 90),
                  //       child: Text(
                  //         'SLOT -2',
                  //         style: GoogleFonts.montserrat(
                  //           fontSize: 14,
                  //           fontWeight: FontWeight.w600,
                  //           color: AppColors.blueeColor,
                  //         ),
                  //       ),
                  //     ),
                  //     const SizedBox(height: 8),
                  //      Padding(
                  //        padding: const EdgeInsets.only(left: 90),
                  //        child: Text(
                  //          formatDate( widget.appointmentResponse.appointmentDate.toString()),
                  //         style: const TextStyle(
                  //           fontFamily: "Poppins",
                  //           fontSize: 14,
                  //           color: Colors.grey,
                  //           fontWeight: FontWeight.w600,
                  //         ),
                  //                          ),
                  //      ),
                  //   ],
                  // ),
                ],
              ),
              // const SizedBox(height: 16),
              // Column(
              //   children: [
              //     Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Text(
              //           widget.appointmentResponse.name.toString(),
              //           style: const TextStyle(
              //             fontFamily: "Poppins",
              //             fontSize: 23,
              //             color: AppColors.blueeColor,
              //             fontWeight: FontWeight.w500,
              //           ),
              //         ),
              //         Row(
              //           children: [
              //             IconButton(onPressed: () {
              //               Navigator.push(context, MaterialPageRoute(builder: (context) {
              //                 return  PatientRecordsScreen(
              //                   patient: patient,
              //                   // data: Data(),
              //                 );
              //               }));
              //             }, icon: const Icon(Icons.info_outline))
              //           ],
              //         ),
              //       ],
              //     ),
              //   ],
              // ),
              // const SizedBox(height: 8),
              //  Row(
              //   children: [
              //     Expanded(
              //       child: Text(
              //         widget.appointmentResponse.mobile.toString(),
              //         style: const TextStyle(
              //           fontFamily: "Poppins",
              //           fontSize: 14,
              //           color: Colors.black,
              //           fontWeight: FontWeight.w400,
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InfoButton(
                    image: Image.asset(
                      "assets/homeimages/whatsapp.png",
                      width: 30,
                      height: 30,
                      color: _selectedIndex == 2 ? Colors.white : null,
                    ),
                    text: 'Chat',
                    isSelected: _selectedIndex == 2,
                    onTap: () {
                      setState(() {
                        _selectedIndex = 2;
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChatDetailScreen()),
                      );
                    },
                  ),
                  const SizedBox(width: 6),
                  InfoButton(
                    icon: Icons.call,
                    text: 'Call',
                    isSelected: _selectedIndex == 0,
                    onTap: () {
                      setState(() {
                        _selectedIndex = 0;
                      });
                    },
                  ),
                  const SizedBox(width: 6),
                  InfoButton(
                    image: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: SvgPicture.asset(
                        "assets/homeimages/Vector (18).svg",
                        width: 14,
                        height: 14,
                        color: _selectedIndex == 1 ? Colors.white : null,
                      ),
                    ),
                    text: 'View bills',
                    isSelected: _selectedIndex == 1,
                    onTap: () {
                      setState(() {
                        _selectedIndex = 1;
                      });
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class GreenLine extends StatelessWidget {
  const GreenLine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 2,
      width: 47,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color(0xFF52CFAC),
      ),
    );
  }
}

class InfoButton extends StatelessWidget {
  final IconData? icon;
  final Widget? image;
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const InfoButton({
    super.key,
    this.icon,
    this.image,
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 40,
          decoration: BoxDecoration(
            color: isSelected ? AppColors.greenColor : Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null)
                Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Icon(
                    icon,
                    color: isSelected ? Colors.white : Colors.black,
                  ),
                )
              else if (image != null)
                Container(
                  width: 30,
                  height: 30,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: image!,
                ),
              Text(
                text,
                style: GoogleFonts.urbanist(
                  textStyle: TextStyle(
                    fontSize: 14,
                    color: isSelected ? Colors.white : Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}*/
