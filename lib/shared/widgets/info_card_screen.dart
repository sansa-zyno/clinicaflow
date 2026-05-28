// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:clinica_flow/features/appointment/viewmodel/appointment_cubit.dart';
import 'package:clinica_flow/features/appointment/model/appointment_model.dart';
import 'package:clinica_flow/features/vitals/service/vitals_service.dart';
import 'package:clinica_flow/core/utils/enums/bloc_enums.dart';
import 'package:clinica_flow/core/utils/enums/route_enums.dart';
import 'package:intl/intl.dart';
import '../../features/past_medical_history/service/past_medical_history_service.dart';
// import 'package:provider/provider.dart';

class InfoCard extends StatelessWidget {
  final List<Appointment> appointments;
  const InfoCard({required this.appointments, Key? key}) : super(key: key);

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
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(8.0),
      itemCount: appointments.length,
      itemBuilder: (BuildContext context, int index) {
        Appointment appointment = appointments[index];
        return Slidable(
          key: const ValueKey(0),
          endActionPane: ActionPane(
            motion: const ScrollMotion(),
            extentRatio: 0.9,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(width: 6),
                  InkWell(
                    onTap: () {
                      context.pushNamed(AppRoutes.writePrescription.name,
                          extra: appointment);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color(0xffF5F5F5),
                          ),
                          child: Center(
                              child: SvgPicture.asset(
                            'assets/homeimages/Vector (16).svg',
                            color: const Color(0xff413D56),
                          )),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Write',
                          style: TextStyle(fontSize: 11),
                        ),
                        const Text(
                          'Prescription',
                          style: TextStyle(fontSize: 11),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 6),
                  BlocBuilder<AppointmentCubit, AppointmentState>(
                      buildWhen: (previous, current) {
                    return current.state ==
                        AppointmentStates.fetchingAppointmentById;
                  }, builder: (context, state) {
                    return FutureBuilder(
                        future: PastMedicalHistoryService()
                            .getPastMedicalHistory(
                                patientId: appointment.patientId!),
                        builder: (context, snapshot) {
                          return InkWell(
                            onTap: () {
                              if (snapshot.data != null) {
                                context.pushNamed(
                                    AppRoutes.pastMedicalHistory.name,
                                    extra: {
                                      'appointment': appointment,
                                      'pastHistory':
                                          snapshot.data!['pastHistory'],
                                      'familyHistory':
                                          snapshot.data!['familyHistory'],
                                      'pastProcedureHistory': snapshot
                                          .data!['pastProcedureHistory'],
                                      'allergies': snapshot.data!['allergies'],
                                      'medication':
                                          snapshot.data!['medication'],
                                    });
                              }
                            },
                            child: Opacity(
                              opacity: snapshot.data == null ? 0.5 : 1,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: const Color(0xffF5F5F5),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: SvgPicture.asset(
                                        'assets/homeimages/Component 15.svg',
                                        height: 22,
                                        width: 22,
                                        color: const Color(0xff413D56),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  const Text(
                                    'Past Medical',
                                    style: TextStyle(fontSize: 11),
                                  ),
                                  const Text(
                                    'History',
                                    style: TextStyle(fontSize: 11),
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                  }),
                  const SizedBox(width: 6),
                  BlocBuilder<AppointmentCubit, AppointmentState>(
                      buildWhen: (previous, current) {
                    return current.state ==
                        AppointmentStates.fetchingAppointmentById;
                  }, builder: (context, state) {
                    return FutureBuilder(
                        future: VitalsService().getVitals(
                            appointmentId: appointment.id!,
                            patientId: appointment.patientId!),
                        builder: (context, snapshot) {
                          return InkWell(
                            onTap: () {
                              if (snapshot.data != null) {
                                context
                                    .pushNamed(AppRoutes.vitals.name, extra: {
                                  'appointment': appointment,
                                  'vitals': snapshot.data,
                                });
                              }
                            },
                            child: Opacity(
                              opacity: snapshot.data == null ? 0.5 : 1,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: const Color(0xffF5F5F5),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: SvgPicture.asset(
                                        'assets/homeimages/Vector (15).svg',
                                        height: 20,
                                        width: 20,
                                        color: const Color(0xff413D56),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  const Text(
                                    'Vitals &',
                                    style: TextStyle(fontSize: 11),
                                  ),
                                  const Text(
                                    'Examination',
                                    style: TextStyle(fontSize: 11),
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                  }),
                  const SizedBox(width: 6),
                  InkWell(
                    onTap: () {
                      context.pushNamed(AppRoutes.appointmentDetail.name,
                          extra: appointment.id);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color(0xffF5F5F5),
                          ),
                          child: const Icon(
                            Icons.manage_history,
                            color: Color(0xff413D56),
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Manage',
                          style: TextStyle(fontSize: 11),
                        ),
                        const Text(
                          'Appt',
                          style: TextStyle(fontSize: 11),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          child: GestureDetector(
            onTap: () {
              context.goNamed(AppRoutes.appointmentDetail.name,
                  extra: appointment.id);
            },
            child: Container(
              margin: const EdgeInsets.symmetric(
                vertical: 6.0,
              ),
              decoration: BoxDecoration(
                color: const Color(0xffF5F5F5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                appointment.clinicPatientId ?? "N/A",
                                // appointment.sId!,
                                style: GoogleFonts.urbanist(
                                  textStyle: const TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                appointment.name ?? 'N/A',
                                style: GoogleFonts.urbanist(
                                  textStyle: const TextStyle(
                                    color: Color(0xff0F0B28),
                                    fontFamily: 'Poppins',
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${appointment.age ?? "N/A"} years, ${appointment.gender ?? "N/A"}',
                                style: GoogleFonts.urbanist(
                                  textStyle: const TextStyle(
                                    color: Color(0xff0C091F),
                                    fontFamily: 'Poppins',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.phone,
                                    size: 16,
                                  ),
                                  Text(
                                    ' +234 ${appointment.mobile ?? 'N/A'}',
                                    style: GoogleFonts.urbanist(
                                      textStyle: const TextStyle(
                                        color: Color(0xffAEAEAE),
                                        fontFamily: 'Poppins',
                                        fontSize: 12,
                                        // color: Colors.grey,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.access_alarm,
                                    size: 18,
                                    color: Color(0xff413D56),
                                  ),
                                  SizedBox(
                                    width: width * 0.34,
                                    child: Text(
                                      '  ${appointment.timeSlot ?? 'N/A'}',
                                      style: GoogleFonts.urbanist(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: const Color(0xff413D56),
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: height * 0.02),
                              Row(
                                children: [
                                  const SizedBox(width: 2),
                                  Image.asset(
                                    'assets/homeimages/stethscope.png',
                                    height: 18,
                                    width: 18,
                                    color: const Color(0xff413D56),
                                  ),
                                  SizedBox(
                                    width: width * 0.35,
                                    child: Text(
                                      '  Dr.${appointment.doctorName ?? 'N/A'}',
                                      style: GoogleFonts.urbanist(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: const Color(0xff413D56),
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
