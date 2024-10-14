/*import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healtether_clinic_app/Screens/DigitalScreensAll/vitals_screen/VitalsGeneralScreen.dart';
import 'package:healtether_clinic_app/Screens/DigitalScreensAll/vitals_screen/vitals_save_data_screen.dart';
import 'package:healtether_clinic_app/Screens/DigitalScreensAll/vitals_screen/vitals_screen.dart';
import 'package:healtether_clinic_app/Screens/DigitalScreensAll/medication_history_screen.dart';
import 'package:healtether_clinic_app/Screens/DigitalScreensAll/past_medical_procedures.dart';
import 'package:healtether_clinic_app/Screens/DigitalScreensAll/patient_%20suffering_from_%20allergies_screen.dart';
import 'package:healtether_clinic_app/Screens/DigitalScreensAll/patient_having_phobias_screen.dart';
import 'package:healtether_clinic_app/constants/app_colors.dart';
import 'package:healtether_clinic_app/constants/app_text.dart';
import 'vitals_screen/past_historyScreen.dart';
import 'family_history_screen.dart';

class SavePastHistoryScreen extends StatefulWidget {
  const SavePastHistoryScreen({Key? key}) : super(key: key);

  @override
  State<SavePastHistoryScreen> createState() => _SavePastHistoryScreenState();
}

class _SavePastHistoryScreenState extends State<SavePastHistoryScreen> {
  List<String> selectedFamilyHistory = [];
  List<String> selectedPastMedicalProcedures = [];
  List<String> selectedAllergies = [];
  List<String> selectedFears = [];
  List<String> selectedMedicationHistory = [];
  Map<String, bool> showOtherContainer = {
    'Family History': false,
    'Past medical procedures': false,
    'Allergies': false,
    'Phobias/Fears': false,
    'Medication History': false,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
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
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'MEDICAL CONDITION INVESTIGATION',
                    style: GoogleFonts.urbanist(
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
                    const PastHistory(),
                    selectedFamilyHistory,
                    false,
                  ),
                  const SizedBox(height: 12),
                  buildSectionContainer(
                    'Family History',
                    ['None', 'Sickle Cell', 'Hemophilia-A', 'Epilepsy', 'Asthma', 'Other'],
                    context,
                    const FamilyHistoryScreen(),
                    selectedFamilyHistory,
                    showOtherContainer['Family History']!,
                  ),
                  const SizedBox(height: 12),
                  buildSectionContainer(
                    'Past medical procedures',
                    ['None', 'Appendectomy', 'Opt 1', 'Opt 2', 'Other'],
                    context,
                    const PastMedicalProcedures(),
                    selectedPastMedicalProcedures,
                    showOtherContainer['Past medical procedures']!,
                  ),
                  const SizedBox(height: 12),
                  buildSectionContainer(
                    'Allergies',
                    [
                      'None',
                      'Dust',
                      'Pollen',
                      'Sunlight',
                      // 'Nuts',
                      'Anesthesia',
                      // 'Berries',
                      'Other'
                    ],
                    context,
                    const PatientSufferingFromAllergiesScreen(),
                    selectedAllergies,
                    showOtherContainer['Allergies']!,
                  ),
                  const SizedBox(height: 12),
                  buildSectionContainer(
                    'Phobias/Fears',
                    ['None', 'Claustrophobia - closed space', 'Aichmophobia - sharp objects', 'Other'],
                    context,
                    const PatientHavingPhobiasScreen(),
                    selectedFears,
                    showOtherContainer['Phobias/Fears']!,
                  ),
                  const SizedBox(height: 12),
                  buildSectionContainer(
                    'Medication History',
                    ['None', 'Paracetamol', 'Insulin', 'Diclofenac', 'Other'],
                    context,
                    const MedicationHistoryScreen(),
                    selectedMedicationHistory,
                    showOtherContainer['Medication History']!,
                  ),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildButton('Clear', const Color(0xFFF5F5F5)),
                  const SizedBox(width: 8),
                  GestureDetector(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Past Medical History have been saved successfully.'),
                          ),
                        );
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return const VitalsScreen(
                            appointmentId: '',
                          );
                        }));
                      },
                      child: buildButton('Add Vitals', AppColors.greenColor)),
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
    List<String> selectedOptions,
    bool showOther,
  ) {
    Color containerColor;
    if (title == 'Past history') {
      containerColor = const Color(0xFFE1F9F2);
    } else {
      containerColor = AppColors.whiteColor;
    }

    return Container(
      padding: const EdgeInsets.all(16.0),
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
              if (title == 'Past history' && navigateScreen != null) {
                Navigator.push(context, MaterialPageRoute(builder: (context) => navigateScreen));
              }
            },
            child: Row(
              children: [
                Text(
                  title,
                  style: GoogleFonts.urbanist(
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
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
                        if (navigateScreen != null && title == 'Past history') {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => navigateScreen));
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
            spacing: 4,
            children: options.map((option) => buildOptionChip(context, option, title, selectedOptions)).toList(),
          ),
          if (showOther)
            Container(
              height: 50,
              decoration: const BoxDecoration(
                color: Color(0xFFF5F5F5),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                children: buildOtherOptions(title),
              ),
            ),
        ],
      ),
    );
  }

  Widget buildOptionChip(BuildContext context, String option, String section, List<String> selectedOptions) {
    bool isSelected = selectedOptions.contains(option);

    Color chipColor = section == 'Past history'
        ? const Color(0xFFAFE9D9)
        : isSelected
            ? AppColors.greenColor
            : AppColors.white1Color;

    Color textColor = isSelected ? Colors.white : AppColors.blackColor;
    void onDelete() {
      print('Deleted: $option');
    }

    return GestureDetector(
      onTap: () {
        if (section != 'Past history') {
          setState(() {
            if (isSelected) {
              selectedOptions.remove(option);
            } else {
              selectedOptions.add(option);
            }
            if (option == 'Other') {
              showOtherContainer[section] = !showOtherContainer[section]!;
            }
          });
        }
        print('Tapped on: $option');
      },
      child: Chip(
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              option,
              style: TextStyle(fontSize: 12, color: textColor),
            ),
            if (section == 'Past history') ...[
              const SizedBox(width: 4),
              GestureDetector(
                onTap: onDelete,
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
          ],
        ),
        backgroundColor: chipColor,
        side: BorderSide.none,
      ),
    );
  }

  List<Widget> buildOtherOptions(String section) {
    switch (section) {
      case 'Family History':
        return [
          const Row(
            children: [Text('Procedure 1, time period')],
          ),
          // buildOptionChip(context, 'Sickle Cell', section, selectedFamilyHistory),
          // buildOptionChip(context, 'Hemophilia-A', section, selectedFamilyHistory),
        ];
      case 'Past medical procedures':
        return [
          const Row(
            children: [Text('Procedure 1, time period')],
          ),
        ];
      case 'Allergies':
        return [
          const Row(
            children: [Text('Allergy 1, Allergy 2')],
          ),
        ];
      case 'Phobias/Fears':
        return [
          const Row(
            children: [Text('Phobia 1 ,Phobia 2')],
          ),
        ];
      case 'Medication History':
        return [
          buildOptionChip(context, 'Med 1,', section, selectedMedicationHistory),
          buildOptionChip(context, 'Med 2', section, selectedMedicationHistory),
        ];
      default:
        return [];
    }
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
            color: color == const Color(0xFFF5F5F5) ? Colors.black : Colors.white,
          ),
        ),
      ),
    );
  }
}*/
