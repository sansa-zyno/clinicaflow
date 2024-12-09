import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healtether_clinic_app/business_logic/cubits/drug_cubit/drug_prescription_cubit.dart';
import 'package:healtether_clinic_app/business_logic/cubits/lab_test_cubit/lab_test_cubit.dart';
import 'package:healtether_clinic_app/business_logic/cubits/past_medical_history_cubit/past_medical_history_cubit.dart';
import 'package:healtether_clinic_app/business_logic/cubits/symptoms_and_diagnosis_cubit/symptoms_and_diagnosis_cubit.dart';
import 'package:healtether_clinic_app/business_logic/cubits/vitals_cubit/vitals_cubit.dart';
import 'package:healtether_clinic_app/constants/app_colors.dart';
import 'package:healtether_clinic_app/constants/app_text.dart';
import 'package:healtether_clinic_app/data_layer/models/appointment_models/appointment_model.dart';
import 'package:healtether_clinic_app/data_layer/models/prescription/prescription_report.dart';
import 'package:healtether_clinic_app/data_layer/services/prescription/prescription_service.dart';
import 'package:healtether_clinic_app/utils/enums/bloc_enums.dart';
import 'package:healtether_clinic_app/utils/enums/route_enums.dart';
import 'package:healtether_clinic_app/widgets/components/vitals_and_past_history_end_drawer.dart';

class DigitalScreen extends StatefulWidget {
  const DigitalScreen({super.key, required this.appointment});
  final Appointment appointment;

  @override
  State<DigitalScreen> createState() => _DigitalScreenState();
}

class _DigitalScreenState extends State<DigitalScreen> {
  PrescriptionReport? prescriptionReport;

  getPrescriptionReport() async {
    prescriptionReport = await PrescriptionService().getPrescriptionReport(appointmentId: widget.appointment.id!);
    log(prescriptionReport.toString());
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPrescriptionReport();
    context.read<SymptomsAndDiagnosisCubit>().getSavedSymptomsAndDiagnosis(appointmentId: widget.appointment.id!);
    context.read<LabTestCubit>().getSavedLabTests(appointmentId: widget.appointment.id!);
    context.read<DrugPrescriptionCubit>().getSavedDrugPrescription(appointmentId: widget.appointment.id!);
    context.read<PastMedicalHistoryCubit>().getPastMedicalHistory(patientId: widget.appointment.patientId!);
    context.read<VitalsCubit>().getSavedVitals(appointmentId: widget.appointment.id!);
  }

  Widget _buildMenuItem({
    required String title,
    required VoidCallback onTap,
    required bool? isSaved,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 21),
        decoration: const BoxDecoration(
          color: AppColors.whiteSmoke,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: GoogleFonts.urbanist(
                textStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  height: 17.36 / 14,
                  color: Color(0xff000000),
                ),
              ),
            ),
            // const Spacer(),
            isSaved == null
                ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator())
                : isSaved
                    ? Image.asset('assets/png/saved_icon.png')
                    : const Icon(
                        Icons.arrow_forward_ios,
                        size: 24,
                        color: Colors.black54,
                      ),
          ],
        ),
      ),
    );
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool _isDrawerOpen = false;

  void _toggleDrawer() {
    if (_scaffoldKey.currentState!.isEndDrawerOpen) {
      Navigator.of(context).pop();
    } else {
      _scaffoldKey.currentState!.openEndDrawer();
    }
    setState(() {
      _isDrawerOpen = !_isDrawerOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leadingWidth: 30,
        title: Text(
          AppText.digitalPrescription,
          style: GoogleFonts.urbanist(
            textStyle: const TextStyle(
              fontSize: 18,
              fontFamily: 'Urbanist',
              fontWeight: FontWeight.w500,
              height: 1.25,
              color: AppColors.lightBlueColor,
            ),
          ),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_rounded)),
        backgroundColor: const Color(0xFFE1F9F2),
        actions: [
          IconButton(
            onPressed: _toggleDrawer,
            icon: Icon(_isDrawerOpen ? Icons.close : Icons.menu),
          ),
        ],
      ),
      endDrawer: VitalsAndPastHistoryEndDrawer(appointment: widget.appointment),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            BlocBuilder<SymptomsAndDiagnosisCubit, SymptomsAndDiagnosisState>(builder: (context, state) {
              return _buildMenuItem(
                  title: AppText.symptomsTests,
                  onTap: () {
                    if (state.state != SymptomsAndDiagnosisStates.fetchingSavedSymptomsAndDiagnosis &&
                        state.state != SymptomsAndDiagnosisStates.savedSymptomsAndDiagnosisFailed) {
                      context.pushNamed(AppRoutes.createDigitalPrescription.name, extra: {
                        'appointment': widget.appointment,
                        'symptoms': state.savedSymptoms,
                        'diagnosis': state.savedDiagnosis,
                      });
                    }
                  },
                  isSaved: state.state == SymptomsAndDiagnosisStates.fetchingSavedSymptomsAndDiagnosis
                      ? null
                      : (state.savedSymptoms?.isNotEmpty ?? false) || (state.savedDiagnosis?.isNotEmpty ?? false));
            }),
            const SizedBox(height: 8),
            BlocBuilder<LabTestCubit, LabTestState>(builder: (context, state) {
              return _buildMenuItem(
                  title: "Lab tests ",
                  onTap: () {
                    if (state.state != LabTestStates.fetchingSavedTests && state.state != LabTestStates.savedTestsFailed) {
                      context.pushNamed(AppRoutes.labInvestigations.name, extra: {
                        'appointment': widget.appointment,
                        'labTests': state.savedTests,
                      });
                    }
                  },
                  isSaved: state.state == LabTestStates.fetchingSavedTests ? null : (state.savedTests?.isNotEmpty ?? false));
            }),
            const SizedBox(height: 8),
            BlocBuilder<DrugPrescriptionCubit, DrugPrescriptionState>(builder: (context, state) {
              return _buildMenuItem(
                  title: AppText.drugPrescription,
                  onTap: () {
                    if (state.state != DrugPrescriptionStates.fetchingSavedDrugPrescription &&
                        state.state != DrugPrescriptionStates.savedDrugPrescriptionFailed) {
                      context.pushNamed(AppRoutes.drugPrescription.name, extra: {
                        'appointment': widget.appointment,
                        'savedDrugPrescription': state.savedDrugPrescription,
                      });
                    }
                  },
                  isSaved: state.state == DrugPrescriptionStates.fetchingSavedDrugPrescription
                      ? null
                      : (state.savedDrugPrescription?['drugs']?.isNotEmpty ?? false));
            }),
            const SizedBox(height: 8),
            BlocBuilder<PastMedicalHistoryCubit, PastMedicalHistoryState>(builder: (context, state) {
              return _buildMenuItem(
                  title: AppText.pastMedicalHistory,
                  onTap: () {
                    if (state.state != PastMedicalHistoryStates.fetchingPastMedicalHistory &&
                        state.state != PastMedicalHistoryStates.fetchingPastMedicalHistoryFailed) {
                      context.pushNamed(AppRoutes.pastMedicalHistory.name, extra: {
                        'appointment': widget.appointment,
                        'pastHistory': state.pastHistory,
                        'familyHistory': state.familyHistory,
                        'pastProcedureHistory': state.pastProcedureHistory,
                        'allergies': state.allergies,
                        'medication': state.medication,
                      });
                    }
                  },
                  isSaved: state.state == PastMedicalHistoryStates.fetchingPastMedicalHistory
                      ? null
                      : (state.allergies?.isNotEmpty ?? false) ||
                          (state.familyHistory?.isNotEmpty ?? false) ||
                          (state.medication?.isNotEmpty ?? false) ||
                          (state.pastHistory?.isNotEmpty ?? false) ||
                          (state.pastProcedureHistory?.isNotEmpty ?? false));
            }),
            const SizedBox(height: 8),
            BlocBuilder<VitalsCubit, VitalsState>(builder: (context, state) {
              return _buildMenuItem(
                  title: 'Vitals & General Examination',
                  onTap: () {
                    if (state.state != VitalsStates.fetchingVitals && state.state != VitalsStates.fetchingVitalsFailed) {
                      context.pushNamed(AppRoutes.vitals.name, extra: {
                        'appointment': widget.appointment,
                        'vitals': state.savedVital,
                      });
                    }
                  },
                  isSaved: state.state == VitalsStates.fetchingVitals ? null : (state.savedVital != null && state.savedVital!.id != null));
            }),
            const Spacer(),
            Row(children: [
              GestureDetector(
                onTap: () {
                  context.pushNamed(AppRoutes.paymentReceiptScreen.name);
                },
                child: Container(
                  width: 150,
                  height: 58,
                  decoration: BoxDecoration(
                    color: AppColors.whiteSmoke,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Center(
                    child: Text(
                      'Make Receipt',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  //await Future.delayed(const Duration(seconds: 1));
                  if (prescriptionReport != null) {
                    log('hello');
                    context.pushNamed(AppRoutes.prescriptionPreview.name, extra: {
                      'prescriptionReport': prescriptionReport,
                    });
                  }
                },
                child: Container(
                  width: 150,
                  height: 58,
                  decoration: BoxDecoration(
                    color: AppColors.greenColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Center(
                    child: Text(
                      'Preview Rx',
                      style: GoogleFonts.urbanist(
                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Urbanist',
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
