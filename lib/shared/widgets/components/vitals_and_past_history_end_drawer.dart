import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:clinica_flow/features/appointment/model/appointment_model.dart';
import 'package:clinica_flow/core/utils/enums/bloc_enums.dart';
import 'package:clinica_flow/core/utils/enums/route_enums.dart';
import '../../../core/constants/app_colors.dart';
import '../../../features/past_medical_history/viewmodel/past_medical_history_cubit.dart';
import '../../../features/vitals/viewmodel/vitals_cubit.dart';

class VitalsAndPastHistoryEndDrawer extends StatefulWidget {
  final Appointment appointment;
  const VitalsAndPastHistoryEndDrawer({
    super.key,
    required this.appointment,
  });

  @override
  State<VitalsAndPastHistoryEndDrawer> createState() =>
      _VitalsAndPastHistoryEndDrawerState();
}

class _VitalsAndPastHistoryEndDrawerState
    extends State<VitalsAndPastHistoryEndDrawer> {
  double get height => MediaQuery.of(context).size.height;
  double get width => MediaQuery.of(context).size.width;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // context.read<PastMedicalHistoryCubit>().getPastMedicalHistory(patientId: widget.appointment.patientId!);
    // context.read<VitalsCubit>().getSavedVitals(appointmentId: widget.appointment.id!);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 320,
      elevation: 10,
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: SafeArea(
        child: Column(
          children: [
            // ── Vitals section (intrinsic height) ──
            Material(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              elevation: 10,
              shadowColor: const Color(0xFFFFFFFF),
              surfaceTintColor: const Color(0xFFFFFFFF),
              color: const Color(0xFFFFFFFF),
              child: BlocBuilder<VitalsCubit, VitalsState>(
                  builder: (context, state) {
                if (state.state == VitalsStates.fetchingVitals) {
                  return const SizedBox(
                    height: 120,
                    child: Center(child: CircularProgressIndicator()),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Vitals',
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff0C091F)),
                            ),
                            InkWell(
                              onTap: () {
                                context
                                    .pushNamed(AppRoutes.vitals.name, extra: {
                                  'appointment': widget.appointment,
                                  'vitals': state.savedVital,
                                });
                              },
                              child: Column(
                                children: [
                                  const Text(
                                    'Edit',
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.primaryColor),
                                  ),
                                  Container(
                                    height: 1,
                                    width: 30,
                                    decoration: const BoxDecoration(
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.only(left: 4),
                                height: 75,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color(0xFFF7F7F7),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'SpO2',
                                      style: GoogleFonts.roboto(
                                        textStyle: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xff413D56),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Center(
                                      child: Image.asset(
                                          "assets/homeimages/Vector (4).png"),
                                    ),
                                    const SizedBox(height: 4),
                                    Center(
                                      child: Text(
                                        state.savedVital?.spo2?.toString() ??
                                            '0',
                                        style: GoogleFonts.roboto(
                                          textStyle: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xff0C091F),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Container(
                                height: 75,
                                padding: const EdgeInsets.only(left: 4),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color(0xffF5F5F5),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'BP',
                                      style: GoogleFonts.roboto(
                                        textStyle: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xff413D56),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Center(
                                      child: Image.asset(
                                          "assets/homeimages/Vector (5).png"),
                                    ),
                                    const SizedBox(height: 4),
                                    Center(
                                      child: Text(
                                        '${state.savedVital?.bloodPressure?.systolic?.toString() ?? '0'}/${state.savedVital?.bloodPressure?.diastolic?.toString() ?? '0'}',
                                        style: GoogleFonts.roboto(
                                          textStyle: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xff0C091F),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Container(
                                height: 75,
                                padding: const EdgeInsets.only(left: 4),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color(0xffF5F5F5),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Heart rate',
                                      style: GoogleFonts.roboto(
                                        textStyle: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xff413D56),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Center(
                                      child: Image.asset(
                                          "assets/homeimages/Vector (6).png"),
                                    ),
                                    const SizedBox(height: 4),
                                    Center(
                                      child: Text(
                                        state.savedVital?.pulseRate
                                                ?.toString() ??
                                            '0',
                                        style: GoogleFonts.roboto(
                                          textStyle: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xff0C091F),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Container(
                                height: 75,
                                padding: const EdgeInsets.only(left: 4),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color(0xffF5F5F5),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'BG',
                                      style: GoogleFonts.roboto(
                                        textStyle: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xff413D56),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Center(
                                      child: Image.asset(
                                          "assets/homeimages/droplet-outline.png"),
                                    ),
                                    const SizedBox(height: 4),
                                    Center(
                                      child: Text(
                                        '0',
                                        style: GoogleFonts.roboto(
                                          textStyle: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xff0C091F),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.only(right: 152),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Container(
                                  height: 75,
                                  padding: const EdgeInsets.only(left: 4),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: const Color(0xffF5F5F5),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Ht',
                                        style: GoogleFonts.roboto(
                                          textStyle: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xff413D56),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Center(
                                        child: Image.asset(
                                            "assets/homeimages/Vector (7).png"),
                                      ),
                                      const SizedBox(height: 4),
                                      Center(
                                        child: Text(
                                          state.savedVital?.height
                                                  ?.toString() ??
                                              '0',
                                          style: GoogleFonts.roboto(
                                            textStyle: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xff0C091F),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 6),
                              Expanded(
                                child: Container(
                                  height: 75,
                                  padding: const EdgeInsets.only(left: 4),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: const Color(0xffF5F5F5),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Wt',
                                        style: GoogleFonts.roboto(
                                          textStyle: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xff413D56),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Center(
                                        child: Image.asset(
                                            "assets/homeimages/Vector (8).png"),
                                      ),
                                      const SizedBox(height: 4),
                                      Center(
                                        child: Text(
                                          state.savedVital?.weight
                                                  ?.toString() ??
                                              '0',
                                          style: GoogleFonts.roboto(
                                            textStyle: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xff0C091F),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }
              }),
            ),
            const SizedBox(height: 15),
            // ── Past History section (fills remaining space, scrollable) ──
            Expanded(
              child: Material(
                elevation: 8,
                shadowColor: const Color(0xFFFFFFFF),
                surfaceTintColor: const Color(0xFFFFFFFF),
                color: const Color(0xFFFFFFFF),
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                child: BlocBuilder<PastMedicalHistoryCubit,
                    PastMedicalHistoryState>(builder: (context, state) {
                  if (state.state ==
                      PastMedicalHistoryStates.fetchingPastMedicalHistory) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return SingleChildScrollView(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Past History',
                                style: GoogleFonts.urbanist(
                                  textStyle: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff0C091F),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  context.pushNamed(
                                      AppRoutes.pastMedicalHistory.name,
                                      extra: {
                                        'appointment': widget.appointment,
                                        'pastHistory': state.pastHistory,
                                        'familyHistory': state.familyHistory,
                                        'pastProcedureHistory':
                                            state.pastProcedureHistory,
                                        'allergies': state.allergies,
                                        'medication': state.medication,
                                      });
                                },
                                child: Column(
                                  children: [
                                    const Text('Edit',
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.primaryColor)),
                                    Container(
                                      height: 1,
                                      width: 30,
                                      decoration: const BoxDecoration(
                                        color: AppColors.primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Family History',
                            style: GoogleFonts.urbanist(
                              textStyle: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff868686),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            width: width,
                            height: 52,
                            padding: const EdgeInsets.only(top: 15, left: 10),
                            decoration: const BoxDecoration(
                              color: Color(0xffF7F7F7),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                            ),
                            child: Row(
                                children: List.generate(
                              state.familyHistory?.length ?? 0,
                              (index) => Expanded(
                                child: Text(
                                  state.familyHistory![index].name,
                                  style: const TextStyle(
                                    fontFamily: 'Urbanist',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff0C091F),
                                  ),
                                ),
                              ),
                            )),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Medical Procedures',
                            style: GoogleFonts.urbanist(
                              textStyle: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff868686),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            width: width,
                            height: 52,
                            padding: const EdgeInsets.only(top: 15, left: 10),
                            decoration: const BoxDecoration(
                              color: Color(0xffF7F7F7),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                            ),
                            child: Row(
                                children: List.generate(
                              state.pastProcedureHistory?.length ?? 0,
                              (index) => Expanded(
                                child: Text(
                                  state.pastProcedureHistory![index].name,
                                  style: const TextStyle(
                                    fontFamily: 'Urbanist',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff0C091F),
                                  ),
                                ),
                              ),
                            )),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Medication',
                            style: GoogleFonts.urbanist(
                              textStyle: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff868686),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            width: width,
                            height: 52,
                            padding: const EdgeInsets.only(top: 15, left: 10),
                            decoration: const BoxDecoration(
                              color: Color(0xffF7F7F7),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                            ),
                            child: Row(
                                children: List.generate(
                              state.medication?.length ?? 0,
                              (index) => Expanded(
                                child: Text(
                                  state.medication![index].name,
                                  style: const TextStyle(
                                    fontFamily: 'Urbanist',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff0C091F),
                                  ),
                                ),
                              ),
                            )),
                          ),
                          const SizedBox(height: 16),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Allergies - ',
                                  style: GoogleFonts.urbanist(
                                    textStyle: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xff868686),
                                    ),
                                  ),
                                ),
                                TextSpan(
                                  children: List.generate(
                                    state.allergies?.length ?? 0,
                                    (index) => TextSpan(
                                      text: state.allergies![index].name,
                                      style: const TextStyle(
                                        fontFamily: 'Urbanist',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xff0C091F),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
