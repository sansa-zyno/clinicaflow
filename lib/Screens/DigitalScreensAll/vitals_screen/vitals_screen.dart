import 'dart:math' as Math;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healtether_clinic_app/Screens/DigitalScreensAll/past_medical_history/symptoms_tests_screen.dart';
import 'package:healtether_clinic_app/Screens/DigitalScreensAll/vitals_screen/personal_historyScreen.dart';
import 'package:healtether_clinic_app/data_layer/models/history_item/history_item.dart';
import 'package:healtether_clinic_app/data_layer/models/symptom_model/symptom.dart';
import 'package:healtether_clinic_app/data_layer/models/vitals_model.dart/vital.dart';
import 'package:healtether_clinic_app/data_layer/sample_objects/sample_objects.dart';
import 'package:healtether_clinic_app/utils/enums/route_enums.dart';
import 'package:healtether_clinic_app/utils/extensions.dart/string_extensions.dart';
import 'package:healtether_clinic_app/utils/extensions.dart/widget_extensions.dart';
import 'package:healtether_clinic_app/utils/helper_functions/log.dart';
import 'package:healtether_clinic_app/widgets/build_vital_item_widget.dart';
import 'package:healtether_clinic_app/Screens/AppointmentScreen/widgets/custom_textfield.dart';
import 'package:healtether_clinic_app/constants/app_colors.dart';
import 'package:healtether_clinic_app/widgets/buttons/my_elevated_button.dart';
import 'package:healtether_clinic_app/widgets/text_list_tile.dart';
// import 'package:healtether_clinic_app/widgets/green_line_widget.dart';
// import 'other_vitals_screen.dart';

class VitalsScreen extends StatefulWidget {
  const VitalsScreen({Key? key, this.vitals, required this.appointmentId}) : super(key: key);
  final String appointmentId;
  final List<Vital>? vitals;

  @override
  VitalsScreenState createState() => VitalsScreenState();
}

class VitalsScreenState extends State<VitalsScreen> {
  List<String> selectedOptions = [];
  final TextEditingController _bp1 = TextEditingController();
  final TextEditingController _bp2 = TextEditingController();
  final TextEditingController _spo2 = TextEditingController();
  final TextEditingController _pulseRate = TextEditingController();
  final TextEditingController _respRate = TextEditingController();
  final TextEditingController _temp = TextEditingController();
  final TextEditingController _rbs = TextEditingController();
  final TextEditingController _height = TextEditingController();
  final TextEditingController _weight = TextEditingController();

  // List<Widget> newVitals = [];
  List<Vital> selectedVitals = [];
  Map<String, TextEditingController> vitalControllers = {};
  List<Vital>? vitals;
  List<TextEditingController> personalHistoryControllers = [
    TextEditingController(),
    TextEditingController(),
  ];
  List<LayerLink> personalHistoryLayerLinks = [LayerLink(), LayerLink()];

  @override
  void dispose() {
    final keys = vitalControllers.keys;

    for (var key in keys) {
      vitalControllers[key]?.dispose();
    }
    super.dispose();
  }

  void addSelectedVitals() {
    final newVitals = vitals ?? [];

    log("VITAL: $vitals");
    log("New VITAL: $newVitals");
    log(" SELECTED VITAL: $selectedVitals");

    for (var vital in selectedVitals) {
      log("TARGET VITAL: ${vital.id}");
      log("NEW VITAL CONTAINS VITAL: ${newVitals.contains(vital)}");
      if (newVitals.contains(vital) == false) {
        final index = selectedVitals.indexOf(vital);

        log("REMOVING: $vital");

        selectedVitals.removeAt(index);
        vitalControllers.remove(vitalControllers.keys.elementAt(index));
      }
    }

    String? text;

    for (var vital in newVitals) {
      log("VITAL TYPE: ${vital.type}");
      if (vital.type != 'blood_pressure') {
        text = vital.value!['real'].toString();
      } else {
        text = "${vital.value!['real']}/${vital.value!['fraction']}";
      }
      if (selectedVitals.contains(vital) == false) {
        selectedVitals.add(vital);
        vitalControllers.addAll({vital.id!: TextEditingController(text: text)});
      }
    }
  }

  Vital getVital(String id) {
    final vital = selectedVitals.where((e) => e.id == id);

    return vital.first;
  }

  @override
  void initState() {
    super.initState();
    // context.read<HomePageBottomNavCubit>().onPageChanged(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "VITALS & GENERAL EXAMINATION",
                style: GoogleFonts.urbanist(
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
              const Divider(
                thickness: 1,
                height: 2,
                color: Colors.black,
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Vitals',
                    style: GoogleFonts.urbanist(
                      textStyle: const TextStyle(
                        fontSize: 18,
                        // fontFamily: "Montserrat",
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  /*Column(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          log("GOING TO OTHER VITALS");
                          vitals = await context.pushNamed(AppRoutes.otherVitals.name,
                              pathParameters: {"appointmentId": widget.appointmentId}, extra: vitals);
                          log("VITALS: $vitals");
                          setState(() {
                            addSelectedVitals();
                          });
                        },
                        child: Text(
                          'Add',
                          style: GoogleFonts.urbanist(
                            textStyle: const TextStyle(
                              fontSize: 17,
                              // fontFamily: "Montserrat",
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF32856E),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 2,
                        width: 32,
                        decoration: const BoxDecoration(
                          color: Color(0xFF32856E),
                        ),
                      ),
                    ],
                  ),*/
                ],
              ),
              const SizedBox(height: 8),
              Column(
                children: [
                  Text(
                    'Blood Pressure',
                    style: GoogleFonts.urbanist(
                      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      hintText: "120",
                      controller: _bp1,
                      fillColor: AppColors.fillColor2,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    '/',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: CustomTextField(
                      hintText: "80",
                      controller: _bp2,
                      fillColor: AppColors.fillColor2,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'mm Hg',
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Color(0xFF000000)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              VitalItem(title: 'SpO2 levels', unit: '%', hintText: "95", controller: _spo2),
              const SizedBox(height: 16),
              VitalItem(title: 'Pulse Rate', unit: 'beats/min', hintText: '60', controller: _pulseRate),
              const SizedBox(height: 16),
              VitalItem(title: 'Respiratory Rate', unit: 'beats/min', hintText: '80', controller: _respRate),
              const SizedBox(height: 16),
              VitalItem(title: 'Temperature', unit: '\u2109', hintText: '98', controller: _temp),
              const SizedBox(height: 16),
              VitalItem(title: 'RBS', unit: 'mg/dL', hintText: '60', controller: _rbs),
              const SizedBox(height: 16),
              VitalItem(title: 'Height', unit: 'cm', hintText: '160', controller: _height),
              const SizedBox(height: 16),
              VitalItem(title: 'Weight', unit: 'Kg', hintText: '60', controller: _weight),
              const SizedBox(height: 16),
              RichText(
                  text: TextSpan(
                      style: GoogleFonts.roboto(textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black)),
                      children: const [
                    TextSpan(text: 'Your Body Mass Index is '),
                    TextSpan(text: '23.4', style: TextStyle(fontWeight: FontWeight.w700)),
                    TextSpan(text: ' kg/m2')
                  ])),
              const SizedBox(height: 5),
              RichText(
                  text: TextSpan(
                      style: GoogleFonts.roboto(textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black)),
                      children: const [
                    TextSpan(text: 'This is considered '),
                    TextSpan(text: 'Normal', style: TextStyle(fontWeight: FontWeight.w700)),
                  ])),
              const SizedBox(height: 16),
              /* ...List<Widget>.generate(selectedVitals.length, (index) {
                final vital = selectedVitals.elementAt(index);

                return VitalItem(
                        title: vital.type!.split('_').join(' ').capitalize,
                        unit: "Unit",
                        hintText: "${60 + Math.Random().nextInt(10)}",
                        controller: vitalControllers[vital.id!]!)
                    .pOnly(bottom: 16);
              }),*/
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Personal History',
                    style: GoogleFonts.urbanist(
                      textStyle: const TextStyle(
                        fontSize: 20,
                        // fontFamily: "Urbanist",
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF0C091F),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          // context.pushNamed(AppRoutes.personalHistory.name);
                          personalHistoryControllers.add(TextEditingController());
                          personalHistoryLayerLinks.add(LayerLink());
                          setState(() {});
                        },
                        child: Text(
                          'Add',
                          style: GoogleFonts.urbanist(
                            textStyle: const TextStyle(
                              fontSize: 17,
                              // fontFamily: "Urbanist",
                              fontWeight: FontWeight.w600,

                              color: Color(0xFF32856E),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 2,
                        width: 32,
                        decoration: const BoxDecoration(
                          color: Color(0xFF32856E),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Column(
                children: List<Widget>.generate(
                    personalHistoryControllers.length,
                    (index) => Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            children: [
                              Expanded(
                                child: CompositedTransformTarget(
                                  link: personalHistoryLayerLinks[index],
                                  child: CustomTextField(
                                    height: 52,
                                    borderRadius: 0,
                                    onTap: () {},
                                    controller: personalHistoryControllers[index],
                                    hintText: 'Lifestyle choices',
                                    onChanged: (String query) {},
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              InkWell(
                                onTap: () {
                                  if (personalHistoryControllers.length > 2) {
                                    //selectedDiagnosis.removeWhere((element) => element.name == diagnosisControllers[index].text);
                                    personalHistoryControllers.removeAt(index);
                                    personalHistoryLayerLinks.removeAt(index);
                                    // onDeletePressedDx = false;
                                    setState(() {});
                                  }
                                },
                                child: CircleAvatar(
                                    radius: 12,
                                    backgroundColor: AppColors.accentColor2,
                                    child: Icon(
                                      Icons.close,
                                      color: AppColors.darkBlueViolet,
                                      size: 20,
                                    )),
                              )
                            ],
                          ),
                        )),
              )
              /* buildPersonalHistorySection(
                context,
                [
                  'None',
                  'Aerobics',
                  'Yoga',
                  'Smoking',
                  'Tobacco',
                  'Gym',
                  'Alcohol Consumption',
                  'Sedentary job',
                  'Other',
                ],
              ),*/
            ],
          ),
        ),
      ),
      bottomNavigationBar: Row(children: [
        //? CLEAR
        Expanded(
            child: MyElevatedButton(
                text: "Clear All",
                height: 61,
                textStyle: const TextStyle(color: AppColors.eerieBlack, fontSize: 17),
                backgroundColor: AppColors.whiteSmoke,
                onPressed: () => setState(() {}))),

        const SizedBox(width: 20),

        //? CLEAR
        Expanded(
            child: MyElevatedButton(
          text: "Save",
          height: 61,
          textStyle: const TextStyle(fontSize: 17),
          onPressed: () {},
        )),
      ]).pSymmetric(vertical: 8),
    );
  }

  /*Widget buildPersonalHistorySection(BuildContext context, List<String> options) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 4.0,
          runSpacing: 8.0,
          children: options.map((option) {
            bool isSelected = selectedOptions.contains(option);
            return GestureDetector(
              onTap: () {
                setState(() {
                  if (option == 'Other') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PersonalHistoryScreen(),
                      ),
                    );
                  } else {
                    if (isSelected) {
                      selectedOptions.remove(option);
                    } else {
                      selectedOptions.add(option);
                    }
                  }
                });
              },
              child: Chip(
                label: Text(
                  option,
                  style: GoogleFonts.urbanist(
                    textStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: isSelected ? Colors.white : const Color(0xFF0C091F),
                    ),
                  ),
                ),
                backgroundColor: isSelected ? const Color(0xFF32856E) : const Color(0xFFF5F5F5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                  side: BorderSide(
                    color: isSelected ? Colors.grey.shade50 : const Color(0xFFF5F5F5),
                  ),
                ),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }*/
}
