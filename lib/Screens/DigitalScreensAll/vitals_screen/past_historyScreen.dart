import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healtether_clinic_app/Screens/DigitalScreensAll/vitals_screen/smoking_screen.dart';
import 'package:healtether_clinic_app/Screens/DigitalScreensAll/vitals_screen/alcohol_screen.dart';
import 'package:healtether_clinic_app/Screens/DigitalScreensAll/save_past_history_screen.dart';
import 'package:healtether_clinic_app/constants/app_colors.dart';
import 'aerobic_screen.dart';

class PastHistory extends StatefulWidget {
  const PastHistory({Key? key}) : super(key: key);

  @override
  State<PastHistory> createState() => _PastHistoryState();
}

class _PastHistoryState extends State<PastHistory> {
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
            Expanded(
              child: Text(
                'Past history',
                style: GoogleFonts.urbanist(
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF0C091F),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                /*Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SavePastHistoryScreen(),
                    // const VitalDetailScreen()
                  ),
                );*/
              },
              child: Container(
                width: 70,
                height: 30,
                decoration: BoxDecoration(
                  color: const Color(0xFF32856E),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Center(
                  child: Text(
                    'Save',
                    style: GoogleFonts.urbanist(
                      textStyle: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w500),
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
                          hintText: 'Search & select disease ',
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
                buildOption("TB"),
                // CustomDivider(),
                const SizedBox(
                  height: 8,
                ),
                buildOption("Cardiovascular"),
                // CustomDivider(),
                const SizedBox(
                  height: 8,
                ),
                buildOption("Hemophilia-A"),
                // CustomDivider(),
                const SizedBox(
                  height: 8,
                ),
                buildOption("Diabetics"),
                // CustomDivider(),
                const SizedBox(
                  height: 8,
                ),
                buildOption("Hepatitis"),
                const SizedBox(
                  height: 8,
                ),
                buildOption("Gastrointestinal"),
                // CustomDivider(),
                const SizedBox(
                  height: 8,
                ),
                buildOption("Asthma"),
                // CustomDivider(),
                const SizedBox(
                  height: 8,
                ),
                buildOption("Epilepsy"),
                // CustomDivider(),
                const SizedBox(
                  height: 8,
                ),
                buildOption("Sickle Cell"),
                // CustomDivider(),
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
      onTap: () {
        if (title == "Diabetics") {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(title: Text("Redundant screen"));
              // return DiabeticsScreen(title: title);
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
        }
      },
      child: Container(
        height: 50,
        decoration: const BoxDecoration(
          color: Color(0xFFF8F7FC),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          children: [
            InkWell(
              onTap: () {
                if (title == "Aerobics") {
                  _showAerobicScreen(context);
                } else if (title == "Smoking") {
                  _showSmokingScreen(context);
                } else if (title == "Alcohol consumption") {
                  _showAlcoholScreen(context);
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
                style: GoogleFonts.urbanist(
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 17,
                    height: 1.2,
                    color: Color(0xFF000000),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: Container(
        height: 1.0,
        margin: const EdgeInsets.symmetric(vertical: 16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2.0),
          gradient: const LinearGradient(
            colors: [Color(0xFFFFFFFF), Color(0xFFE0E0E0)],
            stops: [0.0, 5.0],
          ),
        ),
      ),
    );
  }
}

void _showAerobicScreen(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return AerobicScreen();
    },
  );
}

void _showSmokingScreen(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return SmokingScreen();
    },
  );
}

void _showAlcoholScreen(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return AlcoholScreen();
    },
  );
}
