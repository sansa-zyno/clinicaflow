import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healtether_clinic_app/data_layer/models/appointment_models/appointment_model.dart';
import 'package:healtether_clinic_app/utils/enums/route_enums.dart';

class VitalsAndPastHistoryEndDrawer extends StatefulWidget {
  final Appointment appointment;
  const VitalsAndPastHistoryEndDrawer({super.key, required this.appointment});

  @override
  State<VitalsAndPastHistoryEndDrawer> createState() => _VitalsAndPastHistoryEndDrawerState();
}

class _VitalsAndPastHistoryEndDrawerState extends State<VitalsAndPastHistoryEndDrawer> {
  double get height => MediaQuery.of(context).size.height;

  double get width => MediaQuery.of(context).size.width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 640,
      child: Drawer(
        width: 320,
        elevation: 10,
        backgroundColor: Colors.transparent,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: height * 0.27,
                child: Material(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  elevation: 10,
                  shadowColor: const Color(0xFFFFFFFF),
                  surfaceTintColor: const Color(0xFFFFFFFF),
                  color: const Color(0xFFFFFFFF),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Vitals',
                              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500, color: Color(0xff0C091F)),
                            ),
                            InkWell(
                              onTap: () {
                                context.pushNamed(AppRoutes.vitals.name, extra: {
                                  'appointment': widget.appointment,
                                  'vitals': [],
                                });
                              },
                              child: Column(
                                children: [
                                  const Text(
                                    'Edit',
                                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500, color: Color(0xff5351C7)),
                                  ),
                                  Container(
                                    height: 1,
                                    width: 30,
                                    decoration: const BoxDecoration(
                                      color: Color(0xff5351C7),
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
                                      child: Image.asset("assets/homeimages/Vector (4).png"),
                                    ),
                                    const SizedBox(height: 4),
                                    Center(
                                      child: Text(
                                        '97',
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
                                      child: Image.asset("assets/homeimages/Vector (5).png"),
                                    ),
                                    const SizedBox(height: 4),
                                    Center(
                                      child: Text(
                                        '80/120',
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
                                      child: Image.asset("assets/homeimages/Vector (6).png"),
                                    ),
                                    const SizedBox(height: 4),
                                    Center(
                                      child: Text(
                                        '80',
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
                                      child: Image.asset("assets/homeimages/droplet-outline.png"),
                                    ),
                                    const SizedBox(height: 4),
                                    Center(
                                      child: Text(
                                        '150',
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
                                    crossAxisAlignment: CrossAxisAlignment.start,
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
                                        child: Image.asset("assets/homeimages/Vector (7).png"),
                                      ),
                                      const SizedBox(height: 4),
                                      Center(
                                        child: Text(
                                          '160',
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
                                        child: Image.asset("assets/homeimages/Vector (8).png"),
                                      ),
                                      const SizedBox(height: 4),
                                      Center(
                                        child: Text(
                                          '60',
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
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Material(
                elevation: 8,
                shadowColor: const Color(0xFFFFFFFF),
                surfaceTintColor: const Color(0xFFFFFFFF),
                color: const Color(0xFFFFFFFF),
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                child: Padding(
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
                              context.pushNamed(AppRoutes.pastMedicalHistory.name, extra: {
                                'appointment': widget.appointment,
                                'pastHistory': [],
                                'familyHistory': [],
                                'pastProcedures': [],
                                'allergies': [],
                                'medicalHistory': [],
                              });
                            },
                            child: Column(
                              children: [
                                const Text('Edit', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500, color: Color(0xff5351C7))),
                                Container(
                                  height: 1,
                                  width: 30,
                                  decoration: const BoxDecoration(
                                    color: Color(0xff5351C7),
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
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        child: const Text(
                          'Asthma, Hypertension',
                          style: TextStyle(
                            fontFamily: 'Urbanist',
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff0C091F),
                          ),
                        ),
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
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        child: const Text(
                          'Heart Surgery',
                          style: TextStyle(
                            fontFamily: 'Urbanist',
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff0C091F),
                          ),
                        ),
                        // onTap: () {},
                        // contentPadding: const EdgeInsets.symmetric(
                        //     horizontal: 10.0, vertical: 2.0),
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
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        child: const Text(
                          'Dolo - 650, Paracetomol',
                          style: TextStyle(
                            fontFamily: 'Urbanist',
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff0C091F),
                          ),
                        ),
                        // onTap: () {},
                        // contentPadding: const EdgeInsets.symmetric(
                        //     horizontal: 8.0, vertical: 2.0),
                      ),
                      SizedBox(height: height * 0.04),
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
                            const TextSpan(
                                text: 'Pollen, Sunlight',
                                style: TextStyle(
                                  fontFamily: 'Urbanist',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff0C091F),
                                )),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Phobias/Fears - ',
                              style: GoogleFonts.urbanist(
                                textStyle: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff868686),
                                ),
                              ),
                            ),
                            const TextSpan(
                              text: 'Pollen, Sunlight',
                              style: TextStyle(
                                fontFamily: 'Urbanist',
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff0C091F),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
