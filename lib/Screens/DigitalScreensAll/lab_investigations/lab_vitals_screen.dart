import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healtether_clinic_app/Screens/DigitalScreensAll/appendectomy_Screen.dart';
import 'package:healtether_clinic_app/Screens/DigitalScreensAll/lab_investigations/cbc_sheet.dart';
import 'package:healtether_clinic_app/Screens/DigitalScreensAll/lab_investigations/lab_investigations_screen.dart';
import 'package:healtether_clinic_app/constants/constants.dart';
import 'package:healtether_clinic_app/constants/app_text.dart';
import 'hemoglobin_sheet.dart';

class LabVitalsScreen extends StatefulWidget {
  const LabVitalsScreen({Key? key}) : super(key: key);

  @override
  State<LabVitalsScreen> createState() => _LabVitalsScreenState();
}

class _LabVitalsScreenState extends State<LabVitalsScreen> {
  List<String> _selectedDiseases = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                "Lab Tests",
                style: GoogleFonts.urbanist(
                  textStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Urbanist',
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LabInvestigationsScreen(
                      selectedTests: [],
                    ),
                  ),
                );

                if (result != null) {
                  setState(() {
                    _selectedDiseases = List<String>.from(result);
                  });
                }
              },
              child: Container(
                width: 70,
                height: 30,
                decoration: BoxDecoration(
                  color: AppColors.greenColor,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Center(
                  child: Text(
                    AppText.save,
                    style: GoogleFonts.urbanist(
                      textStyle: const TextStyle(
                        color: AppColors.whiteColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
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
            padding: const EdgeInsets.only(top: 4.0, bottom: 4, left: 10, right: 10),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 48,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: AppColors.white1Color,
                borderRadius: BorderRadius.circular(2),
              ),
              child: Center(
                child: Row(
                  children: [
                    const Icon(Icons.search),
                    const SizedBox(width: 4),
                    Flexible(
                      child: TextField(
                        style: GoogleFonts.roboto(
                          textStyle: const TextStyle(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            height: 1.2,
                            color: AppColors.blue1Color,
                          ),
                        ),
                        decoration: const InputDecoration.collapsed(
                          hintText: 'Search & select ',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
          const SizedBox(height: 10),
          Expanded(
            child: ListView(
              children: [
                buildOption("Hemoglobin"),
                const SizedBox(height: 8),
                buildOption("TSH"),
                const SizedBox(height: 8),
                buildOption("Lipid Profile"),
                const SizedBox(height: 8),
                buildOption("CBC"),
                const SizedBox(height: 8),
                buildOption("TSH, T1, T2, T3"),
                const SizedBox(height: 8),
                buildOption("CMC"),
                const SizedBox(height: 8),
                buildOption("Test 1"),
                const SizedBox(height: 8),
                buildOption("Test 2"),
                const SizedBox(height: 8),
                buildOption("Test 3"),
                const SizedBox(height: 8),
                buildOption("Test 4"),
                const SizedBox(height: 8),
                buildOption("Test 5"),
                const SizedBox(height: 8),
                buildOption("Test 6"),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildOption(String title) {
    bool isSelected = _selectedDiseases.contains(title);

    return GestureDetector(
      onTap: () async {
        if (title == "Appendectomy") {
          /* showDialog(
            context: context,
            builder: (BuildContext context) {
              return const AppendectomyInput();
            },
          );*/
        } else if (title == "Hemoglobin") {
          await showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (BuildContext context) {
              return const HemoglobinSheet();
            },
          );
          setState(() {
            if (!_selectedDiseases.contains(title)) {
              _selectedDiseases.add(title);
            }
          });
        } else if (title == "CBC") {
          await showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (BuildContext context) {
              return const CBCSheet();
            },
          );
          setState(() {
            if (!_selectedDiseases.contains(title)) {
              _selectedDiseases.add(title);
            }
          });
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
      child: Container(
        height: 50,
        color: const Color(0xffF7F7F7),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: const Color(0xFFA1A1A1)),
                  color: isSelected ? const Color(0xFFFEFEFE) : Colors.transparent,
                ),
                child: isSelected
                    ? const Icon(
                        Icons.check,
                        size: 18,
                        color: Colors.black,
                      )
                    : null,
              ),
              const SizedBox(width: 16),
              Center(
                child: Text(
                  title,
                  style: GoogleFonts.urbanist(
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 17,
                      height: 1.2,
                      color: Color(0xff0C091F),
                    ),
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
