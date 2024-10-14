import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:healtether_clinic_app/constants/constants.dart';
import 'package:healtether_clinic_app/utils/enums/route_enums.dart';

class MedicationHistoryScreen extends StatefulWidget {
  const MedicationHistoryScreen({Key? key}) : super(key: key);

  @override
  State<MedicationHistoryScreen> createState() => _MedicationHistoryScreenState();
}

class _MedicationHistoryScreenState extends State<MedicationHistoryScreen> {
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
                "Medication history",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            GestureDetector(
              onTap: () {
                context.goNamed(AppRoutes.saveMedicationHistory.name);
                // Navigator.push(context, MaterialPageRoute(builder: (context) {
                //   return const SaveMedicationHistoryScreen();
                // }));
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
            padding: const EdgeInsets.only(left: 16.0, right: 16),
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
                buildOptionContainer("Paracetamol 150mg"),
                buildOptionContainer("Insulin"),
                buildOptionContainer("Paracetamol 625mg"),
                buildOptionContainer("Opt 1"),
                buildOptionContainer("Opt 2"),
                buildOptionContainer("Opt 3"),
                buildOptionContainer("Opt 4"),
                buildOptionContainer("Opt 5"),
                buildOptionContainer("Opt 6"),
                buildOptionContainer("Opt 7"),
                buildOptionContainer("Opt 8"),
                buildOptionContainer("Opt 9"),
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
          padding: const EdgeInsets.only(top: 12),
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
    return SingleChildScrollView(
      child: GestureDetector(
        onTap: () {
          setState(() {
            if (isSelected) {
              _selectedDiseases.remove(title);
            } else {
              _selectedDiseases.add(title);
            }
          });
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
