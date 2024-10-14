/*import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healtether_clinic_app/Screens/DigitalScreensAll/vitals_screen/vitals_screen.dart';
import 'package:healtether_clinic_app/Screens/DigitalScreensAll/family_history_screen.dart';
import 'package:healtether_clinic_app/Screens/DigitalScreensAll/medication_history_screen.dart';
import 'package:healtether_clinic_app/Screens/DigitalScreensAll/past_history_screen.dart';
import 'package:healtether_clinic_app/Screens/DigitalScreensAll/past_medical_procedures.dart';
import 'package:healtether_clinic_app/Screens/DigitalScreensAll/patient_%20suffering_from_%20allergies_screen.dart';
import 'package:healtether_clinic_app/Screens/DigitalScreensAll/patient_having_phobias_screen.dart';
import 'package:healtether_clinic_app/constants/app_colors.dart';
import 'package:healtether_clinic_app/constants/app_text.dart';

class SavePastMedicalProceduresScreen extends StatefulWidget {
  const SavePastMedicalProceduresScreen({Key? key}) : super(key: key);

  @override
  State<SavePastMedicalProceduresScreen> createState() =>
      _SavePastMedicalProceduresScreenState();
}

class _SavePastMedicalProceduresScreenState
    extends State<SavePastMedicalProceduresScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        leadingWidth: 30,
        automaticallyImplyLeading: false,
        title: Text(
          AppText.digitalPrescription,
          style: GoogleFonts.montserrat(
            textStyle: const TextStyle(
              fontSize: 18,
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
          icon: const Icon(Icons.arrow_back),
        ),
        backgroundColor: const Color(0xFFE6FFFE),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 80.0),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'MEDICAL CONDITION INVESTIGATION',
                    style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.blackColor,
                      ),
                    ),
                  ),
                  const Divider(
                    thickness: 1,
                    height: 2,
                    color: AppColors.blackColor,
                  ),
                  const SizedBox(height: 12),
                  buildSectionContainer(
                    'Past history',
                    [
                      'Diabetics',
                      'Cardiovascular',
                      'Gastrointestinal',
                    ],
                    context,
                    const PastHistoryScreen(),
                  ),
                  const SizedBox(height: 12),
                  buildSectionContainer(
                    'Family History',
                    [
                      'Sickle Cell - Father, grandfather, brother',
                      'Asthma - Mother',
                    ],
                    context,
                    const FamilyHistoryScreen(),
                  ),
                  const SizedBox(height: 12),
                  buildSectionContainer(
                    'Past medical procedures',
                    ['Appendectomy', '2005'],
                    context,
                    const PastMedicalProcedures(),
                  ),
                  const SizedBox(height: 12),
                  buildSectionContainer(
                      'Allergies',
                      [
                        'None',
                        'Dust',
                        'Pollen',
                        'Sunlight',
                        'Nuts',
                        'Anesthesia',
                        'Berries',
                        'Other'
                      ],
                      context,
                      const PatientSufferingFromAllergiesScreen() // No specific screen to navigate to
                      ),
                  const SizedBox(height: 12),
                  buildSectionContainer(
                    'Phobias/Fears',
                    [
                      'None',
                      'Claustrophobia - closed space',
                      'Aichmophobia - sharp objects',
                      'Other'
                    ],
                    context, const PatientHavingPhobiasScreen(),
                    // No specific screen to navigate to
                  ),
                  const SizedBox(height: 12),
                  buildSectionContainer(
                      'Medication History',
                      ['None', 'Paracetamol', 'Insulin', 'Diclofenac', 'Other'],
                      context,
                      const MedicationHistoryScreen()),
                  const SizedBox(height: 150),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.grey.shade50,
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildButton('Clear', AppColors.greenColor),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const VitalsScreen(
                          appointmentId: '',
                        );
                      }));
                    },
                    child: buildButton(
                      'Add Vitals',
                      const Color(0xFFF5F5F5),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSectionContainer(
    String title,
    List<String> options,
    BuildContext context,
    Widget? navigateScreen,
  ) {
    Color containerColor;
    if (title == 'Past history' || title == 'Family History') {
      containerColor = const Color(0xFFE6FFFE);
    } else {
      containerColor = AppColors.whiteColor;
    }

    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: containerColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              if (navigateScreen != null) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => navigateScreen));
              }
            },
            child: Row(
              children: [
                Text(
                  title,
                  style: GoogleFonts.montserrat(
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.blackColor,
                    ),
                  ),
                ),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (navigateScreen != null) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => navigateScreen));
                        }
                      },
                      child: Text(
                        AppText.add,
                        style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: AppColors.greenColor,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 2,
                      width: 40,
                      color: AppColors.greenColor,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 1),
          Wrap(
            spacing: 8,
            children: options.map((option) {
              if (title == 'Past medical procedures' && option == '2005') {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    buildOptionChip(context, option, title),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: () {
                        if (kDebugMode) {
                          print('Closing chip: $option');
                        }
                      },
                      child: Container(
                        width: 18,
                        height: 18,
                        decoration: BoxDecoration(
                          color: const Color(0xFFE7E7E7),
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: const Icon(
                          Icons.close,
                          size: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return buildOptionChip(context, option, title);
              }
            }).toList(),
          )
        ],
      ),
    );
  }

  Widget buildOptionChip(BuildContext context, String option, String section) {
    Color chipColor = (section == 'Past history' ||
            section == 'Family History' ||
            section == 'Past medical procedures')
        ? const Color(0xFFAFE9D9)
        : AppColors.white1Color;

    void navigateToScreen() {
      if (section == 'Past medical procedures') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const PastMedicalProcedures(),
          ),
        );
      } else if (section == 'Family History') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const FamilyHistoryScreen(),
          ),
        );
      } else if (section == 'Past history') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const PastHistoryScreen(),
          ),
        );
      }
    }

    return GestureDetector(
      onTap: () {
        if (option == 'Other') {
          navigateToScreen();
        } else {
          if (kDebugMode) {
            print('Tapped on: $option');
          }
        }
      },
      child: Chip(
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              option,
              style: const TextStyle(fontSize: 14),
            ),
            if (section == 'Past history' || section == 'Family History') ...[
              const SizedBox(width: 4),
              Container(
                width: 18,
                height: 18,
                decoration: BoxDecoration(
                  color: const Color(0xFFE7E7E7),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: const Icon(
                  Icons.close,
                  size: 16,
                  color: Colors.black,
                ),
              ),
            ],
          ],
        ),
        backgroundColor: chipColor,
        side: BorderSide.none,
      ),
    );
  }

  Widget buildButton(String label, Color color) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.4,
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(7),
      ),
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color:
                color == const Color(0xFFF5F5F5) ? Colors.black : Colors.white,
          ),
        ),
      ),
    );
  }
}*/
