/*import 'dart:async';
import 'dart:io';
import 'package:healtether_clinic_app/Screens/DigitalScreensAll/vitals_screen/vitals_detail_screen.dart';
import 'package:healtether_clinic_app/Screens/DigitalScreensAll/save_medication_history_screen.dart';
import 'package:healtether_clinic_app/data_layer/services/create_symptoms_service/create_symptoms_service.dart';
import 'package:healtether_clinic_app/Screens/DigitalScreensAll/symptoms_diagnosis/bottom_sheet.dart';
import 'package:healtether_clinic_app/Screens/DigitalScreensAll/symptoms_diagnosis/create_digital_presscription_screen.dart';
import 'package:healtether_clinic_app/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SxAndDxScreen extends StatefulWidget {
  const SxAndDxScreen({super.key});

  @override
  State<SxAndDxScreen> createState() => _SxAndDxScreenState();
}

class _SxAndDxScreenState extends State<SxAndDxScreen> {
  final List<String> _selectedSx = [];
  final List<String> _selectedDx = [];
  List<String> _associatedSymptomsList = [];
  List<String> _differentialDiagnosesList = [];
  bool isSelected = false;
  TextEditingController searchController = TextEditingController();
  List<String> _symptomsList = [];
  List<String> _diagnosesList = [];
  bool isSearching = false;
  Map<String, dynamic> apiResponse = {};
  List<String> _sxList = ['Seizures', 'Headache', 'Fever'];
  List<String> _filteredSxList = [];

  CreateSymptomsService createSymptomsService = CreateSymptomsService();

  void _toggleSelected() {
    setState(() {
      isSelected = !isSelected;
    });
  }

  @override
  void initState() {
    super.initState();
    isSelected = !isSelected;
    _loadSavedValue();
  }

  Future<void> _loadSavedValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedValue = prefs.getString('savedValue');
    setState(() {
      searchController.text = savedValue ?? '';
    });
  }

  Future<void> _searchSymptoms() async {
    if (searchController.text.isNotEmpty) {
      setState(() {
        isSearching = true;
      });
      try {
        final result = await createSymptomsService
            .createSymptoms(
              searchController.text,
              _selectedSx,
              _selectedDx,
            )
            .timeout(const Duration(seconds: 10));

        setState(() {
          _symptomsList = result['symptoms'] ?? [];
          _diagnosesList = result['diagnoses'] ?? [];
          _associatedSymptomsList = result['associatedSymptoms'] ?? [];
          _differentialDiagnosesList = result['differentialDiagnoses'] ?? [];
          isSearching = false;
        });

        if (_associatedSymptomsList.isNotEmpty) {
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('No associated symptoms found.'),
            ),
          );
        }
      } on TimeoutException {
        setState(() {
          isSearching = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Request timed out. Please try again.'),
          ),
        );
      } on SocketException {
        setState(() {
          isSearching = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Network unreachable. Please check your connection.'),
          ),
        );
      } catch (error) {
        setState(() {
          isSearching = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $error'),
          ),
        );
      }
    } else {
      setState(() {
        isSearching = false;
      });
    }
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _toggleDrawer() {
    setState(() {
      if (_isDrawerOpen) {
        Navigator.of(context).pop();
      } else {
        _scaffoldKey.currentState?.openEndDrawer();
      }
    });
  }

  void _showMinimumSymptomsMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Please select at least 3 symptoms to proceed.'),
      ),
    );
  }

  void _openAffirmationsSheet(String sx) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return AffirmationsSheet(itemName: sx);
      },
    );
  }

  // Widget _buildResults() {
  //   return Row(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Expanded(
  //         child: Column(
  //           children: _symptomsList
  //               .map((symptom) => ListTile(
  //             title: Row(
  //               children: [
  //                 Transform.scale(
  //                   scale: 0.9,
  //                   child: Checkbox(
  //                     shape: ContinuousRectangleBorder(
  //                         borderRadius: BorderRadius.circular(8)),
  //                     value: _selectedSx.contains(symptom),
  //                     activeColor: const Color(0xFFA1A1A1),
  //                     side: MaterialStateBorderSide.resolveWith(
  //                           (states) => const BorderSide(
  //                         width: 2.0,
  //                         color: Color(0xFFA1A1A1),
  //                       ),
  //                     ),
  //                     onChanged: (bool? value) {
  //                       setState(() {
  //                         if (value == true) {
  //                           _selectedSx.add(symptom);
  //                         } else {
  //                           _selectedSx.remove(symptom);
  //                         }
  //                       });
  //                     },
  //                   ),
  //                 ),
  //                 Expanded(
  //                   child: Container(
  //                     padding: const EdgeInsets.only(
  //                         left: 4, top: 8, bottom: 8),
  //                     height: 40,
  //                     color: const Color(0xffF7F7F7),
  //                     child: Text(
  //                       symptom,
  //                       overflow: TextOverflow.ellipsis,
  //                     ),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //             onTap: () {
  //               setState(() {
  //                 if (_selectedSx.contains(symptom)) {
  //                   _selectedSx.remove(symptom);
  //                 } else {
  //                   _selectedSx.add(symptom);
  //                 }
  //               });
  //             },
  //             selected: _selectedSx.contains(symptom),
  //           ))
  //               .toList(),
  //         ),
  //       ),
  //       Expanded(
  //         child: Column(
  //           children: _diagnosesList
  //               .map((diagnosis) => ListTile(
  //             title: Row(
  //               children: [
  //                 Transform.scale(
  //                   scale: 0.9,
  //                   child: Checkbox(
  //                     shape: ContinuousRectangleBorder(
  //                         borderRadius: BorderRadius.circular(8)),
  //                     value: _selectedDx.contains(diagnosis),
  //                     activeColor: const Color(0xFFA1A1A1),
  //                     side: MaterialStateBorderSide.resolveWith(
  //                           (states) => const BorderSide(
  //                         width: 2.0,
  //                         color: Color(0xFFA1A1A1),
  //                       ),
  //                     ),
  //                     onChanged: (bool? value) {
  //                       setState(() {
  //                         if (value == true) {
  //                           _selectedDx.add(diagnosis);
  //                         } else {
  //                           _selectedDx.remove(diagnosis);
  //                         }
  //                       });
  //                     },
  //                   ),
  //                 ),
  //                 Expanded(
  //                   child: Container(
  //                     padding: const EdgeInsets.only(
  //                         left: 4, top: 8, bottom: 8),
  //                     height: 40,
  //                     color: const Color(0xffF7F7F7),
  //                     child: Text(
  //                       diagnosis,
  //                       overflow: TextOverflow.ellipsis,
  //                     ),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //             onTap: () {
  //               setState(() {
  //                 if (_selectedDx.contains(diagnosis)) {
  //                   _selectedDx.remove(diagnosis);
  //                 } else {
  //                   _selectedDx.add(diagnosis);
  //                 }
  //               });
  //             },
  //             selected: _selectedDx.contains(diagnosis),
  //           ))
  //               .toList(),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  Widget _buildResults() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            children: _symptomsList
                .map((symptom) => ListTile(
                      title: Row(
                        children: [
                          Transform.scale(
                            scale: 0.9,
                            child: Checkbox(
                              shape: ContinuousRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              value: _selectedSx.contains(symptom),
                              activeColor: const Color(0xFFA1A1A1),
                              side: MaterialStateBorderSide.resolveWith(
                                (states) => const BorderSide(
                                  width: 2.0,
                                  color: Color(0xFFA1A1A1),
                                ),
                              ),
                              onChanged: (bool? value) {
                                setState(() {
                                  if (value == true) {
                                    _selectedSx.add(symptom);
                                  } else {
                                    _selectedSx.remove(symptom);
                                  }
                                });
                              },
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.only(
                                  left: 4, top: 8, bottom: 8),
                              height: 40,
                              color: const Color(0xffF7F7F7),
                              child: Text(
                                symptom,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        _openAffirmationsSheet(
                            symptom); // Show the bottom sheet
                      },
                      selected: _selectedSx.contains(symptom),
                    ))
                .toList(),
          ),
        ),
        Expanded(
          child: Column(
            children: _diagnosesList
                .map((diagnosis) => ListTile(
                      title: Row(
                        children: [
                          Transform.scale(
                            scale: 0.9,
                            child: Checkbox(
                              shape: ContinuousRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              value: _selectedDx.contains(diagnosis),
                              activeColor: const Color(0xFFA1A1A1),
                              side: MaterialStateBorderSide.resolveWith(
                                (states) => const BorderSide(
                                  width: 2.0,
                                  color: Color(0xFFA1A1A1),
                                ),
                              ),
                              onChanged: (bool? value) {
                                setState(() {
                                  if (value == true) {
                                    _selectedDx.add(diagnosis);
                                  } else {
                                    _selectedDx.remove(diagnosis);
                                  }
                                });
                              },
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.only(
                                  left: 4, top: 8, bottom: 8),
                              height: 40,
                              color: const Color(0xffF7F7F7),
                              child: Text(
                                diagnosis,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        _openAffirmationsSheet(
                            diagnosis); // Show the bottom sheet
                      },
                      selected: _selectedDx.contains(diagnosis),
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }

  final bool _isDrawerOpen = false;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      key: _scaffoldKey,
      endDrawer: SizedBox(
        height: 600,
        child: Drawer(
          width: 320,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: height * 0.64,
                  child: Material(
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20)),
                    elevation: 6,
                    shadowColor: const Color(0xffFFFFFF),
                    color: const Color(0xffFFFFFF),
                    surfaceTintColor: const Color(0xffFFFFFF),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Vitals',
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff0C091F)),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const VitalDetailScreen(),
                                    ),
                                  );
                                },
                                child: Column(
                                  children: [
                                    const Text(
                                      'Edit',
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xff5351C7)),
                                    ),
                                    Container(
                                      height: 1,
                                      width: 30,
                                      decoration: const BoxDecoration(
                                        color: Color(0xff5351C7),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.only(left: 4),
                                  height: 75,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: const Color(0xffF5F5F5),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'SpO2',
                                        style: GoogleFonts.roboto(
                                          textStyle: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xff413D56),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Center(
                                        child: Image.asset(
                                            "assets/homeimages/Vector (4).png"),
                                      ),
                                      const SizedBox(height: 4),
                                      Center(
                                        child: Text(
                                          '97',
                                          style: GoogleFonts.roboto(
                                            textStyle: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xff0C091F),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 6),
                              Expanded(
                                child: Container(
                                  height: 75,
                                  padding: const EdgeInsets.only(left: 4),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: const Color(0xffF5F5F5),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'BP',
                                        style: GoogleFonts.roboto(
                                          textStyle: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xff413D56),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Center(
                                        child: Image.asset(
                                            "assets/homeimages/Vector (5).png"),
                                      ),
                                      const SizedBox(height: 4),
                                      Center(
                                        child: Text(
                                          '80/120',
                                          style: GoogleFonts.roboto(
                                            textStyle: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xff0C091F),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 6),
                              Expanded(
                                child: Container(
                                  height: 75,
                                  padding: const EdgeInsets.only(left: 4),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: const Color(0xffF5F5F5),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Heart rate',
                                        style: GoogleFonts.roboto(
                                          textStyle: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xff413D56),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Center(
                                        child: Image.asset(
                                            "assets/homeimages/Vector (6).png"),
                                      ),
                                      const SizedBox(height: 4),
                                      Center(
                                        child: Text(
                                          '80',
                                          style: GoogleFonts.roboto(
                                            textStyle: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xff0C091F),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 6),
                              Expanded(
                                child: Container(
                                  height: 75,
                                  padding: const EdgeInsets.only(left: 4),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: const Color(0xffF5F5F5),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'BG',
                                        style: GoogleFonts.roboto(
                                          textStyle: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xff413D56),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Center(
                                        child: Image.asset(
                                            "assets/homeimages/droplet-outline.png"),
                                      ),
                                      const SizedBox(height: 4),
                                      Center(
                                        child: Text(
                                          '150',
                                          style: GoogleFonts.roboto(
                                            textStyle: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xff0C091F),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.only(right: 152),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 75,
                                    padding: const EdgeInsets.only(left: 4),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: const Color(0xffF5F5F5),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Ht',
                                          style: GoogleFonts.roboto(
                                            textStyle: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xff413D56),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Center(
                                          child: Image.asset(
                                              "assets/homeimages/Vector (7).png"),
                                        ),
                                        const SizedBox(height: 4),
                                        Center(
                                          child: Text(
                                            '160',
                                            style: GoogleFonts.roboto(
                                              textStyle: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xff0C091F),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Expanded(
                                  child: Container(
                                    height: 75,
                                    padding: const EdgeInsets.only(left: 4),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: const Color(0xffF5F5F5),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Wt',
                                          style: GoogleFonts.roboto(
                                            textStyle: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xff413D56),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Center(
                                          child: Image.asset(
                                              "assets/homeimages/Vector (8).png"),
                                        ),
                                        const SizedBox(height: 4),
                                        Center(
                                          child: Text(
                                            '60',
                                            style: GoogleFonts.roboto(
                                              textStyle: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xff0C091F),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: height * 0.06),
                Material(
                  elevation: 8,
                  shadowColor: const Color(0xFFFFFFFF),
                  surfaceTintColor: const Color(0xFFFFFFFF),
                  color: const Color(0xFFFFFFFF),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Past History',
                              style: GoogleFonts.urbanist(
                                textStyle: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff0C091F),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SaveMedicationHistoryScreen()));
                              },
                              child: Column(
                                children: [
                                  const Text(
                                    'Edit',
                                    style: TextStyle(
                                      fontFamily: 'Urbanist',
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xff5351C7),
                                    ),
                                  ),
                                  Container(
                                    height: 1,
                                    width: 30,
                                    decoration: const BoxDecoration(
                                      color: Color(0xff5351C7),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),
                        Text(
                          'Family History',
                          style: GoogleFonts.urbanist(
                            textStyle: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff868686),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          width: width,
                          height: 40,
                          padding: const EdgeInsets.only(top: 10, left: 10),
                          decoration: const BoxDecoration(
                            color: Color(0xffF7F7F7),
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                          child: const Text(
                            'Asthma, Hypertension',
                            style: TextStyle(
                              fontFamily: 'Urbanist',
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff0C091F),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Medical Procedures',
                          style: TextStyle(
                            fontFamily: 'Urbanist',
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff868686),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          width: width,
                          height: 40,
                          padding: const EdgeInsets.only(top: 10, left: 10),
                          decoration: const BoxDecoration(
                            color: Color(0xffF7F7F7),
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                          child: const Text(
                            'Heart Surgery',
                            style: TextStyle(
                              fontFamily: 'Urbanist',
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff0C091F),
                            ),
                          ),
                          // onTap: () {},
                          // contentPadding: const EdgeInsets.symmetric(
                          //     horizontal: 10.0, vertical: 2.0),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Medication',
                          style: TextStyle(
                            fontFamily: 'Urbanist',
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff868686),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          width: width,
                          height: 40,
                          padding: const EdgeInsets.only(top: 10, left: 10),
                          decoration: const BoxDecoration(
                            color: Color(0xffF7F7F7),
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                          child: const Text(
                            'Dolo - 650, Paracetomol',
                            style: TextStyle(
                              fontFamily: 'Urbanist',
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff0C091F),
                            ),
                          ),
                          // onTap: () {},
                          // contentPadding: const EdgeInsets.symmetric(
                          //     horizontal: 8.0, vertical: 2.0),
                        ),
                        SizedBox(height: height * 0.04),
                        RichText(
                          text: const TextSpan(
                            children: [
                              TextSpan(
                                text: 'Allergies - ',
                                style: TextStyle(
                                  fontFamily: 'Urbanist',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff868686),
                                ),
                              ),
                              TextSpan(
                                text: 'Pollen, Sunlight',
                                style: TextStyle(
                                  fontFamily: 'Urbanist',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff0C091F),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        RichText(
                          text: const TextSpan(
                            children: [
                              TextSpan(
                                text: 'Phobias/Fears - ',
                                style: TextStyle(
                                  fontFamily: 'Urbanist',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff868686),
                                ),
                              ),
                              TextSpan(
                                text: 'Pollen, Sunlight',
                                style: TextStyle(
                                  fontFamily: 'Urbanist',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff0C091F),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 4),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 8.0, right: 8, top: 8),
                      child: Text(
                        'SYMPTOMS & DIAGNOSIS',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.blackColor,
                        ),
                      ),
                    ),
                    const Divider(
                      color: AppColors.blackColor,
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8F7Fd),
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: TextField(
                        controller: searchController,
                        decoration: const InputDecoration(
                          hintText: "Search by symptoms or diagnosis",
                          hintStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Roboto',
                            color: Colors.black,
                          ),
                          border: InputBorder.none,
                          icon: Icon(Icons.search, color: AppColors.blackColor),
                        ),
                        onChanged: (value) {
                          // _searchSymptoms();
                        },
                      ),
                    ),
                    // const SizedBox(height: 8),
                    // Padding(
                    //   padding: const EdgeInsets.only(left: 16.0, right: 16),
                    //   child: Row(
                    //     children: [
                    //       Text(
                    //         "${_selectedSx.length + _selectedDx.length} selected",
                    //         style: const TextStyle(
                    //           fontFamily: 'Poppins',
                    //           fontWeight: FontWeight.w500,
                    //           fontSize: 16,
                    //           height: 1.2,
                    //           color: Color(0xFFA5A5A5),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.only(left: 14.0, right: 8),
                      child: Row(
                        children: [
                          Container(
                            height: 24,
                            width: 24,
                            color: const Color(0xff52CFAC),
                            child: const Center(
                                child: Text("Sx",
                                    style: TextStyle(color: Colors.white))),
                          ),
                          const SizedBox(width: 170),
                          Container(
                            height: 24,
                            width: 24,
                            color: AppColors.darkRedColor,
                            child: const Center(
                                child: Text("Dx",
                                    style: TextStyle(color: Colors.white))),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    isSearching
                        ? _buildResults()
                        : Center(
                            child: Image.asset(
                              "assets/homeimages/th.jpg",
                              fit: BoxFit.cover,
                              height: 220,
                              width: 200,
                            ),
                          ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
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
                  // const SizedBox(width: 20),
                  GestureDetector(
                    onTap: _selectedSx.length >= 3
                        ? () async {
                            await _searchSymptoms();
                            if (_associatedSymptomsList.isNotEmpty ||
                                _associatedSymptomsList != null) {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                print('Selected Symptoms: $_selectedSx');
                                print('Selected Diagnoses: $_selectedDx');
                                return CreateDigitalPrescriptionScreen(
                                  selectedDiagnoses: _selectedDx,
                                  selectedSymptoms: _selectedSx,
                                  symptoms: searchController.text,
                                  associatedSymptoms: _associatedSymptomsList,
                                  differentialDiagnoses:
                                      _differentialDiagnosesList,
                                );
                              }));
                            }
                          }
                        : _showMinimumSymptomsMessage,
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}*/
