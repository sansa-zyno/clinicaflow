import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healtether_clinic_app/business_logic/cubits/appointment_cubit/appointment_cubit.dart';
import 'package:healtether_clinic_app/business_logic/cubits/prescription/prescription_report_cubit.dart';
import 'package:healtether_clinic_app/business_logic/cubits/vitals_cubit/vitals_cubit.dart';
import 'package:healtether_clinic_app/data_layer/models/appointment_models/appointment_model.dart';
import 'package:healtether_clinic_app/data_layer/models/vitals_model.dart/vital.dart';
import 'package:healtether_clinic_app/utils/enums/bloc_enums.dart';
import 'package:healtether_clinic_app/utils/extensions.dart/widget_extensions.dart';
import 'package:healtether_clinic_app/utils/snackbar.dart';
import 'package:healtether_clinic_app/widgets/build_vital_item_widget.dart';
import 'package:healtether_clinic_app/Screens/AppointmentScreen/widgets/custom_textfield.dart';
import 'package:healtether_clinic_app/constants/app_colors.dart';
import 'package:healtether_clinic_app/widgets/buttons/my_elevated_button.dart';
import 'privacy_notes_sheet.dart';

class VitalsScreen extends StatefulWidget {
  final Appointment appointment;
  final Vital? vitals;
  const VitalsScreen({Key? key, required this.appointment, this.vitals}) : super(key: key);

  @override
  VitalsScreenState createState() => VitalsScreenState();
}

class VitalsScreenState extends State<VitalsScreen> {
  bool hasNavigated = false;
  final TextEditingController _bp1 = TextEditingController();
  final TextEditingController _bp2 = TextEditingController();
  final TextEditingController _spo2 = TextEditingController();
  final TextEditingController _pulseRate = TextEditingController();
  final TextEditingController _respRate = TextEditingController();
  final TextEditingController _temp = TextEditingController();
  final TextEditingController _rbs = TextEditingController();
  final TextEditingController _height = TextEditingController();
  final TextEditingController _weight = TextEditingController();

  List<TextEditingController> personalHistoryControllers = [
    TextEditingController(),
    TextEditingController(),
  ];
  List<LayerLink> personalHistoryLayerLinks = [LayerLink(), LayerLink()];

  late Set<PersonalHistory> personalHistories;
  late Vital vital;

  @override
  void initState() {
    super.initState();
    // context.read<HomePageBottomNavCubit>().onPageChanged(0);
    if (widget.vitals != null && widget.vitals!.id != null) {
      vital = widget.vitals!;
      if (vital.personalHistories == null) {
        personalHistories = {
          PersonalHistory(activity: 'x'),
          PersonalHistory(activity: 'y'),
        };
        vital = vital.copyWith(personalHistories: personalHistories);
      } else {
        personalHistories = vital.personalHistories!;
        if (personalHistories.isNotEmpty) {
          personalHistoryControllers = personalHistories.map((e) => TextEditingController(text: e.activity)).toList();
          personalHistoryLayerLinks = personalHistories.map((e) => LayerLink()).toList();
        } else {
          personalHistories = {
            PersonalHistory(activity: 'x'),
            PersonalHistory(activity: 'y'),
          };
          vital = vital.copyWith(personalHistories: personalHistories);
        }
      }
      _bp1.text = vital.bloodPressure?.systolic?.toString() ?? '0';
      _bp2.text = vital.bloodPressure?.diastolic?.toString() ?? '0';
      _spo2.text = vital.spo2?.toString() ?? "0";
      _pulseRate.text = vital.pulseRate?.toString() ?? '0';
      _respRate.text = vital.respiratoryRate?.toString() ?? '0';
      _temp.text = vital.temperature?.toString() ?? '0';
      _rbs.text = vital.rbs?.toString() ?? '0';
      _height.text = vital.height?.toString() ?? '0';
      _weight.text = vital.weight?.toString() ?? '0';
    } else {
      personalHistories = {
        PersonalHistory(activity: 'x'),
        PersonalHistory(activity: 'y'),
      };
      vital = Vital(bloodPressure: BloodPressure(), personalHistories: personalHistories);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<dynamic> _showBottomSheet(PersonalHistory history) async {
    return await showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      builder: (context) => PrivacyNotesSheet(
        history: history,
        onSave: saveHistory,
      ),
    );
  }

  void saveHistory(PersonalHistory newHistory) {
    setState(() {
      if (vital.personalHistories!.contains(newHistory)) {
        log("UPDATE HYSTORY");
        personalHistories = vital.personalHistories!.map((history) => history.activity == newHistory.activity ? newHistory : history).toSet();
        vital = vital.copyWith(personalHistories: personalHistories);
      } else {
        log("ADD NEW HISTORY");
        personalHistories.add(newHistory);
        vital = vital.copyWith(personalHistories: personalHistories);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
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
        backgroundColor: const Color(0xFFE1F9F2),
      ),
      body: BlocListener<VitalsCubit, VitalsState>(
        listener: (context, state) {
          if (state.state == VitalsStates.vitalsPosted && !hasNavigated) {
            log(state.state.toString());
            hasNavigated = true;
            showSnackbar("Vitals saved successfully", context);
            context.read<VitalsCubit>().getSavedVitals(appointmentId: widget.appointment.id!, patientId: widget.appointment.patientId!);
            context.read<PrescriptionReportCubit>().getPrescriptionReport(appointmentId: widget.appointment.id!);
            //to update home screen
            context.read<AppointmentCubit>().getAppointmentById(id: widget.appointment.id!);

            context.pop();
          }
        },
        child: Padding(
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
                        height: 52,
                        hintText: "120",
                        controller: _bp1,
                        keyBoardType: TextInputType.number,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        //fillColor: AppColors.fillColor2,
                        onChanged: (value) {
                          BloodPressure bp = vital.bloodPressure!;
                          bp = bp.copyWith(systolic: int.parse(value));
                          vital = vital.copyWith(bloodPressure: bp);
                        },
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
                        height: 52,
                        hintText: "80",
                        controller: _bp2,
                        keyBoardType: TextInputType.number,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        //fillColor: AppColors.fillColor2,
                        onChanged: (value) {
                          BloodPressure bp = vital.bloodPressure!;
                          bp = bp.copyWith(diastolic: int.parse(value));
                          vital = vital.copyWith(bloodPressure: bp);
                        },
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
                VitalItem(
                  title: 'SpO2 levels',
                  unit: '%',
                  hintText: "95",
                  controller: _spo2,
                  onChanged: (value) {
                    vital = vital.copyWith(spo2: int.parse(value));
                  },
                ),
                const SizedBox(height: 16),
                VitalItem(
                    title: 'Pulse Rate',
                    unit: 'beats/min',
                    hintText: '60',
                    controller: _pulseRate,
                    onChanged: (value) {
                      vital = vital.copyWith(pulseRate: int.parse(value));
                    }),
                const SizedBox(height: 16),
                VitalItem(
                    title: 'Respiratory Rate',
                    unit: 'beats/min',
                    hintText: '80',
                    controller: _respRate,
                    onChanged: (value) {
                      vital = vital.copyWith(respiratoryRate: int.parse(value));
                    }),
                const SizedBox(height: 16),
                VitalItem(
                    title: 'Temperature',
                    unit: '\u2109',
                    hintText: '98',
                    controller: _temp,
                    onChanged: (value) {
                      vital = vital.copyWith(temperature: int.parse(value));
                    }),
                const SizedBox(height: 16),
                VitalItem(
                    title: 'RBS',
                    unit: 'mg/dL',
                    hintText: '60',
                    controller: _rbs,
                    onChanged: (value) {
                      vital = vital.copyWith(rbs: int.parse(value));
                    }),
                const SizedBox(height: 16),
                VitalItem(
                    title: 'Height',
                    unit: 'cm',
                    hintText: '160',
                    controller: _height,
                    onChanged: (value) {
                      vital = vital.copyWith(height: int.parse(value));
                    }),
                const SizedBox(height: 16),
                VitalItem(
                    title: 'Weight',
                    unit: 'Kg',
                    hintText: '60',
                    controller: _weight,
                    onChanged: (value) {
                      vital = vital.copyWith(weight: int.parse(value));
                    }),
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
                            //to prevent out of range set error
                            if (personalHistories.elementAt(personalHistories.length - 1).activity != '') {
                              // context.pushNamed(AppRoutes.personalHistory.name);
                              personalHistoryControllers.add(TextEditingController());
                              personalHistoryLayerLinks.add(LayerLink());
                              personalHistories.add(PersonalHistory(activity: ''));
                            } else {}
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
                  children: List<Widget>.generate(personalHistoryControllers.length, (index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        children: [
                          Expanded(
                            child: CompositedTransformTarget(
                              link: personalHistoryLayerLinks[index],
                              child: CustomTextField(
                                height: 52,
                                borderRadius: 0,
                                controller: personalHistoryControllers[index],
                                hintText: 'Lifestyle choices',
                                onChanged: (value) {
                                  List<PersonalHistory> newList = personalHistories.toList();
                                  PersonalHistory history = personalHistories.elementAt(index).copyWith(activity: value);
                                  newList[index] = history;
                                  personalHistories = newList.toSet();
                                  vital = vital.copyWith(personalHistories: personalHistories);
                                },
                              ),
                            ),
                          ),
                          SizedBox(width: 8),
                          InkWell(
                            onTap: () {
                              final List<PersonalHistory> match =
                                  personalHistories.where((element) => element.activity == personalHistoryControllers[index].text).toList();
                              if (match.isNotEmpty) {
                                _showBottomSheet(match[0]);
                              }
                            },
                            child: CircleAvatar(
                                radius: 12,
                                backgroundColor: personalHistories.isNotEmpty && (personalHistories.elementAtOrNull(index)?.privateNote != null)
                                    ? AppColors.greenCyan
                                    : AppColors.darkBlueViolet,
                                child: const Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                  size: 20,
                                )),
                          ),
                          SizedBox(width: 8),
                          InkWell(
                            onTap: () {
                              if (personalHistoryControllers.length > 2) {
                                personalHistories.removeWhere((element) => element.activity == personalHistoryControllers[index].text);
                                personalHistoryControllers.removeAt(index);
                                personalHistoryLayerLinks.removeAt(index);
                                setState(() {});
                              }
                            },
                            child: const CircleAvatar(
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
                    );
                  }),
                )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BlocBuilder<VitalsCubit, VitalsState>(builder: (context, state) {
        if (state.state == VitalsStates.postingVitals) {
          return const SizedBox(height: 100, child: Center(child: CircularProgressIndicator()));
        } else {
          return Row(children: [
            //? CLEAR
            Expanded(
                child: MyElevatedButton(
                    text: "Clear All",
                    height: 58,
                    textStyle: const TextStyle(color: AppColors.eerieBlack, fontSize: 15),
                    backgroundColor: AppColors.whiteSmoke,
                    onPressed: () => setState(() {
                          _bp1.text = "";
                          _bp2.text = "";
                          _spo2.text = "";
                          _pulseRate.text = "";
                          _respRate.text = "";
                          _temp.text = "";
                          _rbs.text = "";
                          _height.text = "";
                          _weight.text = "";
                          personalHistoryControllers = [
                            TextEditingController(),
                            TextEditingController(),
                          ];
                          personalHistoryLayerLinks = [LayerLink(), LayerLink()];
                        }))),
            const SizedBox(width: 20),
            //? CLEAR
            Expanded(
                child: MyElevatedButton(
              text: "Save",
              height: 58,
              textStyle: const TextStyle(fontSize: 15),
              onPressed: () {
                log(vital.toMap().toString());
                hasNavigated = false;
                context
                    .read<VitalsCubit>()
                    .postVitals(patientId: widget.appointment.patientId!, appointmentId: widget.appointment.id!, map: vital.toMap());
              },
            )),
          ]).pSymmetric(vertical: 8);
        }
      }),
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
