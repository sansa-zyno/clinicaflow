/*import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VitalsSaveDataScreen extends StatelessWidget {
  const VitalsSaveDataScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Digital Prescription',
          style: GoogleFonts.montserrat(
            textStyle: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              height: 1.25,
              color: Color(0xFF202741),
            ),
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
                'Medical Condition Investigation',
                style: GoogleFonts.montserrat(
                  textStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              const Divider(
                thickness: 1,
                height: 2,
                color: Colors.black,
              ),
              const SizedBox(height: 12),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Vitals',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    'Add',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      width: 120,
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Center(
                        child: Text(
                          '120',
                          style: TextStyle(
                            fontSize: 18,
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
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Center(
                        child: Text(
                          '80',
                          style: TextStyle(
                            fontSize: 18,
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
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              _buildVitalItem('SpO2 levels', '%', '95'),
              const SizedBox(height: 16),
              _buildVitalItem('Pulse Rate', 'beats/min', '60'),
              const SizedBox(height: 16),
              _buildVitalItem('RBS', 'mg/dl', '60'),
              const SizedBox(height: 16),
              _buildVitalItem('Height', 'cm', '160'),
              const SizedBox(height: 16),
              _buildVitalItem('Weight', 'kg', '60'),
              const SizedBox(height: 16),
              const SizedBox(height: 8),
              Container(
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
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
                            height: 17.5 / 14,
                            letterSpacing: 0.01 * 14,
                            color: Color(0xFF234567),
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
                            color: Color(0xFF234567),
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
                            color: Color(0xFF234567),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              _buildSectionContainer(
                context,
                'Personal History',
                [
                  'None',
                  'Aerojjbics',
                  'Smoking',
                  'Tabacco',
                  'Alcohol consumption',
                ],
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVitalItem(String title, String unit, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Container(
          width: 100,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 18,
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
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionContainer(
      BuildContext context, String title, List<String> options) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                title,
                style: GoogleFonts.montserrat(
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 4,
            children: options.map((option) => buildOptionChip(option)).toList(),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget buildOptionChip(String option) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        margin: const EdgeInsets.only(right: 4, bottom: 4),
        decoration: BoxDecoration(
          color: const Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(7),
          border: const Border(
            bottom: BorderSide(width: 1, color: Colors.grey),
            left: BorderSide.none,
            top: BorderSide.none,
            right: BorderSide.none,
          ),
        ),
        child: Text(
          option,
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}*/
