import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:healtether_clinic_app/Screens/AppointmentScreen/widgets/info_card_screen.dart';
import 'package:healtether_clinic_app/Screens/Models/schedule_date.dart';

import 'package:healtether_clinic_app/Screens/ScheduleAppointment/add_personl_detail_screen.dart';

import 'package:healtether_clinic_app/business_logic/cubits/appointment_cubit/appointment_cubit.dart';
import 'package:healtether_clinic_app/business_logic/cubits/home_page_bottom_nav_cubit/home_page_bottom_nav_cubit.dart';
import 'package:healtether_clinic_app/data_layer/sample_objects/sample_objects.dart';
import 'package:healtether_clinic_app/constants/constants.dart';
import 'package:healtether_clinic_app/utils/enums/route_enums.dart';
import 'package:healtether_clinic_app/utils/helper_functions/log.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({super.key});

  @override
  State<AppointmentScreen> createState() => AppointmentScreenState();
}

class AppointmentScreenState extends State<AppointmentScreen> {
  String selectedDate = 'Upcoming';
  bool isLoading = false;
  // late AppointmentProvider appointmentProvider;

  @override
  void initState() {
    super.initState();

    context.read<HomePageBottomNavCubit>().onPageChanged(1);
    context.read<AppointmentCubit>().fetchAppointments();
    log("Initstate called");
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    // var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 30,
        surfaceTintColor: AppColors.whiteColor,
        title: Text(
          'Appointments',
          style:
              GoogleFonts.urbanist(fontWeight: FontWeight.w500, fontSize: 20),
        ),
      ),
      body: BlocBuilder<AppointmentCubit, AppointmentState>(
          builder: (context, state) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 6.0, right: 3),
                  child: Container(
                    color: const Color(0xffF5F5F5),
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: width * 0.93,
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Quick Search',
                                hintStyle: GoogleFonts.roboto(
                                  color: const Color(0xff413D56),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                                suffixIcon: ScheduleSearchBox(),
                                prefixIcon: const Icon(Icons.search,
                                    color: Color(0xff413D56)),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DateCards(
                          isSelected: selectedDate == 'Upcoming',
                          onTap: () {
                            setState(() {
                              selectedDate = 'Upcoming';
                            });
                          },
                          text: 'Upcoming',
                        ),
                        DateCards(
                          isSelected: selectedDate == 'Cancelled',
                          onTap: () {
                            setState(() {
                              selectedDate = 'Cancelled';
                            });
                          },
                          text: 'Cancelled',
                        ),
                        DateCards(
                          isSelected: selectedDate == 'Completed',
                          onTap: () {
                            setState(() {
                              selectedDate = 'Completed';
                            });
                          },
                          text: 'Completed',
                        ),
                        DateCards(
                          isSelected: selectedDate == 'No show',
                          onTap: () {
                            setState(() {
                              selectedDate = 'No show';
                            });
                          },
                          text: 'No show',
                        ),
                        DateCards(
                          isSelected: selectedDate == 'Rescheduled',
                          onTap: () {
                            setState(() {
                              selectedDate = 'Rescheduled';
                            });
                          },
                          text: 'Rescheduled',
                        ),
                        DateCards(
                          isSelected: selectedDate == 'All',
                          onTap: () {
                            setState(() {
                              selectedDate = 'All';
                            });
                          },
                          text: 'All',
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'All ${state.totalCount} appointments are listed',
                                  style: GoogleFonts.roboto(
                                    textStyle: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xff868686),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      isLoading
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : InfoCard(
                              appointment:
                                  SampleObjects.appointmentResponseObject,
                            ),
                      // SizedBox(
                      //   height: 12,
                      // ),
                      // InfoCard(),
                      // SizedBox(
                      //   height: 12,
                      // ),
                      // InfoCard(),
                      // SizedBox(
                      //   height: 12,
                      // ),
                      // InfoCard(),
                      // SizedBox(
                      //   height: 12,
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pushNamed(AppRoutes.addPersonalDetails.name);
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) {
          //     // return const AddAppointScreen();
          //     return const AddPersonalDetailsScreen();
          //   }),
          // );
        },
        backgroundColor: const Color(0xff32856E),
        shape: const CircleBorder(),
        child: Icon(
          MdiIcons.accountMultiplePlus,
          color: Colors.white,
        ),
      ),
    );
  }
}

class DateCards extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;
  final double? width;

  const DateCards({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onTap,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return GestureDetector(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xff6CEBC6)
                    : const Color(0xffF5F5F5),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  text,
                  style: GoogleFonts.urbanist(
                    textStyle: TextStyle(
                      fontSize: 15,
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.w600,
                      color: isSelected
                          ? const Color(0xff0C091F)
                          : const Color(0xff928F9E),
                      fontFamily: GoogleFonts.montserrat().fontFamily,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
