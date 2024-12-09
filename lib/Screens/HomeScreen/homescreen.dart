import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healtether_clinic_app/Screens/HomeScreen/drawer_menu.dart';
import 'package:healtether_clinic_app/business_logic/cubits/appointment_cubit/appointment_cubit.dart';
import 'package:healtether_clinic_app/business_logic/cubits/home_page_bottom_nav_cubit/home_page_bottom_nav_cubit.dart';
import 'package:healtether_clinic_app/constants/app_constants.dart';
import 'package:healtether_clinic_app/data_layer/models/appointment_models/appointment_model.dart';
import 'package:healtether_clinic_app/constants/constants.dart';
import 'package:healtether_clinic_app/data_layer/models/patient_records_model/patient_model.dart';
import 'package:healtether_clinic_app/data_layer/models/user_model/user_model.dart';
import 'package:healtether_clinic_app/data_layer/services/past%20medical%20history/past_medical_history_service.dart';
import 'package:healtether_clinic_app/data_layer/services/vitals_service/vitals_service.dart';
import 'package:healtether_clinic_app/utils/enums/bloc_enums.dart';
import 'package:healtether_clinic_app/utils/enums/route_enums.dart';
import 'package:healtether_clinic_app/utils/extensions.dart/string_extensions.dart';
import 'package:healtether_clinic_app/utils/extensions.dart/widget_extensions.dart';
import 'package:healtether_clinic_app/widgets/text_list_tile.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../business_logic/cubits/patient_records_cubit/patient_records_cubit.dart';
import '../../business_logic/cubits/staff_cubit/staff_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UserModel? userModel;
  OverlayEntry? _overlayEntry;
  final layerLink = LayerLink();
  DateTime selectedDate = DateTime.now(); // Initially, set to today
  String selectedTimeRange = getCurrentTimeRange();
  bool isAll = true;

  void getCurrentUser() async {
    var data = await UserModel.getCurrentUser();
    userModel = data;
    setState(() {});
  }

  // Function to format the date as needed (e.g., 'May 24')
  String getFormattedDate(DateTime date) {
    if (date.year == DateTime.now().year) {
      return DateFormat('MMM dd').format(date); // E.g., May 24
    } else {
      return DateFormat('MMM dd, yyyy').format(date); // E.g., May 24, 2023
    }
  }

  // Function to go to the previous day
  void goToPreviousDay() {
    setState(() {
      selectedDate = selectedDate.subtract(const Duration(days: 1));
    });
    context.read<AppointmentCubit>().getCompletedAndRemainingAppointmentCount(
        date: "${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}");
  }

  // Function to go to the next day
  void goToNextDay() {
    setState(() {
      selectedDate = selectedDate.add(const Duration(days: 1));
    });
    context.read<AppointmentCubit>().getCompletedAndRemainingAppointmentCount(
        date: "${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}");
  }

  static String getCurrentTimeRange() {
    final now = DateTime.now();
    // Calculate start of the hour
    final startOfDay = DateTime(now.year, now.month, now.day, now.hour);
    // Format start and end times
    final startFormatted = DateFormat('h:mm a').format(startOfDay);
    final endFormatted = DateFormat('h:mm a').format(startOfDay.add(const Duration(hours: 1)));
    return '$startFormatted - $endFormatted';
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

  //check if range2 is within the range of range 1
  bool isTimeRangeWithin(String range1, String range2) {
    List<int> times1 = _parseTimeRange(range1); //e.g [360,450]
    List<int> times2 = _parseTimeRange(range2); //e.g [380,420]
    return times2[0] >= times1[0] && times2[1] <= times1[1];
  }

  //converts time range in string e.g 6:00 am - 7:30 am to List of mins in int e.g [360,450]
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
    //Note: 6am - 12am // interval: 1hr:30mins
    if ((period == 'pm' || period == 'PM') && hours != 12) {
      hours += 12; //24 hours equivalent
    } else if ((period == 'am' || period == 'AM') && hours == 12) {
      hours = 0; //24 hours equivalent
    }
    // Handle midnight (12:00 am) as the end of the day
    if (hours == 0 && minutes == 0 && period == 'am') {
      return 24 * 60; // End of the day
    }
    return hours * 60 + minutes;
  }

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
    getCurrentUser();
    BlocProvider.of<AppointmentCubit>(context).fetchAppointments(status: 'Upcoming');
    context.read<AppointmentCubit>().getCompletedAndRemainingAppointmentCount(
        date: "${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}");
    context.read<PatientRecordsCubit>().fetchPatients();
    context.read<StaffCubit>().fetchStaffs();
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
    return SafeArea(
      child: Scaffold(
        drawer: const Drawer(
          child: DrawerMenu(),
        ),
        body: GestureDetector(
          onTap: () {
            if (_overlayEntry != null) {
              _removeOverlay();
            }
          },
          child: ListView(
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
                            CircleAvatar(
                              radius: 35,
                              backgroundColor: Colors.white,
                              child: (userModel?.profilePic ?? '') == ''
                                  ? Image.asset(
                                      'assets/homeimages/Ellipse 760 (2).png',
                                      height: 100,
                                      width: 100,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.network(
                                      userModel!.profilePic,
                                      height: 100,
                                      width: 100,
                                    ),
                            ),
                            const SizedBox(width: 6),
                            Expanded(
                              child: CompositedTransformTarget(
                                link: layerLink,
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
                                          onChanged: (value) {
                                            if (_overlayEntry == null) {
                                              _showOverlay(context, buildPatientResults(value));
                                            } else {
                                              _removeOverlay();
                                              _showOverlay(context, buildPatientResults(value));
                                            }
                                          },
                                        ),
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
                          height: 40,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 16.0),
                                child: InkWell(
                                  onTap: () {
                                    goToPreviousDay();
                                  },
                                  child: const Icon(
                                    Icons.arrow_back_ios_new_rounded,
                                    size: 15,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Text(
                                getFormattedDate(selectedDate),
                                style: GoogleFonts.urbanist(
                                  textStyle: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 16.0),
                                child: InkWell(
                                  onTap: () {
                                    goToNextDay();
                                  },
                                  child: const Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    size: 14,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    BlocBuilder<AppointmentCubit, AppointmentState>(builder: (context, state) {
                      if (state.patientsHelped == null ||
                          state.state == AppointmentStates.fetchingAppointmentCount ||
                          state.state == AppointmentStates.fetchingAppointmentCountFailed) {
                        return AppConstants.patientsHelpedPlaceHolder();
                      } else {
                        double val = state.patientsHelped!['received'] != 0
                            ? ((state.patientsHelped!['completed'] / state.patientsHelped!['received']) * 100)
                            : 0;
                        int percentVal = val.round();
                        return Row(
                          children: [
                            Expanded(
                              child: CircularPercentIndicator(
                                radius: 50.0,
                                animation: true,
                                animationDuration: 1200,
                                lineWidth: 10.0,
                                percent: percentVal <= 100 ? percentVal / 100 : 1.0,
                                center: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "$percentVal%",
                                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
                                    ),
                                    const Text(
                                      'done',
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
                                    )
                                  ],
                                ),
                                circularStrokeCap: CircularStrokeCap.butt,
                                backgroundColor: const Color(0xffE4E0F3),
                                progressColor: const Color(0xff03BF9C),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${state.patientsHelped!['completed']}/${state.patientsHelped!['received']} patients helped',
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
                        );
                      }
                    }),
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
                                          isSelected: isTimeRangeWithin(selectedTimeRange, e) && !isAll,
                                          onTap: () {
                                            setState(() {
                                              isAll = false;
                                              selectedTimeRange = e;
                                            });
                                          },
                                          text: e,
                                          textColor: (isTimeRangeWithin(selectedTimeRange, e) && !isAll) ? Colors.black : const Color(0xff9E9E9E),
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
                                    context.read<HomePageBottomNavCubit>().onPageChanged(1);
                                    context.goNamed(AppRoutes.appointment.name);
                                  },
                                  child: const Text(
                                    'See All',
                                    style: TextStyle(
                                      color: Color(0xff32856E),
                                      fontWeight: FontWeight.bold,
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
                    BlocBuilder<AppointmentCubit, AppointmentState>(builder: (context, state) {
                      if (state.state == AppointmentStates.fetchingAppointments) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Color(0xff03BF9C),
                          ),
                        );
                      }
                      if (state.state == AppointmentStates.fetchingAppointmentsFailed) {
                        return const Center(
                          child: SizedBox(height: 100, child: Text('Something went wrong')),
                        );
                      }
                      if (state.appointments == null) {
                        return const Center(
                          child: Text('No Data found'),
                        );
                      }

                      if (state.appointments!.isEmpty) {
                        return const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: 100,
                            child: Center(child: Text('No Appointments Found')),
                          ),
                        );
                      }

                      List<Appointment> newData = [];
                      if (!isAll) {
                        for (int i = 0; i < state.appointments!.length; i++) {
                          if (isTimeRangeWithin(selectedTimeRange, state.appointments![i].timeSlot!)) {
                            newData.add(state.appointments![i]);
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
                            itemCount: isAll ? state.appointments!.length : newData.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 8.0, top: 1, bottom: 1),
                                child: GestureDetector(
                                    child: AppointmentCard(
                                  response: isAll ? state.appointments![index] : newData[index],
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
        ),
      ),
    );
  }

  void _showOverlay(
    BuildContext context,
    Widget widget,
  ) {
    _overlayEntry = _createOverlayEntry(widget);
    Overlay.of(context)?.insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  OverlayEntry _createOverlayEntry(Widget widget) {
    return OverlayEntry(
      builder: (context) => Positioned(
        width: 360,
        child: CompositedTransformFollower(
          link: layerLink,
          showWhenUnlinked: false,
          offset: Offset(0.0, 60.0),
          child: Material(elevation: 1.0, child: Container(height: 325, child: SingleChildScrollView(child: widget))),
        ),
      ),
    );
  }

  Widget buildPatientResults(String query) {
    return BlocBuilder<PatientRecordsCubit, PatientRecordsState>(builder: (context, state) {
      if (state.state == PatientRecordsStates.fetchingPatients) {
        return Container();
      } else if (state.state == PatientRecordsStates.fetchingPatientsFailed) {
        return Container();
      } else {
        List<PatientOverviewModel> result = state.patients
                ?.where((e) =>
                    e.id!.toLowerCase() == query.toLowerCase() ||
                    e.firstName!.toLowerCase().trim().startsWith(query.toLowerCase()) ||
                    e.lastName!.toLowerCase().trim().startsWith(query.toLowerCase()) ||
                    e.mobile == query)
                .toList() ??
            [];
        return Column(
            children: List<Widget>.generate(result.length, (index) {
          PatientOverviewModel patient = result.elementAt(index);

          return TextListTile(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
            text: patient.fullName,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            onTap: () {
              context.pushNamed(AppRoutes.patientRecordsScreen.name, extra: patient);
              _removeOverlay();
            },
          ).pOnly(bottom: 8);
        }));
      }
    });
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

class AppointmentCard extends StatefulWidget {
  const AppointmentCard({super.key, required this.response});
  final Appointment response;

  @override
  State<AppointmentCard> createState() => _AppointmentCardState();
}

class _AppointmentCardState extends State<AppointmentCard> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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
                    widget.response.name!.capitalize,
                    style: GoogleFonts.urbanist(
                      textStyle: const TextStyle(fontWeight: FontWeight.w600, fontFamily: 'Urbanist', fontSize: 17),
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        '${widget.response.age} years,${widget.response.gender}',
                        style: GoogleFonts.urbanist(
                          textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                ]),
                const Spacer(),
                Text(
                  '${widget.response.timeSlot}',
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
                FutureBuilder(
                    future: PastMedicalHistoryService().getPastMedicalHistory(patientId: widget.response.patientId!),
                    builder: (context, snapshot) {
                      return InkWell(
                        onTap: () {
                          if (snapshot.data != null) {
                            context.pushNamed(AppRoutes.pastMedicalHistory.name, extra: {
                              'appointment': widget.response,
                              'pastHistory': snapshot.data!['pastHistory'],
                              'familyHistory': snapshot.data!['familyHistory'],
                              'pastProcedureHistory': snapshot.data!['pastProcedureHistory'],
                              'allergies': snapshot.data!['allergies'],
                              'medication': snapshot.data!['medication'],
                            });
                          }
                        },
                        child: Opacity(
                          opacity: snapshot.data == null ? 0.5 : 1,
                          child: getOptionWidget(
                            imgPath: 'assets/homeimages/Component 15.svg',
                            title: 'Past Medical\n History',
                          ),
                        ),
                      );
                    }),
                FutureBuilder(
                    future: VitalsService().getVitals(appointmentId: widget.response.id!),
                    builder: (context, snapshot) {
                      return InkWell(
                        onTap: () {
                          if (snapshot.data != null) {
                            context.pushNamed(AppRoutes.vitals.name, extra: {
                              'appointment': widget.response,
                              'vitals': snapshot.data,
                            });
                          }
                        },
                        child: Opacity(
                          opacity: snapshot.data == null ? 0.5 : 1,
                          child: getOptionWidget(
                            imgPath: 'assets/homeimages/Vector (15).svg',
                            title: 'Vitals & \nExamination',
                          ),
                        ),
                      );
                    }),
                InkWell(
                  onTap: () {
                    context.pushNamed(AppRoutes.writePrescription.name, extra: widget.response);
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
