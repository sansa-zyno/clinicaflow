import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:healtether_clinic_app/constants/app_colors.dart';
import 'package:healtether_clinic_app/constants/app_text.dart';
import 'package:healtether_clinic_app/data_layer/models/appointment_models/appointment_model.dart';

import 'package:healtether_clinic_app/utils/enums/route_enums.dart';
import 'package:healtether_clinic_app/widgets/components/vitals_and_past_history_end_drawer.dart';

class DigitalScreen extends StatefulWidget {
  const DigitalScreen({super.key, required this.appointment});
  final Appointment appointment;

  @override
  State<DigitalScreen> createState() => _DigitalScreenState();
}

class _DigitalScreenState extends State<DigitalScreen> {
  Widget _buildMenuItem({
    required String title,
    required VoidCallback onTap,
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
            const Icon(
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
      endDrawer: const VitalsAndPastHistoryEndDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildMenuItem(
              title: AppText.symptomsTests,
              onTap: () {
                context.pushNamed(AppRoutes.createDigitalPrescription.name);
              },
            ),
            const SizedBox(height: 8),
            _buildMenuItem(
              title: "Lab tests ",
              onTap: () {
                context.pushNamed(AppRoutes.labInvestigations.name, extra: []);
              },
            ),
            const SizedBox(height: 8),
            _buildMenuItem(
              title: AppText.drugPrescription,
              onTap: () {
                context.pushNamed(AppRoutes.drugPrescription.name,
                    extra: widget.appointment);
              },
            ),
            const SizedBox(height: 8),
            _buildMenuItem(
              title: AppText.pastMedicalHistory,
              onTap: () {
                context.pushNamed(AppRoutes.symptomsTest.name,
                    extra: widget.appointment);
              },
            ),
            const SizedBox(height: 8),
            _buildMenuItem(
              title: 'Vitals & General Examination',
              onTap: () {
                context.pushNamed(AppRoutes.vitals.name,
                    pathParameters: {"appointmentId": widget.appointment.id!});
              },
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 2.0),
              child: Row(children: [
                Container(
                  width: 150,
                  height: 50,
                  decoration: BoxDecoration(
                    color: const Color(0xffF7F7F7),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Center(
                    child: Text(
                      'xxxxx',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 150,
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color(0xFF32856E),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Center(
                      child: Text(
                        'Preview Rx',
                        style: GoogleFonts.urbanist(
                          textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Urbanist',
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
