/*import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healtether_clinic_app/Screens/DigitalScreensAll/digital_precription_screen.dart';
import 'package:healtether_clinic_app/Screens/DigitalScreensAll/show_bottom_sheet.dart';
import 'package:healtether_clinic_app/constants/app_colors.dart';

class DrugsPrescriptionScreen extends StatefulWidget {
  const DrugsPrescriptionScreen({Key? key}) : super(key: key);

  @override
  State<DrugsPrescriptionScreen> createState() =>
      _DrugsPrescriptionScreenState();
}

class _DrugsPrescriptionScreenState extends State<DrugsPrescriptionScreen> {
  String? _selectedDrug;
  String? _selectedDrugSubtitle;

  final List<String> _selectedDrugs = [];
  bool isSelected = false;

  void _toggleSelected() {
    setState(() {
      isSelected = !isSelected;
    });
  }

  void _selectDrug(String drugName, String drugSubtitle) {
    setState(() {
      _selectedDrugs.add(drugName);
    });
  }

  void _saveAndReturn() {
    Navigator.pop(context, _selectedDrugs);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Expanded(
              child: Text(
                'Drugs Prescription',
                style: GoogleFonts.montserrat(
                  textStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    height: 1.25,
                    color: Color(0xFF202741),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                // if (_selectedDrugs.length <= 3) {
                //   final medicationsProvider =
                //       context.read<MedicationsProvider>();
                //   medicationsProvider.updateDiagnoses(_selectedDrugs);
                //   medicationsProvider.updateNMedications(_selectedDrugs.length);
                //   await medicationsProvider.createMedication();
                //
                //   if (medicationsProvider.errorMessage == null) {
                // Navigator.push(
                // context,

                // MaterialPageRoute(
                //   builder: (context) =>
                //       DigitalPrecriptionScreen(selectedDrugs: _selectedDrugs,),
                //   //     DrugPrescriptionFollowupScreen(
                //   //   selectedDrugs: _selectedDrugs,
                //   // ),
                // ),
                // );
                //   } else {
                //     print(medicationsProvider.errorMessage);
                //   }
                // } else {
                //   print('Please select at least 3 drugs.');
                // }
              },
              // // if(_selectedDiseases.length ==2) {
              // if (_selectedDiseases.contains("Dolo 600mg") &&
              //     _selectedDiseases.contains("Moxikind CV 625mg") &&
              //     _selectedDiseases.length == 2) {
              //   Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //         builder: (context) =>
              //         // const DigitalPrecriptionScreen(),
              //           DrugPrescriptionFollowupScreen(),
              //       ));
              // } else {
              //   print('try again');
              // }
              child: Container(
                width: 70,
                height: 35,
                decoration: BoxDecoration(
                  // color: _selectedDrugs.length >= 3
                  //     ? AppColors.greenColor
                  //     : Colors.grey,
                  color: AppColors.greenColor,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Center(
                  child: Text(
                    'Save',
                    style: TextStyle(color: AppColors.whiteColor, fontSize: 14),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16),
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
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              height: 1.2,
                              color: AppColors.blue1Color,
                            ),
                          ),
                          decoration: const InputDecoration.collapsed(
                            hintText: 'Search by drug brand or content',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            const Padding(
              padding: EdgeInsets.only(left: 16.0, right: 16),
              child: Text(
                // "${_selectedDiseases.length} selected",
                '2 selected',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  height: 1.2,
                  color: Color(0xFFA5A5A5),
                ),
              ),
            ),
            const SizedBox(height: 16),
            drugSelectionCard(
              'Dolo 600mg',
              'Paracetamol 600mg',
              (value) {
                _showDrugBottomSheet('Dolo 600mg', 'Paracetamol 600mg');
              },
            ),
            const SizedBox(height: 10),
            drugSelectionCard(
              'Paracetamol 500mg',
              'Paracetamol 600mg',
              (value) {
                _showDrugBottomSheet('Paracetamol 500mg', 'Paracetamol 600mg');
              },
            ),
            const SizedBox(height: 10),
            drugSelectionCard(
              'Meronem',
              'Meronem(1000mg).',
              (value) {
                _showDrugBottomSheet('Meronem', 'Meronem(1000mg)');
              },
            ),
            const SizedBox(height: 10),
            drugSelectionCard(
              'Moxikind CV 625mg',
              'Amoxycillin/Amoxicillin(500.0Mg)+Clavulanic\nAcid(125.0Mg)',
              (value) {
                _showDrugBottomSheet('Moxikind CV 625mg',
                    'Amoxycillin/Amoxicillin(500.0Mg)+ClavulanicAcid(125.0Mg)');
              },
            ),
            const SizedBox(height: 10),
            drugSelectionCard(
              'Ambrowell 100ml',
              'Ambrowell & Guaipheniesin Combination',
              (value) {
                _showDrugBottomSheet(
                    'Ambrowell 100ml', 'Ambrowell & Guaipheniesin Combination');
              },
            ),
            const SizedBox(height: 10),
            drugSelectionCard(
              'Opt 1',
              'Paracetamol 600mg',
              (value) {
                _showDrugBottomSheet('Opt 1', 'Paracetamol 600mg');
              },
            ),
            const SizedBox(height: 10),
            drugSelectionCard(
              'Opt 2',
              'Paracetamol 600mg',
              (value) {
                _showDrugBottomSheet('Opt 2', 'Paracetamol 600mg');
              },
            ),
            const SizedBox(height: 10),
            drugSelectionCard(
              'Opt 3',
              'Paracetamol 600mg',
              (value) {
                _showDrugBottomSheet('Opt 3', 'Paracetamol 600mg');
              },
            ),
            const SizedBox(height: 10),
            drugSelectionCard(
              'Opt 4',
              'Paracetamol 600mg',
              (value) {
                _showDrugBottomSheet('Opt 4', 'Paracetamol 600mg');
              },
            ),
            const SizedBox(height: 10),
            // Padding(
            //   padding: const EdgeInsets.only(left:  38.0), // Adjust the value as needed
            //   child: Divider(color: Colors.grey[300]),
            // ),
            // const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  void _showDrugBottomSheet(String drugName, String drugSubtitle) {
    setState(() {
      _selectedDrug = drugName;
      _selectedDrugSubtitle = drugSubtitle;
    });
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
      ),
      builder: (BuildContext context) {
        return ShowBottomSheet(
          drugName: _selectedDrug!,
          drugSubtitle: _selectedDrugSubtitle!,
        );
      },
    );
  }

  // Widget drugSelectionCard(String title, String subtitle, bool isSelected,
  //     ValueChanged<String?> onChanged) {
  //   return GestureDetector(
  //     onTap: () {
  //       setState(() {
  //         if (_selectedDrugs.contains(title)) {
  //           _selectedDrugs.remove(title);
  //         } else {
  //           if (_selectedDrugs.length < 3) {
  //             _selectedDrugs.add(title);
  //           }
  //         }
  //       });
  //       onChanged(title);
  //     },
  //     child: Padding(
  //       padding: const EdgeInsets.only(left: 16.0,right: 16),
  //       child: Container(
  //         height: 70,
  //         decoration: const BoxDecoration(
  //           color: Color(0xFFF8F7FC),
  //         ),
  //         padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
  //         child: Row(
  //           children: [
  //             GestureDetector(
  //               onTap: () {
  //                 setState(() {
  //                   isSelected = !isSelected;
  //                   if (isSelected) {
  //                     _selectedDrugs.add(title);
  //                   } else {
  //                     _selectedDrugs.remove(title);
  //                   }
  //                 });
  //               },
  //               child: Container(
  //                 width: 20,
  //                 height: 20,
  //                 decoration: BoxDecoration(
  //                   borderRadius: BorderRadius.circular(4),
  //                   border: Border.all(
  //                     color: const Color(0xFFA1A1A1),
  //                   ),
  //                   color:
  //                       isSelected ? const Color(0xFFFEFEFE) : Colors.transparent,
  //                 ),
  //                 child: isSelected
  //                     ? const Center(
  //                         child: Icon(
  //                           Icons.check,
  //                           color: Colors.black,
  //                           size: 14.0,
  //                         ),
  //                       )
  //                     : null,
  //               ),
  //             ),
  //             const SizedBox(width: 12.0),
  //             Expanded(
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children: [
  //                   Text(
  //                     title,
  //                     style: GoogleFonts.urbanist(
  //                       textStyle: const TextStyle(
  //                         fontWeight: FontWeight.w500,
  //                         fontSize: 16,
  //                         height: 1.0,
  //                         color: Color(0xFF202741),
  //                       ),
  //                     ),
  //                   ),
  //                   const SizedBox(
  //                     height: 5,
  //                   ),
  //                   Text(
  //                     subtitle,
  //                     style: GoogleFonts.urbanist(
  //                       textStyle: const TextStyle(
  //                         fontWeight: FontWeight.w400,
  //                         fontSize: 11,
  //                         height: 1.2,
  //                         color: Color(0xFF3351C7),
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //             if (title == 'Meronem')
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.end,
  //                 children: [
  //                   const SizedBox(width: 155),
  //                   Container(
  //                     width: 25,
  //                     height: 20,
  //                     decoration: BoxDecoration(
  //                       color: const Color(0xFFDDDFF0),
  //                       borderRadius: BorderRadius.circular(4),
  //                       border: Border.all(color: const Color(0xFF1227E3)),
  //                     ),
  //                     child: const Center(
  //                       child: Text(
  //                         'Inj',
  //                         style: TextStyle(
  //                             color: AppColors.blackColor,
  //                             fontWeight: FontWeight.w400,
  //                             fontSize: 10),
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             if (title == 'Ambrowell 100ml')
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.end,
  //                 children: [
  //                   const SizedBox(width: 50),
  //                   Container(
  //                     width: 30,
  //                     height: 20,
  //                     decoration: BoxDecoration(
  //                       color: const Color(0xFFDDDFF0),
  //                       borderRadius: BorderRadius.circular(4),
  //                       border: Border.all(color: const Color(0xFF1227E3)),
  //                     ),
  //                     child: const Center(
  //                       child: Text(
  //                         'Syp',
  //                         style: TextStyle(
  //                             color: AppColors.blackColor,
  //                             fontSize: 10,
  //                             fontWeight: FontWeight.w400),
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
  Widget drugSelectionCard(
    String title,
    String subtitle,
    ValueChanged<String?> onChanged,
  ) {
    return GestureDetector(
      onTap: () {
        onChanged(title);
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16),
        child: Container(
          height: 70,
          decoration: const BoxDecoration(
            color: Color(0xFFF8F7FC),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.urbanist(
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          height: 1.0,
                          color: Color(0xFF202741),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      subtitle,
                      style: GoogleFonts.urbanist(
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 11,
                          height: 1.2,
                          color: Color(0xFF3351C7),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (title == 'Meronem')
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const SizedBox(width: 155),
                    Container(
                      width: 25,
                      height: 20,
                      decoration: BoxDecoration(
                        color: const Color(0xFFDDDFF0),
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: const Color(0xFF1227E3)),
                      ),
                      child: const Center(
                        child: Text(
                          'Inj',
                          style: TextStyle(
                              color: AppColors.blackColor,
                              fontWeight: FontWeight.w400,
                              fontSize: 10),
                        ),
                      ),
                    ),
                  ],
                ),
              if (title == 'Ambrowell 100ml')
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const SizedBox(width: 50),
                    Container(
                      width: 30,
                      height: 20,
                      decoration: BoxDecoration(
                        color: const Color(0xFFDDDFF0),
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: const Color(0xFF1227E3)),
                      ),
                      child: const Center(
                        child: Text(
                          'Syp',
                          style: TextStyle(
                              color: AppColors.blackColor,
                              fontSize: 10,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
// drugSelectionCard(
// 'Opt 1',
// 'Paracetamol 600mg',
// _selectedDrugs.contains('Opt 1'),
// (value) {
// _showDrugBottomSheet('Opt 1', 'Paracetamol 600mg');
// },
// ),
// drugSelectionCard(
//   'Dolo 600mg',
//   'Paracetamol 600mg',
//   _selectedDrug == 'Dolo 600mg',
//       (value) {
//     setState(() {
//       _selectedDrug = value;
//       _selectedDrugSubtitle = 'Paracetamol 600mg';
//       // _showBottomSheet(_selectedDrug!, _selectedDrugSubtitle!);
//       showModalBottomSheet(
//         backgroundColor: Colors.transparent,
//         isScrollControlled: true,
//         context: context,
//         builder: (BuildContext context) {
//           return const ShowBottomSheet(
//             drugName: 'Dolo 600mg',
//             drugSubtitle: 'Paracetamol 600mg',
//           );
//         },
//       );
//     });
//   },
// ),
// const SizedBox(height: 10),
// drugSelectionCard(
//   'Paracetamol 500mg',
//   'Paracetamol 600mg',
//   _selectedDrug == 'Paracetamol 500mg',
//       (value) {
//     setState(() {
//       _selectedDrug = value;
//       _selectedDrugSubtitle = 'Paracetamol 600mg';
//       showModalBottomSheet(
//         backgroundColor: Colors.transparent,
//         isScrollControlled: true,
//         context: context,
//         builder: (BuildContext context) {
//           return const ShowBottomSheet(
//             drugName: 'Paracetamol 500mg',
//             drugSubtitle: 'Paracetamol 600mg',
//           );
//         },
//       );
//     });
//   },
// ),
// const SizedBox(height: 10),
// drugSelectionCard(
//   'Meronem',
//   'Meronem(1000mg).',
//   _selectedDrug == 'Meronem',
//       (value) {
//     setState(() {
//       _selectedDrug = value;
//       _selectedDrugSubtitle = 'Meronem(1000mg)';
//       showModalBottomSheet(
//         backgroundColor: Colors.transparent,
//         isScrollControlled: true,
//         context: context,
//         builder: (BuildContext context) {
//           return const ShowBottomSheet(
//             drugName: 'Meronem',
//             drugSubtitle: 'Meronem(1000mg)',
//           );
//         },
//       );
//     });
//   },
// ),
// const SizedBox(height: 10),
// drugSelectionCard(
//   'Moxikind CV 625mg',
//   'Amoxycillin/Amoxicillin(500.0Mg)+Clavulanic\nAcid(125.0Mg)',
//   _selectedDrug == 'Moxikind CV 625mg',
//       (value) {
//     setState(() {
//       _selectedDrug = value;
//       _selectedDrugSubtitle =
//       'Amoxycillin/Amoxicillin(500.0Mg)+ClavulanicAcid(125.0Mg)';
//       showModalBottomSheet(
//         backgroundColor: Colors.transparent,
//         isScrollControlled: true,
//         context: context,
//         builder: (BuildContext context) {
//           return const ShowBottomSheet(
//             drugName: 'Moxikind CV 625mg',
//             drugSubtitle: 'Amoxycillin/Amoxicillin(500.0Mg)+\nClavulanicAcid(125.0Mg)',
//           );
//         },
//       );
//     });
//   },
// ),
// const SizedBox(height: 10),
// drugSelectionCard(
//   'Ambrowell 100ml',
//   'Ambrowell & Guaipheniesin Combination',
//   _selectedDrug == 'Ambrowell 100ml',
//       (value) {
//     setState(() {
//       _selectedDrug = value;
//       _selectedDrugSubtitle =
//       'Ambrowell & Guaipheniesin Combination';
//       showModalBottomSheet(
//         backgroundColor: Colors.transparent,
//         isScrollControlled: true,
//         context: context,
//         builder: (BuildContext context) {
//           return const ShowBottomSheet(
//             drugName: 'Ambrowell 100ml',
//             drugSubtitle: 'Ambrowell & Guaipheniesin Combination',
//           );
//         },
//       );
//     });
//   },
// ),
// const SizedBox(height: 10),
// drugSelectionCard(
//   'Opt 1',
//   'Paracetamol 600mg',
//   _selectedDrug == 'Opt 1',
//       (value) {
//     setState(() {
//       _selectedDrug = value;
//       _selectedDrugSubtitle = 'Paracetamol 600mg';
//       showModalBottomSheet(
//         context: context,
//         builder: (BuildContext context) {
//           return const ShowBottomSheet(
//             drugName: 'Opt 1',
//             drugSubtitle: 'Paracetamol 600mg',
//           );
//         },
//       );
//     });
//   },
// ),
// const SizedBox(height: 10),
// drugSelectionCard(
//   'Opt 2',
//   'Paracetamol 600mg',
//   _selectedDrug == 'Opt 2',
//       (value) {
//     setState(() {
//       _selectedDrug = value;
//       _selectedDrugSubtitle = 'Paracetamol 600mg';
//       showModalBottomSheet(
//         context: context,
//         builder: (BuildContext context) {
//           return const ShowBottomSheet(
//             drugName: 'Opt 2',
//             drugSubtitle: 'Paracetamol 600mg',
//           );
//         },
//       );
//     });
//   },
// ),
// const SizedBox(height: 10),
// drugSelectionCard(
//   'Opt 3',
//   'Paracetamol 600mg',
//   _selectedDrug == 'Opt 3',
//       (value) {
//     setState(() {
//       _selectedDrug = value;
//       _selectedDrugSubtitle = 'Paracetamol 600mg';
//       showModalBottomSheet(
//         backgroundColor: Colors.transparent,
//         isScrollControlled: true,
//         context: context,
//         builder: (BuildContext context) {
//           return const ShowBottomSheet(
//             drugName: 'Opt 3',
//             drugSubtitle: 'Paracetamol 600mg',
//           );
//         },
//       );
//     });
//   },
// ),
// const SizedBox(height: 10),
// drugSelectionCard(
//   'Opt 4',
//   'Paracetamol 600mg',
//   _selectedDrug == 'Opt 4',
//       (value) {
//     setState(() {
//       _selectedDrug = value;
//       _selectedDrugSubtitle = 'Paracetamol 600mg';
//       showModalBottomSheet(
//         backgroundColor: Colors.transparent,
//         isScrollControlled: true,
//         context: context,
//         builder: (BuildContext context) {
//           return const ShowBottomSheet(
//             drugName: 'Opt 4',
//             drugSubtitle: 'Paracetamol 600mg',
//           );
//         },
//       );
//     });
//   },
// ),*/
