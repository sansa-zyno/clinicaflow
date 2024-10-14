import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healtether_clinic_app/Screens/DigitalScreensAll/vitals_screen/past_historyScreen.dart';
import 'package:go_router/go_router.dart';
import 'package:healtether_clinic_app/utils/enums/route_enums.dart';

class VitalDetailScreen extends StatelessWidget {
  const VitalDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leadingWidth: 30,
        title: Text(
          'Digital Prescription',
          style: GoogleFonts.urbanist(
            textStyle: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              height: 1.25,
              color: Color(0xFF202741),
            ),
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        backgroundColor: const Color(0xFFE1F9F2),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'VITALS & GENERAL EXAMINATION',
                      style: GoogleFonts.urbanist(
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    // const SizedBox(height: 1),
                    const Divider(
                      thickness: 1,
                      height: 2,
                      color: Colors.black,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Vitals',
                          style: GoogleFonts.urbanist(
                            textStyle: const TextStyle(
                              fontSize: 18,
                              // fontFamily: "Montserrat",
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const PastHistory()),
                            );
                          },
                          child: Column(
                            children: [
                              const Text(
                                'Add',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: "Montserrat",
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF32856E),
                                ),
                              ),
                              Container(
                                height: 2,
                                width: 32,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF32856E),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Column(
                      children: [
                        Text(
                          'Blood Pressure',
                          style: GoogleFonts.urbanist(
                            textStyle: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                              width: 120,
                              height: 40,
                              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF8F7FC),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const TextField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: '120',
                                ),
                              )),
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          '/',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Container(
                              width: 120,
                              height: 40,
                              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF8F7FC),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const TextField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: '80',
                                ),
                              )),
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'mm Hg',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    buildVital('SpO2 levels', '%', '96'),
                    const SizedBox(height: 16),
                    buildVital('Pulse Rate', 'beats/min', '96'),
                    const SizedBox(height: 16),
                    buildVital('RBS', 'mg/dL', '80'),
                    const SizedBox(height: 16),
                    buildVital('Height', 'cm', '150'),
                    const SizedBox(height: 16),
                    buildVital('Weight', 'kg', '45.8'),
                    const SizedBox(height: 16),
                    const SizedBox(height: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Text(
                              'Your Body Mass Index is',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 16,
                                height: 17.5 / 14,
                                letterSpacing: 0.01 * 14,
                                color: Color(0xFF000000),
                              ),
                            ),
                            SizedBox(width: 4),
                            Text(
                              '23.4',
                              style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600, fontSize: 16, color: Colors.black),
                            ),
                            SizedBox(width: 4),
                            Text(
                              'kg/m2',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 16,
                                height: 17.5 / 14,
                                letterSpacing: 0.01 * 14,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        const Row(
                          children: [
                            Text(
                              'This is considered ',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 16,
                                height: 17.5 / 14,
                                letterSpacing: 0.01 * 14,
                                color: Color(0xFF000000),
                              ),
                            ),
                            SizedBox(width: 4),
                            Text(
                              'Normal.',
                              style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600, fontSize: 16, color: Colors.black),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        buildVital('Vital 1', 'Unit', '00'),
                      ],
                    ),
                    const SizedBox(height: 16),
                    buildSectionContainer(
                      'Personal history',
                      [
                        'Alcohol - Occasional drinker',
                        'Yoga - Regular',
                        'Sedentary job',
                      ],
                      context,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(children: [
                GestureDetector(
                  // onTap: () {
                  //   Navigator.push(context, MaterialPageRoute(builder: (context){
                  //     return DrugPrescriptionFollowupScreen();
                  //   }));
                  // },
                  child: Container(
                    width: 150,
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color(0xffF5F5F5),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Center(
                      child: Text(
                        'Clear',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                GestureDetector(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Vitals have been saved successfully.'),
                      ),
                    );

                    context.goNamed(AppRoutes.vitals.name);
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) {
                    //   return const AppointmentScreen();
                    // }));
                  },
                  child: Container(
                    width: 150,
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color(0xFF32856E),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Center(
                      child: Text(
                        'Save',
                        style: TextStyle(color: Colors.white),
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

Widget buildSectionContainer(
  String title,
  List<String> options,
  BuildContext context,
) {
  return Container(
    decoration: const BoxDecoration(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(40),
        bottomRight: Radius.circular(40),
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              title,
              style: GoogleFonts.urbanist(
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
            ),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const PastHistory()),
                    );
                  },
                  child: Row(
                    children: [
                      Text(
                        'Add',
                        style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF32856E),
                          ),
                        ),
                      ),
                      // const SizedBox(width: 4),
                    ],
                  ),
                ),
                Container(
                  height: 2,
                  width: 36,
                  decoration: const BoxDecoration(
                    color: Color(0xFF32856E),
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 4,
          children: options.map((option) => buildOptionChip(context, option)).toList(),
        ),
      ],
    ),
  );
}

Widget buildVital(String title, String unit, String value) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Expanded(
        flex: 2,
        child: Text(
          title,
          style: GoogleFonts.urbanist(
            textStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 17,
            ),
          ),
        ),
      ),
      const SizedBox(width: 2),
      Container(
          width: 116,
          height: 40,
          margin: const EdgeInsets.only(left: 18),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
          decoration: BoxDecoration(
            color: const Color(0xFFF8F7FC),
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextField(
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: value,
            ),
          )),
      const SizedBox(width: 4),
      Expanded(
        flex: 1,
        child: Text(
          unit,
          style: GoogleFonts.urbanist(
            textStyle: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              // fontFamily: 'Urbanist'
            ),
          ),
        ),
      ),
    ],
  );
}

Widget buildOptionChip(BuildContext context, String option) {
  return Chip(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
      side: const BorderSide(color: Colors.transparent),
    ),
    backgroundColor: const Color(0xFFAFE9D9),
    label: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          option,
          style: GoogleFonts.urbanist(
            textStyle: const TextStyle(
                fontSize: 14,
                // fontFamily: 'Urbanist',
                fontWeight: FontWeight.w500),
          ),
        ),
        const SizedBox(width: 4),
        Container(
          width: 18,
          height: 18,
          decoration: BoxDecoration(
            color: const Color(0xFFE8F5F3),
            borderRadius: BorderRadius.circular(40),
          ),
          child: const Icon(
            Icons.close,
            size: 16,
            color: Colors.black,
          ),
        ),
      ],
    ),
  );
}
