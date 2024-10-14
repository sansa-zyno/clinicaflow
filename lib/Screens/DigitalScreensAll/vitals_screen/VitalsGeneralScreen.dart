/*import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healtether_clinic_app/Screens/DigitalScreensAll/vitals_screen/other_vitals_screen.dart';
import 'package:healtether_clinic_app/Screens/DigitalScreensAll/vitals_screen/personal_historyScreen.dart';
import 'package:healtether_clinic_app/Screens/DigitalScreensAll/vitals_screen/vitals_detail_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:healtether_clinic_app/utils/enums/route_enums.dart';

class VitalsGeneralScreen extends StatefulWidget {
  const VitalsGeneralScreen({Key? key}) : super(key: key);

  @override
  State<VitalsGeneralScreen> createState() => _VitalsGeneralScreenState();
}

class _VitalsGeneralScreenState extends State<VitalsGeneralScreen> {
  List<String> selectedOptions = [];
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
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "VITALS & GENERAL EXAMINATION",
                      style: GoogleFonts.urbanist(
                        textStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    // const SizedBox(height: 5),
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
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        // PastHistory(),
                                        const OtherVitalsScreen(
                                      appointmentId: '',
                                    ),
                                  ),
                                );
                              },
                              child: Text(
                                'Add',
                                style: GoogleFonts.urbanist(
                                  textStyle: const TextStyle(
                                    fontSize: 17,
                                    // fontFamily: "Montserrat",
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF32856E),
                                  ),
                                ),
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
                      ],
                    ),
                    const SizedBox(height: 8),
                    Column(
                      children: [
                        Text(
                          'Blood Pressure',
                          style: GoogleFonts.urbanist(
                            textStyle: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
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
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 12),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF8F7FC),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Center(
                              child: Text(
                                '120',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Poppins",
                                  fontSize: 16,
                                  color: Color(0xFF908D9E),
                                ),
                              ),
                            ),
                          ),
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
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 12),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF8F7FC),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Center(
                              child: Text(
                                '89',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Poppins",
                                  fontSize: 16,
                                  color: Color(0xFF908D9E),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'mm Hg',
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF000000)),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    // buildVitalItem('SpO2 levels', '%', "96"),
                    // const SizedBox(height: 16),
                    // buildVitalItem('Pulse Rate', 'beats/min', '96'),
                    // const SizedBox(height: 16),
                    // buildVitalItem('RBS', 'mg/dL', '80'),
                    // const SizedBox(height: 16),
                    // buildVitalItem('Height', 'cm', '150'),
                    // const SizedBox(height: 16),
                    // buildVitalItem('Weight', 'Kg', '45.8'),
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
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: Colors.black),
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
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        buildVital('Vital 1', 'Unit', '00'),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Personal History',
                          style: GoogleFonts.urbanist(
                            textStyle: const TextStyle(
                              fontSize: 20,
                              // fontFamily: "Urbanist",
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF0C091F),
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const PersonalHistoryScreen(),
                                  ),
                                );
                              },
                              child: Text(
                                'Add',
                                style: GoogleFonts.urbanist(
                                  textStyle: const TextStyle(
                                    fontSize: 17,
                                    // fontFamily: "Urbanist",
                                    fontWeight: FontWeight.w600,

                                    color: Color(0xFF32856E),
                                  ),
                                ),
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
                      ],
                    ),
                    const SizedBox(height: 8),
                    buildPersonalHistorySection(
                      context,
                      [
                        'None',
                        'Aerobics',
                        'Yoga',
                        'Smoking',
                        'Tobacco',
                        'Gym',
                        'Alcohol Consumption',
                        'Sedentary job',
                        'Other',
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 6, right: 6, bottom: 8, top: 4),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
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
                      //       return const AppointmentScreen();
                      //     }));
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
    );
  }

  Widget buildPersonalHistorySection(
      BuildContext context, List<String> options) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 4.0,
          runSpacing: 8.0,
          children: options.map((option) {
            bool isSelected = selectedOptions.contains(option);
            return GestureDetector(
              onTap: () {
                setState(() {
                  if (option == 'Other') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PersonalHistoryScreen(),
                      ),
                    );
                  } else {
                    if (isSelected) {
                      selectedOptions.remove(option);
                    } else {
                      selectedOptions.add(option);
                    }
                  }
                });
              },
              child: Chip(
                label: Text(
                  option,
                  style: GoogleFonts.urbanist(
                    textStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color:
                          isSelected ? Colors.white : const Color(0xFF0C091F),
                    ),
                  ),
                ),
                backgroundColor: isSelected
                    ? const Color(0xFF32856E)
                    : const Color(0xFFF5F5F5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                  side: BorderSide(
                    color: isSelected
                        ? Colors.grey.shade50
                        : const Color(0xFFF5F5F5),
                  ),
                ),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}*/
