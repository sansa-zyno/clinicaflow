import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healtether_clinic_app/Screens/AppointmentScreen/appointment_info_screen.dart';
import 'package:healtether_clinic_app/Screens/HomeScreen/drawer_menu.dart';

import 'package:healtether_clinic_app/Screens/patients_records/patients_records.dart';
import 'package:healtether_clinic_app/business_logic/cubits/appointment_cubit/appointment_cubit.dart';
import 'package:healtether_clinic_app/business_logic/cubits/home_page_bottom_nav_cubit/home_page_bottom_nav_cubit.dart';
import 'package:healtether_clinic_app/business_logic/cubits/profile_image_cubit/profile_image_cubit.dart';
import 'package:healtether_clinic_app/data_layer/models/appointment_models/appointment_model.dart';
import 'package:healtether_clinic_app/data_layer/sample_objects/sample_objects.dart';
import 'package:healtether_clinic_app/constants/constants.dart';
import 'package:healtether_clinic_app/utils/enums/bloc_enums.dart';
import 'package:healtether_clinic_app/utils/enums/route_enums.dart';
import 'package:healtether_clinic_app/utils/extensions.dart/string_extensions.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static String getCurrentTimeRange() {
    final now = DateTime.now();

    // Calculate start of the hour
    final startOfDay = DateTime(now.year, now.month, now.day, now.hour);

    // Format start and end times
    final startFormatted = DateFormat('h:mm a').format(startOfDay);
    final endFormatted = DateFormat('h:mm a').format(startOfDay.add(Duration(hours: 1)));

    return '$startFormatted - $endFormatted';
  }

  String selectedDate = getCurrentTimeRange();
  bool isAll = true;

  final List<String> firstText = ["Patient", "Manage", "Payment", "Data"];
  final List<String> secondText = ["Records", "Staff", "Records", "insights"];
  final List<AppRoutes> navigations = [
    // const PatientRecords(),
    AppRoutes.patientRecords,
    // const ManageStaffScreen(),
    AppRoutes.manageStaff,
    // const PaymentsRecordScreen(),
    AppRoutes.paymentRecords,
    // const PatientAnalysis(),
    AppRoutes.patientAnalysis
  ];
  final List<String> images = [
    'assets/homeimages/Vector (1).svg',
    'assets/homeimages/Component 2.svg',
    'assets/homeimages/Component 3.svg',
    'assets/homeimages/trending-up.svg',
  ];

  @override
  void initState() {
    super.initState();
    context.read<HomePageBottomNavCubit>().onPageChanged(0);
  }

  List<String> generateTimeSlots(TimeOfDay startTime, TimeOfDay endTime, Duration interval) {
    final List<String> timeSlots = [];

    final startDate = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, startTime.hour, startTime.minute);
    final endDate = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, endTime.hour, endTime.minute);

    var currentTime = startDate;

    while (currentTime.isBefore(endDate)) {
      final nextTime = currentTime.add(interval);
      timeSlots.add('${DateFormat.jm().format(currentTime)} - ${DateFormat.jm().format(nextTime)}');
      currentTime = nextTime;
    }
    return timeSlots;
  }

  bool isTimeRangeWithin(String range1, String range2) {
    List<int> times1 = _parseTimeRange(range1);
    List<int> times2 = _parseTimeRange(range2);

    return times2[0] >= times1[0] && times2[1] <= times1[1];
  }

  List<int> _parseTimeRange(String range) {
    List<String> parts = range.split(' - ');
    return parts.map((time) => _convertTimeToMinutes(time.trim())).toList();
  }

  int _convertTimeToMinutes(String time) {
    // Remove any leading/trailing whitespace
    time = time.trim().toLowerCase();

    // Split the time string into components
    List<String> components = time.split(RegExp(r'[:\s]'));

    if (components.length != 3) {
      throw FormatException('Invalid time format: $time');
    }

    int hours = int.tryParse(components[0]) ?? 0;
    int minutes = int.tryParse(components[1]) ?? 0;
    String period = components[2];

    if ((period == 'pm' || period == 'PM') && hours != 12) {
      hours += 12;
    } else if ((period == 'am' || period == 'AM') && hours == 12) {
      hours = 0;
    }

    // Handle midnight (12:00 am) as the end of the day
    if (hours == 0 && minutes == 0 && period == 'am') {
      return 24 * 60; // End of the day
    }

    return hours * 60 + minutes;
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );
    BlocProvider.of<AppointmentCubit>(context).fetchAppointments(status: 'Upcoming');
    return SafeArea(
      child: Scaffold(
        body: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            const GreenLine(),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const DrawerMenu()));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          BlocBuilder<ProfileImageCubit, File?>(builder: (context, state) {
                            return CircleAvatar(
                              backgroundImage: state == null ? const AssetImage('assets/homeimages/Ellipse 760 (2).png') : Image.file(state).image,
                              radius: 35,
                            );
                          }),
                          const SizedBox(width: 6),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const PatientRecords(),
                                    ));
                              },
                              child: Container(
                                height: 50,
                                color: const Color(0xffF5F5F5),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  child: Row(children: [
                                    const Icon(Icons.search),
                                    const SizedBox(width: 6),
                                    Expanded(
                                      child: TextField(
                                        decoration: InputDecoration(
                                          hintText: 'Search for patients',
                                          hintStyle: GoogleFonts.montserrat(
                                            color: Colors.grey,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          border: InputBorder.none,
                                        ),
                                      ),
                                      // Padding(
                                      //   padding: const EdgeInsets.all(8.0),
                                      //   child: FittedBox(
                                      //     fit: BoxFit.scaleDown,
                                      //     child: Column(
                                      //       crossAxisAlignment:
                                      //           CrossAxisAlignment.start,
                                      //       children: [
                                      //         Text(
                                      //           'Saturday,1 July',
                                      //           style: GoogleFonts.montserrat(
                                      //               fontSize: 16,
                                      //               color: Colors.black87,
                                      //               fontWeight: FontWeight.w500),
                                      //         ),
                                      //         // Text(
                                      //         //   '1 July, 2023',
                                      //         //   style: GoogleFonts.montserrat(
                                      //         //       fontSize: 14,
                                      //         //       color: Colors.black87,
                                      //         //       fontWeight: FontWeight.w500),
                                      //         // ),
                                      //       ],
                                      //
                                      //     ),
                                      //   ),
                                      // ),
                                    )
                                  ]),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          color: Color(0xff03BF9C),
                        ),
                        width: MediaQuery.of(context).size.width,
                        height: 29,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 16.0),
                              child: Icon(
                                Icons.arrow_back_ios_new_rounded,
                                size: 15,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'May 24',
                              style: GoogleFonts.urbanist(
                                textStyle: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(right: 16.0),
                              child: Icon(
                                Icons.arrow_forward_ios_outlined,
                                size: 14,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: CircularPercentIndicator(
                          radius: 50.0,
                          animation: true,
                          animationDuration: 1200,
                          lineWidth: 10.0,
                          percent: 0.6,
                          center: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "40%",
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
                              ),
                              Text(
                                'done',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
                              )
                            ],
                          ),
                          circularStrokeCap: CircularStrokeCap.butt,
                          progressColor: const Color(0xffE4E0F3),
                          backgroundColor: const Color(0xff03BF9C),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '4/10 patients helped',
                              style: GoogleFonts.urbanist(
                                fontWeight: FontWeight.w600,
                                fontSize: 17,
                                color: const Color(0xff0C091F),
                              ),
                            ),
                            const SizedBox(height: 9),
                            const SmallContainer(
                              color: Color(0xff03BF9C),
                              text: 'Completed',
                            ),
                            const SizedBox(height: 9),
                            const SmallContainer(color: Color(0xffE4E0F3), text: 'Remaining'),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 40,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            DateCards(
                                width: 90,
                                isSelected: isAll,
                                onTap: () {
                                  setState(() {
                                    isAll = true;
                                  });
                                },
                                text: "All",
                                textColor: isAll ? Colors.black : const Color(0xff9E9E9E)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: generateTimeSlots(const TimeOfDay(hour: 6, minute: 0), const TimeOfDay(hour: 24, minute: 0),
                                      const Duration(hours: 1, minutes: 30))
                                  .map((e) => DateCards(
                                        width: 90,
                                        isSelected: isTimeRangeWithin(selectedDate, e) && !isAll,
                                        onTap: () {
                                          setState(() {
                                            isAll = false;
                                            selectedDate = e;
                                          });
                                        },
                                        text: e,
                                        textColor: (isTimeRangeWithin(selectedDate, e) && !isAll) ? Colors.black : const Color(0xff9E9E9E),
                                      ))
                                  .toList(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Upcoming Appointments',
                            style: GoogleFonts.urbanist(
                              textStyle: const TextStyle(
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  context.goNamed(AppRoutes.appointment.name);
                                  // context
                                  //     .read<HomePageBottomNavCubit>()
                                  //     .onPageChanged(1);
                                  // Navigator.pushReplacement(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) {
                                  //       return const HomePageView();
                                  //     },
                                  //   ),
                                  // ).then((_) {
                                  //   Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //       builder: (context) =>
                                  //           const AppointmentScreen(),
                                  //     ),
                                  //   );
                                  // });
                                },
                                child: GestureDetector(
                                  onTap: () {
                                    context.read<HomePageBottomNavCubit>().onPageChanged(1);
                                    context.goNamed(AppRoutes.appointment.name);
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //     builder: (context) =>
                                    //         const AppointmentScreen(),
                                    //   ),
                                    // );
                                  },
                                  child: const Text(
                                    'See All',
                                    style: TextStyle(
                                      color: Color(0xff32856E),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                height: 1,
                                width: screenWidth * 0.14,
                                decoration: const BoxDecoration(
                                  color: Color(0xff32856E),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  BlocBuilder<AppointmentCubit, AppointmentState>(builder: (context, data) {
                    if (data.state == AppointmentStates.fetchingAppointments) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Color(0xff03BF9C),
                        ),
                      );
                    }
                    if (data.state == AppointmentStates.fetchingAppointmentsFailed) {
                      return const Center(
                        child: SizedBox(height: 100, child: Text('Something went wrong')),
                      );
                    }
                    if (data.appointments == null) {
                      return const Center(
                        child: Text('No Data found'),
                      );
                    }

                    if (data.appointments!.isEmpty) {
                      return const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 100,
                          child: Center(child: Text('No Appointments Found')),
                        ),
                      );
                    }

                    var newData = [];
                    int len = data.appointments!.length;

                    if (!isAll) {
                      for (int i = 0; i < len; i++) {
                        if (isTimeRangeWithin(selectedDate, data.appointments![i].timeSlot!)) {
                          newData.add(data.appointments![i]);
                        }
                      }
                    }

                    if (newData.isEmpty && !isAll) {
                      return const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 100,
                          child: Center(child: Text('No Appointments Found')),
                        ),
                      );
                    }
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 160.0,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: isAll ? data.appointments!.length : newData.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 8.0, top: 1, bottom: 1),
                              child: GestureDetector(
                                  child: AppointmentCard(
                                response: isAll ? data.appointments![index] : newData[index],
                              )),
                            );
                          },
                        ),
                      ),
                    );
                  }),
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Tools',
                        style: GoogleFonts.urbanist(
                          textStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0, right: 12),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: firstText.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisExtent: 80),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () => context.pushNamed(navigations[index].name),
                          child: Center(
                            child: MyCard(
                              text1: firstText[index],
                              text2: secondText[index],
                              image: images[index],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        drawer: const Drawer(
          child: const DrawerMenu(),
        ),
      ),
    );
  }
}

class SmallContainer extends StatelessWidget {
  final Color color;
  final String text;

  const SmallContainer({super.key, required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 20,
          width: 20,
          decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(3)),
        ),
        const SizedBox(width: 12),
        Text(
          text,
          style: GoogleFonts.roboto(
            textStyle: const TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: Color(0xff0C091F)),
          ),
        ),
      ],
    );
  }
}

class MyCard extends StatelessWidget {
  final String text1;
  final String text2;
  final String image;

  const MyCard({
    super.key,
    required this.text1,
    required this.text2,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.grey,
            width: 0,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      text1,
                      style: GoogleFonts.urbanist(
                        textStyle: const TextStyle(
                          color: Color(0xff0C091F),
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    Text(
                      text2,
                      style: GoogleFonts.urbanist(
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: Color(0xff0C091F),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SvgPicture.asset(
                image,
                color: Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DateCards extends StatelessWidget {
  final double width;
  final bool isSelected;
  final VoidCallback onTap;
  final String text;
  final Color textColor;

  const DateCards({
    super.key,
    required this.width,
    required this.isSelected,
    required this.onTap,
    required this.text,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: isSelected ? const Color(0xff03BF9C) : const Color(0xffFFFFFF),
        margin: const EdgeInsets.symmetric(horizontal: 4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(6),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 12,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}

class AppointmentCard extends StatelessWidget {
  const AppointmentCard({super.key, required this.response});
  final Appointment response;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          boxShadow: [BoxShadow(color: AppColors.lightGrey7.withOpacity(0.25), offset: const Offset(0, 4), blurRadius: 4)]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(12),
                  topLeft: Radius.circular(12),
                ),
                color: Color(0xff8BDFC7)),
            width: MediaQuery.of(context).size.width - 32,
            // height: 50,
            child: Row(
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(
                    response.name!.capitalize,
                    style: GoogleFonts.urbanist(
                      textStyle: const TextStyle(fontWeight: FontWeight.w600, fontFamily: 'Urbanist', fontSize: 17),
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        '${response.age} years,${response.gender}',
                        style: GoogleFonts.urbanist(
                          textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                ]),
                const Spacer(),
                Text(
                  '${response.timeSlot}',
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
            width: MediaQuery.of(context).size.width - 32,
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () {
                    context.pushNamed(AppRoutes.pastMedicalHistory.name, extra: {
                      'appointment': response,
                      'pastHistory': [],
                      'familyHistory': [],
                      'pastProcedures': [],
                      'allergies': [],
                      'medicalHistory': [],
                    });
                  },
                  child: getOptionWidget(
                    imgPath: 'assets/homeimages/Component 15.svg',
                    title: 'Past Medical\n History',
                  ),
                ),
                InkWell(
                  onTap: () {
                    context.pushNamed(AppRoutes.vitals.name, extra: {
                      'appointment': response,
                      'vitals': [],
                    });
                  },
                  child: getOptionWidget(
                    imgPath: 'assets/homeimages/Vector (15).svg',
                    title: 'Vitals & \nExamination',
                  ),
                ),
                InkWell(
                  onTap: () {
                    context.pushNamed(AppRoutes.writePrescription.name, extra: response);
                  },
                  child: getOptionWidget(
                    imgPath: 'assets/homeimages/Vector (16).svg',
                    title: 'Write\nprescription',
                  ),
                ),
                InkWell(
                  onTap: () {
                    context.pushNamed(AppRoutes.paymentReceiptScreen.name);
                  },
                  child: getOptionWidget(
                    imgPath: 'assets/homeimages/Vector (17).svg',
                    title: 'Make\nreceipt',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget getOptionWidget({
    required String title,
    String? imgPath,
    IconData? icon,
  }) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: const Color(0xffEFE9E9),
            ),
            child: imgPath != null
                ? Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: SvgPicture.asset(
                      height: 20,
                      width: 20,
                      imgPath,
                      color: const Color(0xff413D56),
                    ),
                  )
                : Icon(
                    icon,
                    color: const Color(0xff281B6F),
                  ),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.urbanist(
              textStyle: const TextStyle(fontSize: 12),
              fontWeight: FontWeight.w500,
              color: const Color(0xff0C091F),
            ),
          ),
        ],
      ),
    );
  }
}
