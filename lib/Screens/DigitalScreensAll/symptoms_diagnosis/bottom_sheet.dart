/*
// import 'dart:async';
// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:healtether_clinic_app/Screens/DigitalScreensAll/service/symptoms_service.dart';
// import 'package:healtether_clinic_app/Screens/DigitalScreensAll/sx&dx_screen.dart';
// import 'package:healtether_clinic_app/constant/app_colors.dart';
// import 'package:healtether_clinic_app/constant/app_text.dart';
//
// import 'create_digital_presscription_screen.dart';
//
// class AffirmationsSheet extends StatefulWidget {
//   const AffirmationsSheet({Key? key}) : super(key: key);
//
//   @override
//   State<AffirmationsSheet> createState() => _AffirmationsSheetState();
// }
//
// class _AffirmationsSheetState extends State<AffirmationsSheet> {
//   String? selectedValue;
//   final List<String> options = ['hrs', 'days', 'weeks', 'months', 'years'];
//   final FocusNode timePeriodFocusNode = FocusNode();
//   bool isFocused = false;
//   List<String> _symptomsList = [];
//   List<String> _diagnosesList = [];
//   bool isTimePeriodSelected = false;
//   final TextEditingController timePeriodController = TextEditingController();
//   final List<String> _selectedSx = [];
//   final List<String> _selectedDx = [];
//   List<String> _associatedSymptomsList = [];
//   List<String> _differentialDiagnosesList = [];
//   bool isSelected = false;
//   TextEditingController searchController = TextEditingController();
//   bool isSearching = false;
//   Map<String, dynamic> apiResponse = {};
//   CreateSymptomsService createSymptomsService = CreateSymptomsService();
//
//   @override
//   void dispose() {
//     timePeriodFocusNode.dispose();
//     timePeriodController.dispose();
//     super.dispose();
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     timePeriodFocusNode.addListener(() {
//       setState(() {
//         isFocused = timePeriodFocusNode.hasFocus;
//       });
//     });
//   }
//
//
//
//   Future<void> _searchSymptoms() async {
//     if (searchController.text.isNotEmpty) {
//       setState(() {
//         isSearching = true;
//       });
//       try {
//         final result = await createSymptomsService.createSymptoms(
//           searchController.text,
//           _selectedSx,
//           _selectedDx,
//         ).timeout(const Duration(seconds: 10));
//
//         setState(() {
//           _symptomsList = result['symptoms'] ?? [];
//           _diagnosesList = result['diagnoses'] ?? [];
//           _associatedSymptomsList = result['associatedSymptoms'] ?? [];
//           _differentialDiagnosesList = result['differentialDiagnoses'] ?? [];
//           isSearching = false;
//         });
//
//         if (_associatedSymptomsList.isNotEmpty) {
//         } else {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(
//               content: Text('No associated symptoms found.'),
//             ),
//           );
//         }
//       } on TimeoutException {
//         setState(() {
//           isSearching = false;
//         });
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('Request timed out. Please try again.'),
//           ),
//         );
//       } on SocketException {
//         setState(() {
//           isSearching = false;
//         });
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('Network unreachable. Please check your connection.'),
//           ),
//         );
//       } catch (error) {
//         setState(() {
//           isSearching = false;
//         });
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Error: $error'),
//           ),
//         );
//       }
//     } else {
//       setState(() {
//         isSearching = false;
//       });
//     }
//   }
//
//   void _showMinimumSymptomsMessage() {
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(
//         content: Text('Please select at least 3 symptoms to proceed.'),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       reverse: true,
//       child: Container(
//         height: MediaQuery.of(context).size.height * 0.6 +
//             MediaQuery.of(context).viewInsets.bottom,
//         color: Colors.transparent,
//         child: Stack(
//           children: [
//             Positioned(
//                 bottom: 0,
//                 child: Container(
//                   width: MediaQuery.of(context).size.width,
//                   height: MediaQuery.of(context).size.height * 0.6 +
//                       MediaQuery.of(context).viewInsets.bottom,
//                   decoration: const ShapeDecoration(
//                     color: Colors.white,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(24),
//                         topRight: Radius.circular(24),
//                       ),
//                     ),
//                     shadows: [
//                       BoxShadow(
//                         color: Color(0x3F000000),
//                         blurRadius: 14.10,
//                         offset: Offset(3, 3),
//                         spreadRadius: 8,
//                       )
//                     ],
//                   ),
//                   child: Padding(
//                     padding:
//                         const EdgeInsets.only(left: 16.0, right: 16.0, top: 20),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           children: [
//                             Container(
//                               height: 25,
//                               width: 25,
//                               color: const Color(0xff52CFAC),
//                               child: const Center(
//                                   child: Text(
//                                 "Sx",
//                                 style: TextStyle(color: Colors.white),
//                               )),
//                             ),
//                             const SizedBox(width: 5),
//                             const Text(
//                               'Seizures',
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 20,
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 16),
//                         Row(
//                           children: [
//                             const Text(
//                               "Time period",
//                               style: TextStyle(
//                                 color: AppColors.black1Color,
//                                 fontSize: 15,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                             const SizedBox(width: 8),
//                             Flexible(
//                               child: Container(
//                                 height: 50,
//                                 decoration: BoxDecoration(
//                                   border: Border.all(
//                                       color: Colors.grey, width: 1.0),
//                                   borderRadius: BorderRadius.circular(2.0),
//                                 ),
//                                 child: TextField(
//                                   focusNode: timePeriodFocusNode,
//                                   decoration: InputDecoration(
//                                     filled: true,
//                                     fillColor: const Color(0xffFFFFFF),
//                                     border: InputBorder.none,
//                                     label: Text(
//                                       '2',
//                                       style: TextStyle(
//                                         color: isFocused
//                                             ? Colors.black
//                                             : Colors.grey,
//                                         fontSize: 16,
//                                         fontWeight: FontWeight.w400,
//                                       ),
//                                       overflow: TextOverflow.ellipsis,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(width: 2),
//                             Flexible(
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                   border: Border.all(
//                                       color: Colors.grey, width: 1.0),
//                                   borderRadius: BorderRadius.circular(2.0),
//                                 ),
//                                 child: DropdownButtonFormField<String>(
//                                   value: selectedValue,
//                                   decoration: const InputDecoration(
//                                     filled: true,
//                                     fillColor: Color(0xffFFFFFF),
//                                     border: InputBorder.none,
//                                   ),
//                                   items: options.map((String value) {
//                                     return DropdownMenuItem<String>(
//                                       value: value,
//                                       child: Text(value),
//                                     );
//                                   }).toList(),
//                                   onChanged: (String? newValue) {
//                                     setState(() {
//                                       selectedValue = newValue;
//                                     });
//                                   },
//                                   hint: const Text(
//                                     'years',
//                                     style: TextStyle(
//                                       color: Colors.grey,
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.w400,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(
//                           height: 8,
//                         ),
//                         const Text(
//                           AppText.privateNotes,
//                           style: TextStyle(
//                               fontWeight: FontWeight.w600, fontSize: 20),
//                         ),
//                         const Divider(
//                           color: AppColors.blackColor,
//                         ),
//                         Container(
//                           height: 160,
//                           decoration: const BoxDecoration(
//                             color: Color(0xFFEDFFFA),
//                           ),
//                           child: const Padding(
//                             padding: EdgeInsets.all(8.0),
//                             child: TextField(
//                               decoration: InputDecoration(
//                                 border: InputBorder.none,
//                                 hintText: 'Add your notes here.',
//                                 hintStyle: TextStyle(
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.w500,
//                                     fontFamily: 'Urbanist',
//                                     color: Colors.grey),
//                               ),
//                             ),
//                           ),
//                         ),
//                         const Spacer(),
//                         Padding(
//                           padding: const EdgeInsets.all(18.0),
//                           child: Row(
//                             children: [
//                               Container(
//                                 decoration: const BoxDecoration(
//                                   color: Color(0x0ff5F5F5),
//                                 ),
//                                 child: TextButton(
//                                   style: TextButton.styleFrom(
//                                     backgroundColor: const Color(0xffF5F5F5),
//                                     minimumSize: const Size(140, 50),
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(8),
//                                     ),
//                                   ),
//                                   onPressed: () {
//                                     Navigator.pop(context);
//                                   },
//                                   child: const Text(
//                                     AppText.clear,
//                                     style: TextStyle(
//                                       color: AppColors.darkGreenColor,
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.w600,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               const Spacer(),
//                               Container(
//                                 decoration: const BoxDecoration(
//                                   color: AppColors.greenColor,
//                                   shape: BoxShape.circle,
//                                 ),
//                                 child:   TextButton(
//                                   style: TextButton.styleFrom(
//                                     backgroundColor: AppColors.greenColor,
//                                     minimumSize: const Size(140, 50),
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(8),
//                                     ),
//                                   ),
//                                   onPressed: _selectedSx.length >= 3
//                                       ? () async{
//                                     await _searchSymptoms();
//                                     if(_associatedSymptomsList.isNotEmpty || _associatedSymptomsList != null){
//                                       Navigator.push(context, MaterialPageRoute(builder: (context) {
//                                         print('Selected Symptoms: $_selectedSx');
//                                         print('Selected Diagnoses: $_selectedDx');
//                                         return CreateDigitalPrescriptionScreen(
//                                           selectedDiagnoses: _selectedDx,
//                                           selectedSymptoms: _selectedSx,
//                                           symptoms: searchController.text,
//                                           associatedSymptoms: _associatedSymptomsList,
//                                           differentialDiagnoses: _differentialDiagnosesList,
//                                         );
//                                       }));
//                                     }}
//                                       : _showMinimumSymptomsMessage,
//                                   child: const Text(
//                                     AppText.save,
//                                     style: TextStyle(
//                                       color: AppColors.whiteColor,
//                                       fontSize: 12,
//                                       fontWeight: FontWeight.w500,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 )),
//           ],
//         ),
//       ),
//     );
//   }
// }

///*************************************

import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:healtether_clinic_app/data_layer/services/create_symptoms_service/create_symptoms_service.dart';
import 'package:healtether_clinic_app/constants/constants.dart';
import 'create_digital_presscription_screen.dart';

class AffirmationsSheet extends StatefulWidget {
  final String itemName;

  const AffirmationsSheet({Key? key, required this.itemName}) : super(key: key);

  @override
  State<AffirmationsSheet> createState() => _AffirmationsSheetState();
}

class _AffirmationsSheetState extends State<AffirmationsSheet> {
  String? selectedValue;
  final List<String> options = ['hrs', 'days', 'weeks', 'months', 'years'];
  final FocusNode timePeriodFocusNode = FocusNode();
  bool isFocused = false;
  List<String> _symptomsList = [];
  List<String> _diagnosesList = [];
  bool isTimePeriodSelected = false;
  final TextEditingController timePeriodController = TextEditingController();
  final List<String> _selectedSx = [];
  final List<String> _selectedDx = [];
  List<String> _associatedSymptomsList = [];
  List<String> _differentialDiagnosesList = [];
  bool isSelected = false;
  TextEditingController searchController = TextEditingController();
  bool isSearching = false;
  Map<String, dynamic> apiResponse = {};
  CreateSymptomsService createSymptomsService = CreateSymptomsService();

  @override
  void dispose() {
    timePeriodFocusNode.dispose();
    timePeriodController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    timePeriodFocusNode.addListener(() {
      setState(() {
        isFocused = timePeriodFocusNode.hasFocus;
      });
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
          // Process the results here if necessary
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

  void _showMinimumSymptomsMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Please select at least 3 symptoms to proceed.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      reverse: true,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.6 +
            MediaQuery.of(context).viewInsets.bottom,
        color: Colors.transparent,
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.6 +
                    MediaQuery.of(context).viewInsets.bottom,
                decoration: const ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  shadows: [
                    BoxShadow(
                      color: Color(0x3F000000),
                      blurRadius: 14.10,
                      offset: Offset(3, 3),
                      spreadRadius: 8,
                    )
                  ],
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 16.0, right: 16.0, top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 25,
                            width: 25,
                            color: const Color(0xff52CFAC),
                            child: const Center(
                              child: Text(
                                "Sx",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          const SizedBox(width: 5),
                          Expanded(
                            child: Text(
                              widget.itemName,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          const Text(
                            "Time period",
                            style: TextStyle(
                              color: AppColors.black1Color,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Flexible(
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.grey, width: 1.0),
                                borderRadius: BorderRadius.circular(2.0),
                              ),
                              child: TextField(
                                focusNode: timePeriodFocusNode,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: const Color(0xffFFFFFF),
                                  border: InputBorder.none,
                                  label: Text(
                                    '2',
                                    style: TextStyle(
                                      color: isFocused
                                          ? Colors.black
                                          : Colors.grey,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 2),
                          Flexible(
                            child: Container(
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.grey, width: 1.0),
                                borderRadius: BorderRadius.circular(2.0),
                              ),
                              child: DropdownButtonFormField<String>(
                                value: selectedValue,
                                decoration: const InputDecoration(
                                  filled: true,
                                  fillColor: Color(0xffFFFFFF),
                                  border: InputBorder.none,
                                ),
                                items: options.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedValue = newValue;
                                  });
                                },
                                hint: const Text(
                                  'years',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        AppText.privateNotes,
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 20),
                      ),
                      const Divider(color: AppColors.blackColor),
                      Container(
                        height: 160,
                        decoration: const BoxDecoration(
                          color: Color(0xFFEDFFFA),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Add your notes here.',
                              hintStyle: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Urbanist',
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Color(0x0ff5F5F5),
                                ),
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    backgroundColor: const Color(0xffF5F5F5),
                                    minimumSize: const Size(140, 50),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    AppText.clear,
                                    style: TextStyle(
                                      color: AppColors.darkGreenColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: AppColors.greenColor,
                                  shape: BoxShape.circle,
                                ),
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    backgroundColor: AppColors.greenColor,
                                    minimumSize: const Size(140, 50),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  onPressed: _selectedSx.length >= 3
                                      ? () async {
                                          await _searchSymptoms();
                                          if (_associatedSymptomsList
                                              .isNotEmpty) {
                                            Navigator.push(context,
                                                MaterialPageRoute(
                                                    builder: (context) {
                                              print(
                                                  'Selected Symptoms: $_selectedSx');
                                              print(
                                                  'Selected Diagnoses: $_selectedDx');
                                              return CreateDigitalPrescriptionScreen(
                                                selectedDiagnoses: _selectedDx,
                                                selectedSymptoms: _selectedSx,
                                                symptoms: searchController.text,
                                                associatedSymptoms:
                                                    _associatedSymptomsList,
                                                differentialDiagnoses:
                                                    _differentialDiagnosesList,
                                              );
                                            }));
                                          }
                                        }
                                      : _showMinimumSymptomsMessage,
                                  child: const Text(
                                    AppText.save,
                                    style: TextStyle(
                                      color: AppColors.whiteColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}*/*/
