/*import 'package:flutter/material.dart';
import 'package:healtether_clinic_app/Screens/DigitalScreensAll/custom_divider.dart';
import 'package:healtether_clinic_app/Screens/DigitalScreensAll/save_past_history_screen.dart';
import 'package:healtether_clinic_app/Screens/DigitalScreensAll/save_patient_having_phobias_screen.dart';
import 'package:healtether_clinic_app/constants/app_colors.dart';
import 'package:healtether_clinic_app/constants/app_text.dart';

class PatientHavingPhobiasScreen extends StatefulWidget {
  const PatientHavingPhobiasScreen({Key? key}) : super(key: key);

  @override
  State<PatientHavingPhobiasScreen> createState() =>
      _PatientHavingPhobiasScreenState();
}

class _PatientHavingPhobiasScreenState
    extends State<PatientHavingPhobiasScreen> {
  final List<String> _selectedDiseases = [];
  bool isSelected = false;

  void _toggleSelected() {
    setState(() {
      isSelected = !isSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Expanded(
              child: Text(
                "Phobias",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const SavePastHistoryScreen();
                }));
              },
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const SavePatientHavingPhobiasScreen();
                  }));
                },
                child: Container(
                  width: 70,
                  height: 35,
                  decoration: BoxDecoration(
                    color: const Color(0xFF32856E),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Center(
                    child: Text(
                      AppText.save,
                      style:
                          TextStyle(color: AppColors.whiteColor, fontSize: 14),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 48,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: Row(
                  children: [
                    Icon(Icons.search),
                    SizedBox(width: 4),
                    Flexible(
                      child: TextField(
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          height: 1.2,
                          color: AppColors.blue1Color,
                        ),
                        decoration: InputDecoration.collapsed(
                          hintText: 'Search & select disease',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16),
            child: Text(
              "${_selectedDiseases.length} selected",
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
                fontSize: 16,
                height: 1.2,
                color: Color(0xFFA5A5A5),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView(
              children: [
                buildOptionContainer("Claustrophobia - closed space"),
                buildOptionContainer("Opt 1"),
                buildOptionContainer("Opt 2"),
                buildOptionContainer("Opt 3"),
                buildOptionContainer("Opt 4"),
                buildOptionContainer("Opt 5"),
                buildOptionContainer("Opt 6"),
                buildOptionContainer("Opt 7"),
                buildOptionContainer("Opt 8"),
                buildOptionContainer("Opt 9"),
                buildOptionContainer("Opt 10"),
                buildOptionContainer("Opt 11"),
                buildOptionContainer("Opt 12"),
                buildOptionContainer("Opt 13"),
                buildOptionContainer("Opt 14"),
                buildOptionContainer("Opt 15"),
                buildOptionContainer("Opt 16"),
                buildOptionContainer("Opt 17"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildOptionContainer(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: const Color(0xffF7F7F7),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Column(
            children: [
              buildOption(title),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildOption(String title) {
    bool isSelected = _selectedDiseases.contains(title);
    return GestureDetector(
      onTap: () {
        if (title == "Diabetics") {
          // _showDiabeticsScreen();
        } else {
          setState(() {
            if (isSelected) {
              _selectedDiseases.remove(title);
            } else {
              _selectedDiseases.add(title);
            }
          });
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  if (isSelected) {
                    _selectedDiseases.remove(title);
                  } else {
                    _selectedDiseases.add(title);
                  }
                });
              },
              borderRadius: BorderRadius.circular(50),
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color: const Color(0xFFA1A1A1),
                  ),
                  color:
                      isSelected ? const Color(0xFFFEFEFE) : Colors.transparent,
                ),
                child: isSelected
                    ? const Icon(
                        Icons.check,
                        size: 18,
                        color: Colors.black,
                      )
                    : null,
              ),
            ),
            const SizedBox(width: 16),
            Center(
              child: Text(
                title,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  fontSize: 17,
                  height: 1.2,
                  color: Color(0xFF000000),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}*/
