import 'dart:ui';
import 'dart:developer' as dev;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healtether_clinic_app/Screens/AppointmentScreen/widgets/custom_textfield.dart';
import 'package:healtether_clinic_app/Screens/DigitalScreensAll/symptoms_diagnosis/privacy_notes_sheet.dart';
import 'package:healtether_clinic_app/business_logic/cubits/symptoms_and_diagnosis_cubit/symptoms_and_diagnosis_cubit.dart';
import 'package:healtether_clinic_app/constants/app_constants.dart';
import 'package:healtether_clinic_app/data_layer/models/appointment_models/appointment_model.dart';
import 'package:healtether_clinic_app/data_layer/models/symptom_model/symptom.dart';
import 'package:healtether_clinic_app/data_layer/sample_objects/sample_objects.dart';
import 'package:healtether_clinic_app/constants/constants.dart';
import 'package:healtether_clinic_app/data_layer/services/shared_preferences_service.dart';
import 'package:healtether_clinic_app/utils/enums/bloc_enums.dart';
import 'package:healtether_clinic_app/utils/extensions.dart/string_extensions.dart';
import 'package:healtether_clinic_app/utils/extensions.dart/widget_extensions.dart';
import 'package:healtether_clinic_app/utils/helper_functions/log.dart';
import 'package:healtether_clinic_app/utils/mixins/device_info_mixin.dart';
import 'package:healtether_clinic_app/utils/mixins/ui_info_mixin.dart';
import 'package:healtether_clinic_app/widgets/components/vitals_and_past_history_end_drawer.dart';
import 'package:healtether_clinic_app/widgets/text_list_tile.dart';
import 'package:healtether_clinic_app/widgets/buttons/my_elevated_button.dart';

class CreateDigitalPrescriptionScreens extends StatefulWidget {
  final Appointment appointment;
  final Set<Symptom>? selectedSymptoms;
  final Set<Symptom>? selectedDiagnosis;
  const CreateDigitalPrescriptionScreens({required this.appointment, this.selectedSymptoms, this.selectedDiagnosis, super.key});

  @override
  State<CreateDigitalPrescriptionScreens> createState() => _CreateDigitalPrescriptionScreensState();
}

class _CreateDigitalPrescriptionScreensState extends State<CreateDigitalPrescriptionScreens> with DeviceInfoMixin, UiInfoMixin {
  OverlayEntry? _overlayEntry;
  bool hasNavigated = false;
  ScrollController scrollController = ScrollController();
  List<TextEditingController> symptomsControllers = [
    TextEditingController(),
    TextEditingController(),
  ];
  //int symptomIndex = -1;
  List<LayerLink> symptomsLayerLinks = [LayerLink(), LayerLink()];
  List<TextEditingController> symptomsDurationControllers = [
    TextEditingController(),
    TextEditingController(),
  ];
  //int symptomDurationIndex = -1;
  List<LayerLink> symptomsDurationsLayerLinks = [LayerLink(), LayerLink()];
  List<TextEditingController> diagnosisControllers = [
    TextEditingController(),
    TextEditingController(),
  ];
  //int diagnosisIndex = -1;
  List<LayerLink> diagnosisLayerLinks = [LayerLink(), LayerLink()];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isTooltipVisible1 = false;
  bool isTooltipVisible2 = false;
  bool onDeletePressedSx = false;
  bool onDeletePressedDx = false;
  bool addSpace = false;
  bool isFirstTime = true;

  Set<Symptom> selectedSymptoms = {};
  Set<Symptom> selectedDiagnosis = {};

  bool _isDrawerOpen = false;

  void _toggleDrawer() {
    if (_scaffoldKey.currentState!.isEndDrawerOpen) {
      Navigator.of(context).pop();
    } else {
      _scaffoldKey.currentState!.openEndDrawer();
    }
    setState(() {
      _isDrawerOpen = !_isDrawerOpen;
    });
  }

  Future<dynamic> _showBottomSheet(Symptom symptom) async {
    return await showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      builder: (context) => PrivacyNotesSheet(
        symptom: symptom,
        onSave: symptom.type == 'Sx' ? saveSymptom : saveDiagnosis,
      ),
    );
  }

  getIsFirstTime() async {
    isFirstTime = await SharedPrefService.getFirstTimeOnPrescriptionScreen() ?? true;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<SymptomsAndDiagnosisCubit>().fetchFrequentlySearchedSymptoms();
    getIsFirstTime();
    if (widget.selectedSymptoms != null && widget.selectedSymptoms!.isNotEmpty) {
      selectedSymptoms = widget.selectedSymptoms!;
      symptomsControllers = selectedSymptoms.map((e) => TextEditingController(text: e.name)).toList();
      symptomsLayerLinks = selectedSymptoms.map((e) => LayerLink()).toList();
      symptomsDurationControllers = selectedSymptoms.map((e) => TextEditingController(text: '${e.timePeriod} ${e.timeUnit}')).toList();
      symptomsDurationsLayerLinks = selectedSymptoms.map((e) => LayerLink()).toList();
    }
    if (widget.selectedDiagnosis != null && widget.selectedDiagnosis!.isNotEmpty) {
      selectedDiagnosis = widget.selectedDiagnosis!;
      diagnosisControllers = selectedDiagnosis.map((e) => TextEditingController(text: e.name)).toList();
      diagnosisLayerLinks = diagnosisLayerLinks.map((e) => LayerLink()).toList();
    }
  }

  @override
  void dispose() {
    //searchFocus.dispose();
    //searchController.dispose();
    super.dispose();
  }

  //bool get isSearching => searchFocus.hasFocus;

  @override
  Widget build(BuildContext context) {
    return BlocListener<SymptomsAndDiagnosisCubit, SymptomsAndDiagnosisState>(
      listener: (context, state) {
        if (state.state == SymptomsAndDiagnosisStates.fetchingSymptomAndPredictionForddxFailed) {
          showMessage(context, "Error", state.error?.content ?? "An error occured");
        } else if (state.state == SymptomsAndDiagnosisStates.symptomsAndDiagnosisPosted && !hasNavigated) {
          dev.log(state.state.toString());
          hasNavigated = true;
          context.read<SymptomsAndDiagnosisCubit>().getSavedSymptomsAndDiagnosis(appointmentId: widget.appointment.id!);
          context.pop();
        }
      },
      child: PopScope(
        onPopInvoked: (x) {
          context.read<SymptomsAndDiagnosisCubit>().getSavedSymptomsAndDiagnosis(appointmentId: widget.appointment.id!);
          context.pop();
        },
        canPop: false,
        child: Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              leadingWidth: 30,
              title: Text(
                AppText.digitalPrescription,
                style: GoogleFonts.urbanist(
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    height: 1.25,
                    color: AppColors.lightBlueColor,
                  ),
                ),
              ),
              backgroundColor: const Color(0xFFE1F9F2),
              actions: [
                IconButton(
                  onPressed: _toggleDrawer,
                  icon: Icon(_isDrawerOpen ? Icons.close : Icons.menu),
                ),
              ],
            ),
            endDrawer: VitalsAndPastHistoryEndDrawer(appointment: widget.appointment),
            body: GestureDetector(
              onTap: () {
                if (_overlayEntry != null) {
                  addSpace = false;
                  setState(() {});
                  _removeOverlay();
                }
              },
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: SingleChildScrollView(
                      controller: scrollController,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 17),
                          Text(
                            'Symptoms',
                            style: GoogleFonts.urbanist(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),

                          const SizedBox(
                            height: 8,
                          ),

                          BlocBuilder<SymptomsAndDiagnosisCubit, SymptomsAndDiagnosisState>(builder: (context, state) {
                            if (state.state == SymptomsAndDiagnosisStates.fetchingFrequentlySearchedSymptoms) {
                              return AppConstants.buildPlaceHolder(title: "Frequently searched Symptoms");
                            } else if (state.state == SymptomsAndDiagnosisStates.frequentlySearchedSymptomsFailed) {
                              return AppConstants.buildPlaceHolder(title: "Frequently searched Symptoms");
                            } else {
                              return buildSection(
                                  title: "Frequently searched Symptoms", color: AppColors.smokeGrey2, symptoms: state.frequentlySearchedSymptoms!);
                            }
                          }),
                          const Divider(
                            color: AppColors.lightGrey,
                          ),
                          BlocBuilder<SymptomsAndDiagnosisCubit, SymptomsAndDiagnosisState>(builder: (context, state) {
                            if (state.state == SymptomsAndDiagnosisStates.fetchingSymptomAndPredictionForddx) {
                              return AppConstants.buildPlaceHolder(title: "Associated Symptoms");
                            } else if (state.state == SymptomsAndDiagnosisStates.fetchingSymptomAndPredictionForddxFailed) {
                              return AppConstants.buildPlaceHolder(title: "Associated Symptoms");
                            } else {
                              return buildSection(
                                  title: "Associated Symptoms", color: const Color(0xff1B9C85), symptoms: state.associatedSymptoms ?? []);
                            }
                          }),

                          const Divider(
                            color: AppColors.lightGrey,
                          ),
                          Column(
                            children: [
                              Column(
                                children: List<Widget>.generate(
                                    symptomsControllers.length,
                                    (index) => Padding(
                                          padding: const EdgeInsets.only(bottom: 8),
                                          child: Row(
                                            children: [
                                              Visibility(
                                                  visible: onDeletePressedSx,
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(right: 8),
                                                    child: InkWell(
                                                      onTap: () {
                                                        selectedSymptoms.removeWhere((element) => element.name == symptomsControllers[index].text);
                                                        symptomsControllers.removeAt(index);
                                                        symptomsLayerLinks.removeAt(index);
                                                        symptomsDurationControllers.removeAt(index);
                                                        symptomsDurationsLayerLinks.removeAt(index);
                                                        onDeletePressedSx = false;
                                                        setState(() {});
                                                      },
                                                      child: CircleAvatar(
                                                          radius: 12,
                                                          backgroundColor: AppColors.accentColor2,
                                                          child: Icon(
                                                            Icons.close,
                                                            size: 20,
                                                          )),
                                                    ),
                                                  )),
                                              Expanded(
                                                flex: 2,
                                                child: CompositedTransformTarget(
                                                  link: symptomsLayerLinks[index],
                                                  child: CustomTextField(
                                                    borderRadius: 0,
                                                    contentPadding: EdgeInsets.fromLTRB(12, 14, 12, 14),
                                                    onTap: () {
                                                      if (_overlayEntry == null) {
                                                        _showOverlay(context, buildSymptomsResults(symptomsControllers[index]), index,
                                                            symptomsLayerLinks[index], false);
                                                        addSpace = true;
                                                        setState(() {});
                                                      } else {
                                                        addSpace = false;
                                                        setState(() {});
                                                        _removeOverlay();
                                                      }
                                                    },
                                                    controller: symptomsControllers[index],
                                                    maxLines: 3,
                                                    hintText: 'Symptom',
                                                    onChanged: (String query) {
                                                      if (_overlayEntry != null) {
                                                        _removeOverlay();
                                                        _showOverlay(context, buildSymptomsResults(symptomsControllers[index]), index,
                                                            symptomsLayerLinks[index], false);
                                                      } else {
                                                        _showOverlay(context, buildSymptomsResults(symptomsControllers[index]), index,
                                                            symptomsLayerLinks[index], false);
                                                      }
                                                    },
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Stack(
                                                  children: [
                                                    CompositedTransformTarget(
                                                      link: symptomsDurationsLayerLinks[index],
                                                      child: CustomTextField(
                                                        height: 52,
                                                        keyBoardType: TextInputType.number,
                                                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                                        borderRadius: 0,
                                                        onTap: () {
                                                          if (_overlayEntry == null) {
                                                            if (selectedSymptoms.isNotEmpty &&
                                                                ((selectedSymptoms.elementAtOrNull(index)?.name ?? "") != "")) {
                                                              _showOverlay(context, buildDuration(symptomsDurationControllers[index], index), index,
                                                                  symptomsDurationsLayerLinks[index], true);
                                                            }
                                                          } else {
                                                            _removeOverlay();
                                                          }
                                                        },
                                                        controller: symptomsDurationControllers[index],
                                                        hintText: 'x months',
                                                        onChanged: (String query) {
                                                          if (_overlayEntry != null) {
                                                            _removeOverlay();
                                                            if (selectedSymptoms.isNotEmpty &&
                                                                ((selectedSymptoms.elementAtOrNull(index)?.name ?? "") != "")) {
                                                              _showOverlay(context, buildDuration(symptomsDurationControllers[index], index), index,
                                                                  symptomsDurationsLayerLinks[index], true);
                                                            }
                                                          } else {
                                                            if (selectedSymptoms.isNotEmpty &&
                                                                ((selectedSymptoms.elementAtOrNull(index)?.name ?? "") != "")) {
                                                              _showOverlay(context, buildDuration(symptomsDurationControllers[index], index), index,
                                                                  symptomsDurationsLayerLinks[index], true);
                                                            }
                                                          }
                                                        },
                                                      ),
                                                    ),
                                                    Positioned(
                                                      right: 0,
                                                      child: SizedBox(
                                                        height: 50,
                                                        child: Column(
                                                          mainAxisSize: MainAxisSize.min,
                                                          children: [
                                                            InkWell(
                                                              onTap: () {
                                                                if (symptomsDurationControllers[index].text.isNotEmpty) {
                                                                  List<String> split = symptomsDurationControllers[index].text.split(' ');
                                                                  int i = int.parse(split[0]);
                                                                  i = i + 1;
                                                                  if (symptomsDurationControllers[index].text.endsWith('s')) {
                                                                    symptomsDurationControllers[index].text = '$i ${split[1]}';
                                                                  } else {
                                                                    symptomsDurationControllers[index].text = '$i ${split[1]}${i == 1 ? '' : 's'}';
                                                                  }
                                                                }
                                                              },
                                                              child: const Icon(Icons.arrow_drop_up),
                                                            ),
                                                            Spacer(),
                                                            InkWell(
                                                              onTap: () {
                                                                if (symptomsDurationControllers[index].text.isNotEmpty) {
                                                                  List<String> split = symptomsDurationControllers[index].text.split(' ');
                                                                  int i = int.parse(split[0]);
                                                                  if (i > 1) {
                                                                    i = i - 1;
                                                                    symptomsDurationControllers[index].text = '$i ${split[1]}';
                                                                  }
                                                                }
                                                              },
                                                              child: const Icon(Icons.arrow_drop_down),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  final List<Symptom> match =
                                                      selectedSymptoms.where((element) => element.name == symptomsControllers[index].text).toList();
                                                  if (match.isNotEmpty) {
                                                    _showBottomSheet(match[0]);
                                                  }
                                                },
                                                child: CircleAvatar(
                                                    radius: 12,
                                                    backgroundColor:
                                                        selectedSymptoms.isNotEmpty && (selectedSymptoms.elementAtOrNull(index)?.privateNote != null)
                                                            ? AppColors.greenCyan
                                                            : AppColors.darkBlueViolet,
                                                    child: Icon(
                                                      Icons.edit,
                                                      color: Colors.white,
                                                      size: 20,
                                                    )),
                                              )
                                            ],
                                          ),
                                        )),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Spacer(),
                                  InkWell(
                                    onTap: () {
                                      symptomsControllers.add(TextEditingController());
                                      symptomsLayerLinks.add(LayerLink());
                                      symptomsDurationControllers.add(TextEditingController());
                                      symptomsDurationsLayerLinks.add(LayerLink());
                                      setState(() {});
                                      if (isFirstTime) {
                                        SharedPrefService.setFirstTimeOnPrescriptionScreen(false);
                                        getIsFirstTime();
                                        if (symptomsControllers.length == 3) {
                                          Future.delayed(Duration(milliseconds: 800), () {
                                            isTooltipVisible2 = true;
                                            setState(() {});
                                          });
                                        }
                                      }
                                    },
                                    child: const CircleAvatar(
                                        radius: 15,
                                        backgroundColor: AppColors.greenCyan,
                                        child: Icon(
                                          Icons.add,
                                          color: Colors.white,
                                        )),
                                  ),
                                  Spacer(),
                                  InkWell(
                                    onTap: () {
                                      if (symptomsControllers.length > 2) {
                                        onDeletePressedSx = !onDeletePressedSx;
                                        setState(() {});
                                      }
                                    },
                                    child: Text(
                                      'Delete',
                                      style: GoogleFonts.urbanist(
                                        fontSize: 14,
                                        color: AppColors.redColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                          Text(
                            'Diagnosis',
                            style: GoogleFonts.urbanist(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          BlocBuilder<SymptomsAndDiagnosisCubit, SymptomsAndDiagnosisState>(builder: (context, state) {
                            if (state.state == SymptomsAndDiagnosisStates.fetchingSymptomAndPredictionForddx) {
                              return AppConstants.buildPlaceHolder(title: "Differential Diagnosis");
                            } else if (state.state == SymptomsAndDiagnosisStates.fetchingSymptomAndPredictionForddxFailed) {
                              return AppConstants.buildPlaceHolder(title: "Differential Diagnosis");
                            } else {
                              return buildSection(
                                  title: "Differential Diagnosis", color: const Color(0xff1B9C85), symptoms: state.differentialDiagnosis ?? []);
                            }
                          }),
                          const Divider(
                            color: AppColors.lightGrey,
                          ),
                          Column(
                            children: [
                              Column(
                                children: List<Widget>.generate(
                                    diagnosisControllers.length,
                                    (index) => Padding(
                                          padding: const EdgeInsets.only(bottom: 8),
                                          child: Row(
                                            children: [
                                              Visibility(
                                                  visible: onDeletePressedDx,
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(right: 8),
                                                    child: InkWell(
                                                      onTap: () {
                                                        selectedDiagnosis.removeWhere((element) => element.name == diagnosisControllers[index].text);
                                                        diagnosisControllers.removeAt(index);
                                                        diagnosisLayerLinks.removeAt(index);
                                                        onDeletePressedDx = false;
                                                        setState(() {});
                                                      },
                                                      child: CircleAvatar(
                                                          radius: 12,
                                                          backgroundColor: AppColors.accentColor2,
                                                          child: Icon(
                                                            Icons.close,
                                                            size: 20,
                                                          )),
                                                    ),
                                                  )),
                                              Expanded(
                                                child: CompositedTransformTarget(
                                                  link: diagnosisLayerLinks[index],
                                                  child: CustomTextField(
                                                    borderRadius: 0,
                                                    contentPadding: EdgeInsets.fromLTRB(12, 14, 12, 14),
                                                    onTap: () {
                                                      if (_overlayEntry == null) {
                                                        _showOverlay(context, buildDiagnosisResults(diagnosisControllers[index]), index,
                                                            diagnosisLayerLinks[index], false);
                                                        addSpace = true;
                                                        setState(() {});
                                                      } else {
                                                        _removeOverlay();
                                                        addSpace = false;
                                                        setState(() {});
                                                      }
                                                    },
                                                    maxLines: 3,
                                                    controller: diagnosisControllers[index],
                                                    hintText: 'Diagnosis',
                                                    onChanged: (String query) {
                                                      if (_overlayEntry != null) {
                                                        _removeOverlay();
                                                        _showOverlay(context, buildDiagnosisResults(diagnosisControllers[index]), index,
                                                            diagnosisLayerLinks[index], false);
                                                        addSpace = true;
                                                        setState(() {});
                                                      } else {
                                                        _showOverlay(context, buildDiagnosisResults(diagnosisControllers[index]), index,
                                                            diagnosisLayerLinks[index], false);
                                                        addSpace = true;
                                                        setState(() {});
                                                      }
                                                    },
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  final List<Symptom> match =
                                                      selectedDiagnosis.where((element) => element.name == diagnosisControllers[index].text).toList();
                                                  if (match.isNotEmpty) {
                                                    _showBottomSheet(match[0]);
                                                  }
                                                },
                                                child: CircleAvatar(
                                                    radius: 12,
                                                    backgroundColor: selectedDiagnosis.isNotEmpty &&
                                                            (selectedDiagnosis.elementAtOrNull(index)?.privateNote != null)
                                                        ? AppColors.greenCyan
                                                        : AppColors.darkBlueViolet,
                                                    child: Icon(
                                                      Icons.edit,
                                                      color: Colors.white,
                                                      size: 20,
                                                    )),
                                              )
                                            ],
                                          ),
                                        )),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Spacer(),
                                  InkWell(
                                    onTap: () {
                                      diagnosisControllers.add(TextEditingController());
                                      diagnosisLayerLinks.add(LayerLink());

                                      setState(() {});
                                    },
                                    child: const CircleAvatar(
                                        radius: 15,
                                        backgroundColor: AppColors.greenCyan,
                                        child: Icon(
                                          Icons.add,
                                          color: Colors.white,
                                        )),
                                  ),
                                  Spacer(),
                                  InkWell(
                                    onTap: () {
                                      if (diagnosisControllers.length > 2) {
                                        onDeletePressedDx = !onDeletePressedDx;
                                        setState(() {});
                                      }
                                    },
                                    child: Text(
                                      'Delete',
                                      style: GoogleFonts.urbanist(
                                        fontSize: 14,
                                        color: AppColors.redColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),

                          addSpace ? const SizedBox(height: 300) : const SizedBox(height: 30)

                          //? RECOMMENDATIONS OR SEARCH RESULTS
                          //isSearching ? buildSearchResults() : buildSymptomsRecommendation()
                        ],
                      ),
                    ),
                  ),
                  if (isTooltipVisible1 || isTooltipVisible2)
                    Positioned.fill(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
                        child: Container(
                          color: Colors.black.withOpacity(0.5), // Optional: Add semi-transparent overlay
                        ),
                      ),
                    ),
                  if (isTooltipVisible2)
                    Positioned(
                      top: 55,
                      left: 16,
                      child: Material(
                          color: Colors.transparent,
                          child: Stack(
                            children: [
                              // Tooltip Container
                              Container(
                                width: 300,
                                padding: EdgeInsets.all(10),
                                margin: EdgeInsets.only(top: 18), // Adjust margin for close button space
                                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(15))),
                                child: Text('Tip 2 - \n\nTap the Refresh icon to use AI Predictions'),
                              ),
                              // Close Button
                              Positioned(
                                top: 0,
                                right: 0,
                                child: GestureDetector(
                                  onTap: () {
                                    isTooltipVisible2 = false;
                                    setState(() {});
                                  },
                                  child: CircleAvatar(
                                      radius: 12,
                                      backgroundColor: AppColors.accentColor2,
                                      child: Icon(
                                        Icons.close,
                                        size: 20,
                                      )),
                                ),
                              ),
                            ],
                          )),
                    ),
                  if (isTooltipVisible1)
                    Positioned(
                      top: 350,
                      left: 16,
                      child: Material(
                          color: Colors.transparent,
                          child: Stack(
                            children: [
                              // Tooltip Container
                              Container(
                                width: 300,
                                padding: EdgeInsets.all(10),
                                margin: EdgeInsets.only(top: 18), // Adjust margin for close button space
                                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(15))),
                                child: Text('Tip 1 - \n\nTap the Add icon to add more Symptoms fields'),
                              ),
                              // Close Button
                              Positioned(
                                top: 0,
                                right: 0,
                                child: GestureDetector(
                                  onTap: () {
                                    isTooltipVisible1 = false;
                                    setState(() {});
                                  },
                                  child: CircleAvatar(
                                      radius: 12,
                                      backgroundColor: AppColors.accentColor2,
                                      child: Icon(
                                        Icons.close,
                                        size: 20,
                                      )),
                                ),
                              ),
                            ],
                          )),
                    )
                ],
              ),
            ),
            bottomNavigationBar: selectedSymptoms.isNotEmpty || selectedDiagnosis.isNotEmpty
                ? BlocBuilder<SymptomsAndDiagnosisCubit, SymptomsAndDiagnosisState>(builder: (context, state) {
                    if (state.state == SymptomsAndDiagnosisStates.postingSymptomsAndDiagnosis) {
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
                                      selectedSymptoms.clear();
                                    }))),

                        const SizedBox(width: 20),

                        //? CLEAR
                        Expanded(
                            child: MyElevatedButton(
                                text: "Save",
                                height: 58,
                                textStyle: const TextStyle(fontSize: 15),
                                onPressed: () {
                                  dev.log(selectedSymptoms.map((e) => e.toSxMap()).toList().toString());
                                  dev.log(selectedDiagnosis.map((e) => e.toDxMap()).toList().toString());
                                  hasNavigated = false;
                                  context.read<SymptomsAndDiagnosisCubit>().postSymptomsAndDiagnosis(
                                      patientId: widget.appointment.patientId!,
                                      appointmentId: widget.appointment.id!,
                                      symptoms: selectedSymptoms.map((e) => e.toSxMap()).toList(),
                                      diagnosis: selectedDiagnosis.map((e) => e.toDxMap()).toList());
                                })),
                      ]).pSymmetric(vertical: 8);
                    }
                  })
                : Container(height: 0)),
      ),
    );
  }

  void _showOverlay(BuildContext context, Widget widget, int index, LayerLink layerLink, bool isDuration) {
    _overlayEntry = _createOverlayEntry(widget, index, layerLink, isDuration);
    Overlay.of(context)?.insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  OverlayEntry _createOverlayEntry(Widget widget, int index, LayerLink layerLink, bool isDuration) {
    return OverlayEntry(
      builder: (context) => Positioned(
        width: isDuration ? 106 : 360,
        child: CompositedTransformFollower(
          link: layerLink,
          showWhenUnlinked: false,
          offset: Offset(0.0, 60.0),
          child: Material(elevation: 1.0, child: Container(height: isDuration ? null : 325, child: SingleChildScrollView(child: widget))),
        ),
      ),
    );
  }

  Widget buildDuration(TextEditingController durationController, int idx) {
    String x = durationController.text;
    if (x.split(' ').length > 1) {
      x = x.split(' ')[0];
    }
    List<String> options = [
      x == '1' ? '$x hr' : '$x hrs',
      x == '1' ? '$x day' : '$x days',
      x == '1' ? '$x week' : '$x weeks',
      x == '1' ? '$x month' : '$x months',
      x == '1' ? '$x year' : '$x years'
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List<Widget>.generate(
          options.length,
          (index) => InkWell(
                onTap: () {
                  durationController.text = options[index];
                  Symptom updated = selectedSymptoms.elementAt(idx).copyWith(
                        timePeriod: int.parse(durationController.text.split(' ')[0]),
                        timeUnit: durationController.text.split(' ')[1],
                      );
                  //updates the set with the modified symptom and return others too
                  selectedSymptoms = selectedSymptoms.map((item) => item.name == updated.name ? updated : item).toSet();
                  setState(() {});
                  log(updated);
                  log(selectedSymptoms);
                  _removeOverlay();
                },
                child: Container(
                    height: 52,
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 15),
                    width: double.infinity,
                    margin: EdgeInsets.only(bottom: 5),
                    decoration: BoxDecoration(color: AppColors.lightGrey),
                    child: Text(
                      options[index],
                      style: GoogleFonts.urbanist(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    )),
              )),
    );
  }

  Widget buildSymptomsResults(TextEditingController searchController) {
    return Builder(
      builder: (context) {
        final List<Symptom> match = SampleObjects.symptoms.where((el) {
          final regex = RegExp(searchController.text.trim(), caseSensitive: false);

          return regex.hasMatch(el.name);
        }).toList();

        return ListView(padding: EdgeInsets.all(0), physics: NeverScrollableScrollPhysics(), shrinkWrap: true, children: [
          ...List<Widget>.generate(match.length, (index) {
            final symptom = match.elementAt(index);
            return TextListTile(
              text: symptom.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              onTap: () {
                // searchFocus.unfocus();
                addSpace = false;
                searchController.text = symptom.name;
                selectedSymptoms.add(symptom);
                if (isFirstTime) {
                  if (selectedSymptoms.length == 2) {
                    scrollController.jumpTo(0);
                    isTooltipVisible1 = true;
                    setState(() {});
                  }
                }

                log(selectedSymptoms);
                _removeOverlay();
              },
            ).pOnly(bottom: 8);
          })
        ]);
      },
    );
  }

  Widget buildDiagnosisResults(TextEditingController searchController) {
    return Builder(
      builder: (context) {
        final List<Symptom> match = SampleObjects.diagnosis.where((el) {
          final regex = RegExp(searchController.text.trim(), caseSensitive: false);

          return regex.hasMatch(el.name);
        }).toList();

        return ListView(physics: NeverScrollableScrollPhysics(), padding: EdgeInsets.all(0), shrinkWrap: true, children: [
          ...List<Widget>.generate(match.length, (index) {
            final symptom = match.elementAt(index);
            return TextListTile(
              text: symptom.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              onTap: () {
                // searchFocus.unfocus();
                searchController.text = symptom.name;
                selectedDiagnosis.add(symptom);
                addSpace = false;
                setState(() {});
                log(selectedDiagnosis);
                _removeOverlay();
              },
            ).pOnly(bottom: 8);
          })
        ]);
      },
    );
  }

  Widget buildSection({required String title, required List<Symptom> symptoms, Color? color}) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          title == 'Frequently searched Symptoms'
              ? InkWell(
                  onTap: () {
                    BlocProvider.of<SymptomsAndDiagnosisCubit>(context).fetchFrequentlySearchedSymptoms();
                  },
                  child: const Icon(
                    Icons.refresh,
                    color: Color.fromARGB(255, 23, 16, 59),
                  ),
                )
              : title == 'Associated Symptoms' || title == 'Differential Diagnosis'
                  ? InkWell(
                      onTap: () {
                        if (selectedSymptoms.isNotEmpty) {
                          BlocProvider.of<SymptomsAndDiagnosisCubit>(context)
                              .ddxPredictions(selectedSymptoms.map((e) => e.name).toList(), selectedDiagnosis.map((e) => e.name).toList());
                        }
                      },
                      child: const Icon(
                        Icons.refresh,
                        color: Color.fromARGB(255, 23, 16, 59),
                      ),
                    )
                  : Container()
        ],
      ),
      const SizedBox(
        height: 12,
      ),
      Wrap(
        spacing: 4,
        runSpacing: 10,
        children: [
          ...List<Widget>.generate(symptoms.length, (index) {
            final symptom = symptoms.elementAt(index);

            return GestureDetector(
              onTap: () {
                if (title == 'Differential Diagnosis') {
                  TextEditingController controller = diagnosisControllers.firstWhere((element) => element.text == "");
                  controller.text = symptom.name;
                  selectedDiagnosis.add(symptom);
                } else {
                  TextEditingController controller = symptomsControllers.firstWhere((element) => element.text == "");
                  controller.text = symptom.name;
                  selectedSymptoms.add(symptom);
                }
              },
              child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  decoration: const BoxDecoration(color: AppColors.whiteSmoke2),
                  child: Text(
                    symptom.name.capitalize,
                  )),
            );
          }),
        ],
      ),
    ]);
  }

  void saveSymptom(Symptom newSymptom) {
    setState(() {
      if (selectedSymptoms.contains(newSymptom)) {
        log("UPDATE SYMPTOM");
        selectedSymptoms = selectedSymptoms.map((symptom) => symptom.name == newSymptom.name ? newSymptom : symptom).toSet();
      } else {
        log("ADD NEW SYMPTOM");
        selectedSymptoms.add(newSymptom);
      }
    });
  }

  void saveDiagnosis(Symptom newSymptom) {
    setState(() {
      if (selectedDiagnosis.contains(newSymptom)) {
        log("UPDATE SYMPTOM");
        selectedDiagnosis = selectedDiagnosis.map((symptom) => symptom.name == newSymptom.name ? newSymptom : symptom).toSet();
      } else {
        log("ADD NEW SYMPTOM");
        selectedDiagnosis.add(newSymptom);
      }
    });
  }
}

class MyIconContainer extends StatelessWidget {
  const MyIconContainer({super.key, required this.icon, this.backgroundColor = Colors.white, this.size, this.onTap});

  final Widget icon;
  final Color backgroundColor;
  final void Function()? onTap;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(width: size ?? 24, height: size ?? 24, decoration: BoxDecoration(color: backgroundColor, shape: BoxShape.circle), child: icon),
    );
  }
}
