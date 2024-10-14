/*import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healtether_clinic_app/Screens/DigitalScreensAll/vitals_screen/personal_historyScreen.dart';
import '../../../widgets/green_line_widget.dart';

class VitalsGeneralScreen extends StatefulWidget {
  const VitalsGeneralScreen({Key? key}) : super(key: key);

  @override
  State<VitalsGeneralScreen> createState() => _VitalsGeneralScreenState();
}

class _VitalsGeneralScreenState extends State<VitalsGeneralScreen> {
  String? selectedOption;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Create Digital Prescription',
          style: TextStyle(
            fontFamily: 'Urbanist',
            fontWeight:FontWeight.w500,
            fontSize: 20
          ),
        ),
        backgroundColor: const Color(0xFFE1F9F2),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Vitals & General Examination',
                style: GoogleFonts.urbanist(
                  textStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              const Divider(
                thickness: 1,
                height: 2,
                color: Colors.black,
              ),
              const SizedBox(height: 12),
               Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Vitals',
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: "Urbanist",
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return const PersonalHistoryScreen();
                          }));
                        },
                        child: const Column(
                          children: [
                            Text(
                              'Add',
                              style: TextStyle(
                                fontSize: 17,
                                fontFamily: "Urbanist",
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF32856E),
                              ),
                            ),
                            GreenLine(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              const Column(
                children: [
                  Text(
                    'Blood Pressure',
                    style: TextStyle(
                      fontSize: 17,
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.w600
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
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
                            fontSize: 16,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  const Text(
                    '/',
                    style: TextStyle(
                      fontSize: 18,
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
                          '80',
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w400
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  const Text(
                    'mm Hg',
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w400
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              buildVital('SpO2 levels', '%', '96',),
              const SizedBox(height: 16),
              buildVital('Pulse Rate', 'beats/min', '96'),
              const SizedBox(height: 16),
              buildVital('RBS', 'mg/dl', '80'),
              const SizedBox(height: 16),
              buildVital('Height', 'cm', '150'),
              const SizedBox(height: 16),
              buildVital('Weight', 'kg', '45.8'),
              const SizedBox(height: 16),
              const SizedBox(height: 8),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Your Body Mass Index is',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
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
                          height: 17.5 / 14,
                          letterSpacing: 0.01 * 14,
                          color: Colors.black
                        ),
                      ),
                      SizedBox(width: 4),
                      Text(
                        'kg/m2',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          height: 17.5 / 14,
                          letterSpacing: 0.01 * 14,
                          color: Colors.black
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 6),
                  Row(
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
                          height: 17.5 / 14,
                          letterSpacing: 0.01 * 14,
                          color: Colors.black
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Personal History',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
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
                                const PersonalHistoryScreen()),
                          );
                        },
                        child: const Text(
                          'Add',
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF32856E),
                          ),
                        ),
                      ),
                      const GreenLine(),
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
                  'Alcohol consumption',
                  'Sedentary job',
                  'Other',
                ],
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }


  Widget buildPersonalHistorySection(BuildContext context, List<String> options) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 4.0,
          runSpacing: 4.0,
          children: options.map((option) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedOption = option;
                  if (option == 'Other') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PersonalHistoryScreen(),
                      ),
                    );
                  }
                });
              },
              child: Chip(
                label: Text(
                  option,
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Urbanist',
                    fontWeight: FontWeight.w500,
                    color: selectedOption == option ? Colors.white : Colors.black,
                  ),
                ),
                backgroundColor: selectedOption == option ? const Color(0xFF32856E) : const Color(0xFFF5F5F5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                  side: BorderSide(
                    color: selectedOption == option ? Colors.grey.shade50 : const Color(0xFFF5F5F5),
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



  Widget  buildVital(String title, String unit, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            title,
            style: const TextStyle(
              fontFamily: "Urbanist",
              fontWeight: FontWeight.w600,
              fontSize: 17,
            ),
          ),
        ),
        const SizedBox(width: 2),
        Container(
          width: 100,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          decoration: BoxDecoration(
            color: const Color(0xFFF8F7FC),
            borderRadius: BorderRadius.circular(0),
          ),
          child: Center(
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontFamily: "Poppins",
                fontSize: 16,
                color: Colors.black
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          flex: 1,
          child: Text(
            unit,
            style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500,
                fontFamily: 'Urbanist'
            ),
          ),
        ),
      ],
    );
  }


}*/
