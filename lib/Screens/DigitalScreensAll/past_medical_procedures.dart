import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:healtether_clinic_app/Screens/DigitalScreensAll/appendectomy_Screen.dart';
import 'package:healtether_clinic_app/Screens/DigitalScreensAll/save_past_medical_procedures_screen.dart';
import 'package:healtether_clinic_app/constants/app_colors.dart';
import 'package:healtether_clinic_app/constants/app_text.dart';
import 'package:healtether_clinic_app/utils/enums/route_enums.dart';

class PastMedicalProcedures extends StatefulWidget {
  const PastMedicalProcedures({Key? key}) : super(key: key);

  @override
  State<PastMedicalProcedures> createState() => _PastMedicalProceduresState();
}

class _PastMedicalProceduresState extends State<PastMedicalProcedures> {
  final List<String> _selectedDiseases = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Expanded(
              child: Text(
                AppText.pastMedicalProcedures,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            GestureDetector(
              onTap: () {
                context.goNamed(AppRoutes.savePastMedicalProcedures.name);
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) =>
                //         const SavePastMedicalProceduresScreen(),
                //   ),
                // );
              },
              child: Container(
                width: 70,
                height: 35,
                decoration: BoxDecoration(
                  color: AppColors.greenColor,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Center(
                  child: Text(
                    AppText.save,
                    style: TextStyle(color: AppColors.whiteColor, fontSize: 14),
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
            padding: const EdgeInsets.all(16.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 48,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: AppColors.white1Color,
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
                          hintText: 'Search & select procedure',
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
          const SizedBox(height: 16),
          Expanded(
            child: ListView(
              children: [
                buildOption("Appendectomy"),
                //CustomDivider(),

                const SizedBox(
                  height: 8,
                ),
                buildOption("Opt 1"),
                // CustomDivider(),

                const SizedBox(
                  height: 8,
                ),
                buildOption("Opt 2"),
                // CustomDivider(),

                const SizedBox(
                  height: 8,
                ),
                buildOption("Opt 3"),
                // CustomDivider(),

                const SizedBox(
                  height: 8,
                ),
                buildOption("Opt 4"),
                // CustomDivider(),

                const SizedBox(
                  height: 8,
                ),
                buildOption("Opt 5"),
                // CustomDivider(),

                const SizedBox(
                  height: 8,
                ),
                buildOption("Opt 6"),
                // CustomDivider(),

                const SizedBox(
                  height: 8,
                ),
                buildOption("Opt 7"),
                // CustomDivider(),

                const SizedBox(
                  height: 8,
                ),
                buildOption("Opt 8"),
                // CustomDivider(),

                const SizedBox(
                  height: 8,
                ),
                buildOption("Opt 9"),
                // CustomDivider(),

                const SizedBox(
                  height: 8,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildOption(String title) {
    bool isSelected = _selectedDiseases.contains(title);

    return Container(
      height: 50,
      color: const Color(0xffF7F7F7),
      child: GestureDetector(
        onTap: () {
          if (title == "Appendectomy") {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return const AppendectomyInput();
              },
            );
          } else {
            setState(() {
              if (isSelected) {
                _selectedDiseases.remove(title);
              } else {
                _selectedDiseases.add(title);
              }
            });

            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text("Option Tapped"),
                  content: Text("$title was tapped"),
                  actions: [
                    TextButton(
                      child: const Text("OK"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                    color: AppColors.black1Color,
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
