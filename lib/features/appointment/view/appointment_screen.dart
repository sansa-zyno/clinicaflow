import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:clinica_flow/shared/widgets/info_card_screen.dart';
import 'package:clinica_flow/features/appointment/model/appointment_model.dart';
import 'package:clinica_flow/features/appointment/viewmodel/appointment_cubit.dart';
import 'package:clinica_flow/core/utils/enums/bloc_enums.dart';

import '../../team/viewmodel/staff_cubit.dart';
import '../../../core/constants/app_colors.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({super.key});

  @override
  State<AppointmentScreen> createState() => AppointmentScreenState();
}

class AppointmentScreenState extends State<AppointmentScreen> {
  String selectedDate = 'upcoming';
  TextEditingController searchController = TextEditingController();
  List<Appointment>? searchResult;

  @override
  void initState() {
    super.initState();
    context.read<StaffCubit>().fetchDoctors(); //Used in appointment filter
    // Only fetch if the cubit has never loaded appointments yet —
    // avoids wiping the list that HomeScreen already loaded.
    /*final existing = context.read<AppointmentCubit>().state;
    if (existing.appointments == null) {
      context.read<AppointmentCubit>().fetchAppointments(status: selectedDate);
    }*/
    context.read<AppointmentCubit>().fetchAppointments(status: selectedDate);
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
      body: BlocListener<AppointmentCubit, AppointmentState>(
        listener: (context, state) {
          if (searchController.text.isNotEmpty) {
            searchResult = state.appointments
                    ?.where((e) =>
                        (e.clinicPatientId?.toLowerCase().trim().startsWith(
                                searchController.text.toLowerCase()) ??
                            false) ||
                        (e.name?.toLowerCase().trim().startsWith(
                                searchController.text.toLowerCase()) ??
                            false) ||
                        (e.mobile?.startsWith(searchController.text) ?? false))
                    .toList() ??
                [];
          }
        },
        child: BlocBuilder<AppointmentCubit, AppointmentState>(
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
                                controller: searchController,
                                decoration: InputDecoration(
                                  hintText: 'Quick Search',
                                  hintStyle: GoogleFonts.roboto(
                                    color: const Color(0xff413D56),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  suffixIcon: InkWell(
                                      onTap: () async {
                                        Map? result = await context
                                            .read<AppointmentCubit>()
                                            .state
                                            .showBottomsSheet!();
                                        if (result != null) {
                                          if (result['selectedDate'] == '' &&
                                              result['selectedDoctor'] != '') {
                                            searchResult = state.appointments
                                                    ?.where((e) =>
                                                        e.doctorName
                                                            ?.toLowerCase()
                                                            .trim()
                                                            .startsWith(result[
                                                                    'selectedDoctor']
                                                                .toString()
                                                                .toLowerCase()) ??
                                                        false)
                                                    .toList() ??
                                                [];
                                          } else if (result['selectedDate'] !=
                                                  '' &&
                                              result['selectedDoctor'] == '') {
                                            searchResult = state.appointments
                                                    ?.where((e) =>
                                                        e.appointmentDate
                                                            ?.substring(0, 10)
                                                            .trim()
                                                            .contains(result[
                                                                'selectedDate']) ??
                                                        false)
                                                    .toList() ??
                                                [];
                                          } else if (result['selectedDate'] ==
                                                  '' &&
                                              result['selectedDoctor'] == '') {
                                            searchResult = state.appointments;
                                          } else {
                                            searchResult = state.appointments
                                                    ?.where((e) =>
                                                        e.appointmentDate
                                                            ?.substring(0, 10)
                                                            .trim()
                                                            .contains(result[
                                                                'selectedDate']) ??
                                                        false)
                                                    .where((e) =>
                                                        e.doctorName
                                                            ?.toLowerCase()
                                                            .trim()
                                                            .startsWith(result[
                                                                    'selectedDoctor']
                                                                .toString()
                                                                .toLowerCase()) ??
                                                        false)
                                                    .toList() ??
                                                [];
                                          }

                                          setState(() {});
                                        }
                                      },
                                      child: const Icon(
                                        Icons.tune_outlined,
                                        color: Color(0xff413D56),
                                      )),
                                  prefixIcon: const Icon(Icons.search,
                                      color: Color(0xff413D56)),
                                  border: InputBorder.none,
                                ),
                                onChanged: (query) {
                                  if (query.isEmpty) {
                                    searchResult = null;
                                  } else {
                                    searchResult = state.appointments
                                            ?.where((e) =>
                                                (e.clinicPatientId
                                                        ?.toLowerCase()
                                                        .trim()
                                                        .startsWith(query
                                                            .toLowerCase()) ??
                                                    false) ||
                                                (e.name
                                                        ?.toLowerCase()
                                                        .trim()
                                                        .startsWith(query
                                                            .toLowerCase()) ??
                                                    false) ||
                                                (e.mobile?.startsWith(query) ??
                                                    false))
                                            .toList() ??
                                        [];
                                  }

                                  setState(() {});
                                },
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
                            isSelected: selectedDate == 'upcoming',
                            onTap: () {
                              setState(() {
                                searchResult = null;
                                selectedDate = 'upcoming';
                              });
                              context
                                  .read<AppointmentCubit>()
                                  .fetchAppointments(status: selectedDate);
                            },
                            text: 'Upcoming',
                          ),
                          DateCards(
                            isSelected: selectedDate == 'cancelled',
                            onTap: () {
                              setState(() {
                                searchResult = null;
                                selectedDate = 'cancelled';
                              });
                              context
                                  .read<AppointmentCubit>()
                                  .fetchAppointments(status: selectedDate);
                            },
                            text: 'Cancelled',
                          ),
                          DateCards(
                            isSelected: selectedDate == 'completed',
                            onTap: () {
                              setState(() {
                                searchResult = null;
                                selectedDate = 'completed';
                              });
                              context
                                  .read<AppointmentCubit>()
                                  .fetchAppointments(status: selectedDate);
                            },
                            text: 'Completed',
                          ),
                          DateCards(
                            isSelected: selectedDate == 'no-show',
                            onTap: () {
                              setState(() {
                                searchResult = null;
                                selectedDate = 'no-show';
                              });
                              context
                                  .read<AppointmentCubit>()
                                  .fetchAppointments(status: selectedDate);
                            },
                            text: 'No show',
                          ),
                          DateCards(
                            isSelected: selectedDate == 'rescheduled',
                            onTap: () {
                              setState(() {
                                searchResult = null;
                                selectedDate = 'rescheduled';
                              });
                              context
                                  .read<AppointmentCubit>()
                                  .fetchAppointments(status: selectedDate);
                            },
                            text: 'Rescheduled',
                          ),
                          DateCards(
                            isSelected: selectedDate == 'All',
                            onTap: () {
                              setState(() {
                                searchResult = null;
                                selectedDate = 'All';
                              });
                              context
                                  .read<AppointmentCubit>()
                                  .fetchAppointments(status: selectedDate);
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
                        // Mutually exclusive: only one branch renders at a time.
                        if (state.state ==
                            AppointmentStates.fetchingAppointments)
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 2,
                            child: const Center(
                                child: CircularProgressIndicator()),
                          )
                        else if (searchResult != null && searchResult!.isEmpty)
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 2,
                            child: const Center(
                                child: Text('No appointments found.')),
                          )
                        else if (searchResult == null &&
                            (state.appointments == null ||
                                state.appointments!.isEmpty))
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 2,
                            child: const Center(
                                child: Text('No appointments found.')),
                          )
                        else ...[
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'All ${searchResult != null ? searchResult!.length : state.totalCount} appointments are listed',
                                  style: GoogleFonts.roboto(
                                    textStyle: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xff868686),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          InfoCard(
                            appointments: searchResult ?? state.appointments!,
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
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
