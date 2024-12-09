import 'package:flutter/material.dart';
import 'dart:developer' as dev;
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healtether_clinic_app/Screens/AppointmentScreen/widgets/custom_textfield.dart';
import 'package:healtether_clinic_app/Screens/DigitalScreensAll/symptoms_diagnosis/create_digital_prescription_screens.dart';
import 'package:healtether_clinic_app/business_logic/cubits/drug_cubit/drug_prescription_cubit.dart';
import 'package:healtether_clinic_app/constants/app_text.dart';
import 'package:healtether_clinic_app/data_layer/models/appointment_models/appointment_model.dart';
import 'package:healtether_clinic_app/data_layer/models/appointment_slot/time_slot.dart';
import 'package:healtether_clinic_app/data_layer/models/drug_model/drug_model.dart';
import 'package:healtether_clinic_app/data_layer/sample_objects/sample_objects.dart';
import 'package:healtether_clinic_app/constants/app_constants.dart';
import 'package:healtether_clinic_app/constants/app_colors.dart';
import 'package:healtether_clinic_app/utils/enums/bloc_enums.dart';
import 'package:healtether_clinic_app/utils/extensions.dart/string_extensions.dart';
import 'package:healtether_clinic_app/utils/extensions.dart/widget_extensions.dart';
import 'package:healtether_clinic_app/utils/helper_functions/log.dart';
import 'package:healtether_clinic_app/utils/mixins/device_info_mixin.dart';
import 'package:healtether_clinic_app/utils/mixins/time_parser_mixin.dart';
import 'package:healtether_clinic_app/utils/mixins/ui_info_mixin.dart';
import 'package:healtether_clinic_app/utils/snackbar.dart';
import 'package:healtether_clinic_app/widgets/buttons/my_selectable_container.dart';
import 'package:healtether_clinic_app/widgets/components/build_section.dart';
import 'package:healtether_clinic_app/widgets/components/dual_action_bottom_nav.dart';
import 'package:healtether_clinic_app/widgets/components/my_search_bar.dart';
import 'package:healtether_clinic_app/widgets/components/vitals_and_past_history_end_drawer.dart';
import 'package:healtether_clinic_app/widgets/section_text.dart';
import 'package:healtether_clinic_app/widgets/buttons/my_elevated_button.dart';
import 'package:healtether_clinic_app/widgets/text_list_tile.dart';
import 'package:healtether_clinic_app/widgets/time_slot_item.dart';
import 'package:intl/intl.dart';

class DigitalPrecriptionScreen extends StatefulWidget {
  final Appointment appointment;
  final Map<String, dynamic>? savedDrugPrescription;
  const DigitalPrecriptionScreen({super.key, required this.appointment, this.savedDrugPrescription});

  @override
  State<DigitalPrecriptionScreen> createState() => _DigitalPrecriptionScreenState();
}

class _DigitalPrecriptionScreenState extends State<DigitalPrecriptionScreen> with DeviceInfoMixin, TimeParserMixin, UiInfoMixin {
  bool hasNavigated = false;
  final TextEditingController searchController = TextEditingController();
  final TextEditingController diet = TextEditingController();
  final TextEditingController otherInstructions = TextEditingController();
  final FocusNode searchBarFocusNode = FocusNode();
  Map<String, DateTime?> followUpDate = {};
  TextEditingController customfollowUpDateController = TextEditingController();
  //TextEditingController followUpTimeHourController = TextEditingController();
  //TextEditingController followUpTimeMinController = TextEditingController();
  // bool isAm = false;
  //bool isPm = false;
  TimeSlot timeSlot = const TimeSlot('');
  bool forceStillTyping = false;
  bool get isTyping => forceStillTyping || searchBarFocusNode.hasFocus;
  TextStyle get subtitleTextStyle => GoogleFonts.urbanist(textStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14, height: 17.36 / 14));

  List<Drug> selectedDrugs = [];

  @override
  void initState() {
    super.initState();
    context.read<DrugPrescriptionCubit>().fetchFrequentlySearchedDrugs();
    selectedDrugs = widget.savedDrugPrescription?['drugs'] ?? [];
    diet.text = widget.savedDrugPrescription?['patientAdvice'] ?? '';
    otherInstructions.text = widget.savedDrugPrescription?['privateNotes'] ?? '';
    followUpDate = widget.savedDrugPrescription?['followUpDate'] == null
        ? {'None': null}
        : {'Custom': DateTime.parse(widget.savedDrugPrescription?['followUpDate'])};
    String? start = widget.savedDrugPrescription?['followUpTimeSlot'].toString().split('-')[0];
    String? finish = widget.savedDrugPrescription?['followUpTimeSlot'].toString().split('-')[1];
    /* if (start != null) {
      timeSlot = timeSlot.copyWith(start: TimeOfDay.fromDateTime(DateFormat("h:mm a").parse(start.toString())));
    } else {}
    if (finish != null) {
      timeSlot = timeSlot.copyWith(start: TimeOfDay.fromDateTime(DateFormat("h:mm a").parse(finish.toString())));
    } else {}*/
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          leadingWidth: 30,
          leading: InkWell(
              onTap: () {
                if (isTyping) {
                  searchController.clear();
                  searchBarFocusNode.unfocus();
                  forceStillTyping = false;
                  setState(() {});
                } else {
                  context.pop();
                }
              },
              child: const Padding(
                padding: EdgeInsets.only(left: 8),
                child: Icon(Icons.arrow_back),
              )),
          title: Text(
            AppText.digitalPrescription,
            style: GoogleFonts.montserrat(
              textStyle: const TextStyle(
                fontSize: 18,
                fontFamily: 'Urbanist',
                fontWeight: FontWeight.w500,
                height: 1.25,
                color: AppColors.lightBlueColor,
              ),
            ),
          ),
          backgroundColor: const Color(0xFFE1F9F2),
          actions: [
            IconButton(
              onPressed: () {
                _scaffoldKey.currentState?.openEndDrawer();
              },
              icon: const Icon(Icons.menu),
            ),
          ],
        ),
        endDrawer: VitalsAndPastHistoryEndDrawer(appointment: widget.appointment),
        body: BlocListener<DrugPrescriptionCubit, DrugPrescriptionState>(
          listener: (context, state) {
            if (state.state == DrugPrescriptionStates.drugPrescriptionPosted && !hasNavigated) {
              dev.log(state.state.toString());
              hasNavigated = true;
              showSnackbar("Drug prescription saved successfully", context);
              context.read<DrugPrescriptionCubit>().getSavedDrugPrescription(appointmentId: widget.appointment.id!);
              context.pop();
            }
          },
          child: BlocBuilder<DrugPrescriptionCubit, DrugPrescriptionState>(builder: (context, state) {
            return CustomScrollView(
              slivers: [
                const SliverToBoxAdapter(child: SizedBox(height: 19)),

                // //? TITLE
                SliverToBoxAdapter(
                  child: const SectionText(
                    "DRUG PRESCRIPTION & FOLLOW-UP",
                    textStyle: TextStyle(fontSize: 20, height: 24 / 20),
                    underlineWidth: double.maxFinite,
                    underlineColor: AppColors.eerieBlack,
                  ).pSymmetric(),
                ),

                const SliverToBoxAdapter(child: SizedBox(height: 12)),

                // //? SEARCH BAR
                SliverToBoxAdapter(
                  child: MySearchBar(
                    searchController: searchController,
                    hintText: "Search by brand or generic name",
                    focusNode: searchBarFocusNode,
                    onChanged: (value) {
                      context.read<DrugPrescriptionCubit>().searchDrugs(value);
                      log("Searching...");
                      setState(() {});
                    },
                    onEditingComplete: () {
                      searchBarFocusNode.unfocus();
                      forceStillTyping = true;
                    },
                  ).pSymmetric(),
                ),

                const SliverToBoxAdapter(child: SizedBox(height: 10)),

                isTyping
                    ? buildTypingView() // view when the doctor is searching for drugs
                    : selectedDrugs?.isNotEmpty == true
                        ? SliverToBoxAdapter(child: buildAddDrugsView()) // view when the doctor has saved atleast one drug for this patient
                        : buildNotTypingView(state)
                // view when the doctor is not typing and has not saved any drug
              ],
            );
          }),
        ),
        bottomNavigationBar: BlocBuilder<DrugPrescriptionCubit, DrugPrescriptionState>(builder: (context, state) {
          if (state.state == DrugPrescriptionStates.postingDrugPrescription) {
            return const SizedBox(height: 100, child: Center(child: CircularProgressIndicator()));
          } else {
            return DualActionBottomNav(
                text: "Clear All",
                focusedText: "Save",
                onPressed: () {
                  setState(() {
                    selectedDrugs.clear();
                    searchController.text = "";
                    diet.text = "";
                    otherInstructions.text = "";
                    followUpDate = {};
                    customfollowUpDateController.text = "";
                    // followUpTimeHourController.text = "";
                    //followUpTimeMinController.text = "";
                  });
                },
                onFocusedPressed: () {
                  if (selectedDrugs.isNotEmpty) {
                    dev.log("${timeSlot.start?.format(context) ?? ''} - ${timeSlot.finish?.format(context)}");
                    // dev.log(selectedDrugs.map((e) => e.toMap()).toList().toString());
                    hasNavigated = false;
                    context.read<DrugPrescriptionCubit>().postDrugPrescription(
                          patientId: widget.appointment.patientId!,
                          appointmentId: widget.appointment.id!,
                          drugs: selectedDrugs.map((e) => e.toMap()).toList(),
                          patientAdvice: diet.text,
                          privateNotes: otherInstructions.text,
                          followupDate: () {
                            if (followUpDate.values.isNotEmpty) {
                              //there can be only one value
                              DateTime? date = followUpDate.values.elementAt(0);
                              if (date != null) {
                                return '${date.year.toString()}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
                              } else {
                                return '';
                              }
                            } else {
                              return '';
                            }
                          }(),
                          followupTimeSlot: "${timeSlot.start?.format(context) ?? ''} - ${timeSlot.finish?.format(context)}",
                        );
                  }
                });
          }
        }));
  }

  Widget buildAddDrugsView() {
    return BlocBuilder<DrugPrescriptionCubit, DrugPrescriptionState>(builder: (context, state) {
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // add drugs
        ...List<Widget>.generate(selectedDrugs?.length ?? 0, (index) {
          final drug = selectedDrugs!.elementAt(index);

          return Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(7), color: AppColors.accentColor2),
              child: Row(
                children: [
                  DrugType(drug: drug),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Text(drug.name,
                        style: GoogleFonts.urbanist(textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17, height: 23.12 / 17))),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  MyIconContainer(
                      onTap: () {
                        log("REMOVE: $drug");
                        selectedDrugs.remove(drug);
                        setState(() {});
                      },
                      icon: const Icon(Icons.close, color: AppColors.darkBlueViolet, size: 18))
                ],
              )).pOnly(left: 16, right: 16, bottom: 10);
        }),

        const SizedBox(height: 10),

        //? add more drugs
        Center(
            child: SizedBox(
                width: screenDimensions(context).width - 32,
                child: MyElevatedButton(
                  text: "Add more drugs",
                  height: 55,
                  onPressed: () {
                    setState(() {
                      searchBarFocusNode.requestFocus();
                    });
                  },
                ))),

        //? ADVICE / PRECAUTIONS
        const SectionText(
          "ADVICE / PRECAUTIONS",
          textStyle: TextStyle(fontSize: 20, height: 24 / 20),
          underlineWidth: double.maxFinite,
          underlineColor: AppColors.eerieBlack,
        ).pOnly(left: 16, right: 16, top: 12, bottom: 8),

        // Diet
        TitledTextField(title: "Diet", controller: diet, hintText: "e.g Balanced diet", maxLines: 8, minLines: 8).pOnly(bottom: 16),

        // Other instructions
        TitledTextField(title: "Other instructions", controller: otherInstructions, hintText: "e.g Some other instruction", maxLines: 8, minLines: 8),

        const SizedBox(
          height: 16,
        ),

        //? FOLLOW UP
        buildSectionText("FOLLOW-UP").pOnly(left: 16, right: 16, top: 12, bottom: 8),
        // follow up date
        Text(
          'Follow-up date',
          style: GoogleFonts.urbanist(
              textStyle: const TextStyle(color: AppColors.eerieBlack, fontWeight: FontWeight.w700, fontSize: 14, height: 17.36 / 14)),
        ).pOnly(left: 16, right: 16, bottom: 12),

        Wrap(
            spacing: 8,
            runSpacing: 8,
            children: List<Widget>.generate(AppConstants.followUpDate.keys.length, (index) {
              final key = AppConstants.followUpDate.keys.elementAt(index);
              DateTime? date = AppConstants.followUpDate[key];
              return SelectableContainer(
                selected: followUpDate.keys.contains(key),
                onTap: () async {
                  setState(() {
                    followUpDate = {key: date};
                  });
                  log("KEY, DATE, FOLLOW-UP DATE: $key, $date, $followUpDate");
                },
                title: Text(key, style: const TextStyle(color: AppColors.eerieBlack, fontWeight: FontWeight.w500)),
                selectedTitle: Text(key, style: const TextStyle(color: AppColors.whiteSmoke3, fontWeight: FontWeight.w500)),
              );
            })).pSymmetric(),
        if (followUpDate.keys.contains('Custom'))
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            child: CustomTextField(
              controller: customfollowUpDateController,
              usePadding: false,
              readOnly: true,
              hintText: "06-03-2024",
              onTap: () async {
                DateTime? date = AppConstants.followUpDate['Custom'];
                date = await pickDate(context, returnDateObject: true);
                if (date != null) {
                  customfollowUpDateController.text =
                      '${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year.toString()}';
                }
                setState(() {
                  followUpDate = {'Custom': date};
                });
              },
              borderRadius: 0,
              suffixIcon: const Icon(Icons.arrow_drop_down_rounded),
              fillColor: AppColors.whiteSmoke,
            ),
          ),
        SizedBox(
          height: followUpDate.keys.contains('Custom') ? 6 : 16,
        ),
        Text(
          'Time',
          style: GoogleFonts.urbanist(
              textStyle: const TextStyle(color: AppColors.eerieBlack, fontWeight: FontWeight.w700, fontSize: 14, height: 17.36 / 14)),
        ).pOnly(left: 16, right: 16, bottom: 12),
        /* Row(
          children: [
            Expanded(
                child: CustomTextField(
              readOnly: followUpDate.keys.contains('None'),
              controller: followUpTimeHourController,
              hintText: '5',
              suffixText: 'hrs',
            )),
            const SizedBox(
              width: 8,
            ),
            Expanded(
                child: CustomTextField(
              readOnly: followUpDate.keys.contains('None'),
              controller: followUpTimeMinController,
              hintText: '30',
              suffixText: 'mins',
            )),
            const SizedBox(
              width: 8,
            ),
            InkWell(
              onTap: () {
                isAm = true;
                isPm = false;
                setState(() {});
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                decoration: BoxDecoration(
                    color: isAm && !followUpDate.keys.contains('None') ? AppColors.darkTeal : AppColors.whiteSmoke,
                    borderRadius: BorderRadius.circular(8)),
                child: Text('am', style: TextStyle(color: isAm && !followUpDate.keys.contains('None') ? Colors.white : Colors.black)),
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            InkWell(
              onTap: () {
                isAm = false;
                isPm = true;
                setState(() {});
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                decoration: BoxDecoration(
                    color: isPm && !followUpDate.keys.contains('None') ? AppColors.darkTeal : AppColors.whiteSmoke,
                    borderRadius: BorderRadius.circular(8)),
                child: Text('pm', style: TextStyle(color: isPm && !followUpDate.keys.contains('None') ? Colors.white : Colors.black)),
              ),
            )
          ],
        ).pSymmetric(),*/
        TimeSlotItem(
                slot: timeSlot,
                onTap: () => {},
                selected: true,
                onStartChanged: (newTime) {
                  timeSlot = timeSlot.copyWith(start: newTime);
                },
                onFinishChanged: (newTime) {
                  timeSlot = timeSlot.copyWith(finish: newTime);
                },
                showDelete: false,
                onDelete: () {})
            .pSymmetric(),

        const SizedBox(
          height: 24,
        ),
      ]);
    });
  }

  SectionText buildSectionText(String text) {
    return SectionText(
      text,
      textStyle: const TextStyle(fontSize: 20, height: 24 / 20),
      underlineWidth: double.maxFinite,
      underlineColor: AppColors.eerieBlack,
    );
  }

  Widget buildTypingView() {
    return BlocBuilder<DrugPrescriptionCubit, DrugPrescriptionState>(builder: (context, state) {
      if (state.state == DrugPrescriptionStates.searchingForDrugs) {
        return SliverToBoxAdapter(child: Container());
      } else if (state.state == DrugPrescriptionStates.searchingForDrugsFailed) {
        return SliverToBoxAdapter(child: Container());
      } else {
        return SliverList.builder(
            itemCount: state.drugs?.length ?? 0,
            itemBuilder: (context, index) {
              final drug = state.drugs!.elementAt(index);

              return GestureDetector(
                onTap: () async {
                  await selectDrug(context, drug);
                  setState(() {});
                },
                child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(color: AppColors.whiteSmoke, borderRadius: BorderRadius.circular(2)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //? DRUG NAME
                            Text(drug.name.capitalize,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.urbanist(
                                        textStyle: const TextStyle(
                                            fontWeight: FontWeight.w500, fontSize: 17, height: 22.78 / 17, color: AppColors.eerieBlack)))
                                .pOnly(bottom: 12),

                            //? CONTENTS
                            Text(drug.name.capitalize,
                                style: GoogleFonts.urbanist(
                                    textStyle:
                                        const TextStyle(fontWeight: FontWeight.w500, fontSize: 12, height: 14.4 / 12, color: AppColors.blueViolet)))
                          ],
                        ),
                        DrugType(drug: drug)
                      ],
                    )).pOnly(left: 16, right: 16, bottom: 10),
              );
            });
      }
    });
  }

  Widget buildNotTypingView(DrugPrescriptionState state) {
    if (state.state == DrugPrescriptionStates.fetchingFrequentlySearchedDrugs) {
      return SliverToBoxAdapter(child: AppConstants.buildPlaceHolder(title: 'Frequently searched drugs').pSymmetric());
    } else if (state.state == DrugPrescriptionStates.frequentlySearchedDrugsFailed) {
      return SliverToBoxAdapter(child: AppConstants.buildPlaceHolder(title: 'Frequently searched drugs').pSymmetric());
    } else {
      return SliverToBoxAdapter(
        child: Column(
          children: [
            //? SUGGESTED DRUGS
            /* BuildSection(
            title: "Suggested drugs",
            children: List<Widget>.generate(
                // TODO: REPLACE WITH SUGGESTED DRUGS FROM API
                SampleObjects.drugs.sublist(0, 6).length, (index) {
              Drug drug = SampleObjects.drugs.sublist(0, 6).elementAt(index);

              // String? selectedFrequency;

              return SelectableContainer(
                title: Text(drug.name),
                onTap: () {
                  selectDrug(context, drug);
                },
              );
            }),
          ),

          const SizedBox(
            height: 16,
          ),*/

            //? FREQUENTLY SEARCHED DRUGS
            // TODO: REPLACE WITH FREQUENTLY SEARCHED DRUGS FROM API
            BuildSection(
              title: "Frequently searched drugs",
              textStyle: const TextStyle(color: AppColors.grey),
              children: List<Widget>.generate(state.frequentlySearchedDrugs?.length ?? 0, (index) {
                final drug = state.frequentlySearchedDrugs!.elementAt(index);

                return SelectableContainer(
                  title: Text(drug.name),
                  onTap: () async {
                    log("${drug.name} TAPPED");
                    await selectDrug(context, drug);
                    setState(() {});
                  },
                );
              }),
            )
          ],
        ).pSymmetric(),
      );
    }
  }

  Future<dynamic> selectDrug(BuildContext context, Drug drug) {
    final drugName = TextEditingController(text: drug.name);
    final dosage = TextEditingController(text: drug.quantity?.toString() ?? '');
    final focusNode = FocusNode();
    bool editDrugName = false;
    bool other = false;
    return showModalBottomSheet(
        context: context,
        isDismissible: false,
        isScrollControlled: true,
        builder: (context) {
          String patientId = widget.appointment.patientId!;
          return StatefulBuilder(builder: (context, setState) {
            return ClipRRect(
              borderRadius: const BorderRadius.only(topRight: Radius.circular(16), topLeft: Radius.circular(16)),
              child: SizedBox(
                height: screenDimensions(context).height * 3 / 4,
                child: Scaffold(
                  backgroundColor: Colors.white,
                  body: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //? DRUG DESCRIPTION
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(color: AppColors.whiteSmoke, borderRadius: BorderRadius.circular(7)),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // editable drug name | save or edit icon
                              Row(
                                children: [
                                  Expanded(
                                      child: CustomTextField(
                                    controller: drugName,
                                    hintText: "Enter drug name",
                                    fillColor: Colors.transparent,
                                    usePadding: false,
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                                    focusNode: focusNode,
                                    readOnly: !editDrugName,
                                    validator: (value) => value?.isEmpty == true ? "Drug name cannot be empty" : null,
                                  )),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  MyIconContainer(
                                    onTap: () {
                                      setState(() {
                                        editDrugName = !editDrugName;
                                        log("setstate called, edit: $editDrugName");
                                        if (editDrugName == true) {
                                          focusNode.requestFocus();
                                        } else {
                                          log("Save new drug name");

                                          drug = drug.copyWith(name: drugName.text);

                                          searchController.clear();
                                        }
                                      });
                                    },
                                    backgroundColor: AppColors.grey3,
                                    icon: Icon(editDrugName ? Icons.check : Icons.edit, color: AppColors.darkBlueViolet, size: 18),
                                  )
                                ],
                              ),

                              const SizedBox(height: 4),

                              /*  //? contents: content
                              RichText(
                                  text: TextSpan(
                                      text: "Contents: ",
                                      style: GoogleFonts.urbanist(
                                          textStyle:
                                              const TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 14, height: 17.36 / 14)),
                                      children: [
                                    TextSpan(
                                        text: drug.contents,
                                        style: const TextStyle(
                                          color: AppColors.blueViolet,
                                        ))
                                  ])),*/

                              //? drug type
                              // if (drug.type != null) const SizedBox(height: 10),

                              //if (drug.type != null) DrugType(drug: drug)
                            ],
                          ),
                        ).pOnly(left: 16, right: 16, top: 16, bottom: 6),

                        //? QUANTITY / DOSAGE
                        Text("Quantity/Dosage", style: subtitleTextStyle).pSymmetric(),

                        const SizedBox(
                          height: 8,
                        ),

                        CustomTextField(
                          controller: dosage,
                          hintText: "Enter dosage",
                          usePadding: false,
                          fillColor: AppColors.whiteSmoke,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          keyBoardType: TextInputType.number,
                          borderRadius: 0,
                          onChanged: (value) {
                            // if(value == null) return;
                            drug = drug.copyWith(quantity: value);
                          },
                        ).pSymmetric(),

                        //? DOSAGE FREQUENCY
                        Text("Dosage frequency", style: subtitleTextStyle).pOnly(left: 16, right: 16, top: 10, bottom: 8),

                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: List<Widget>.generate(SampleObjects.dosageFrequency.length, (index) {
                            final freq = SampleObjects.dosageFrequency.elementAt(index);

                            log("$index, $freq");

                            return SelectableContainer(
                              selected: drug.dosageFrequency == freq || (freq == "Other" && other),
                              onTap: () {
                                setState(() {
                                  if (freq == "Other") {
                                    drug = drug.copyWith(dosageFrequency: '');
                                    other = true;
                                  } else {
                                    drug = drug.copyWith(dosageFrequency: freq);
                                    other = false;
                                  }
                                });
                              },
                              title: Text(
                                freq,
                                style: const TextStyle(fontWeight: FontWeight.w500),
                              ),
                              selectedTitle: Text(
                                freq,
                                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                              ),
                            );
                          }),
                        ).pSymmetric(),

                        if (other)
                          CustomTextField(
                            controller: TextEditingController(text: drug.dosageFrequency?.toString() ?? ''),
                            hintText: "Other",
                            usePadding: false,
                            fillColor: AppColors.whiteSmoke,
                            // inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                            // keyBoardType: TextInputType.number,
                            borderRadius: 0,
                            onChanged: (value) {
                              // if(value == null) return;
                              drug = drug.copyWith(dosageFrequency: value);
                            },
                          ).pOnly(left: 16, right: 16, top: 8, bottom: 0),

                        //? DOSAGE TIME
                        Text("Dosage time", style: subtitleTextStyle).pOnly(left: 16, right: 16, top: 10, bottom: 8),

                        Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: List<Widget>.generate(SampleObjects.dosageTime.length, (index) {
                              final dosageTime = SampleObjects.dosageTime.elementAt(index);

                              return SelectableContainer(
                                selected: drug.dosageTime == dosageTime,
                                onTap: () {
                                  setState(() {
                                    drug = drug.copyWith(dosageTime: dosageTime);
                                  });
                                },
                                title: Text(
                                  dosageTime,
                                  style: const TextStyle(fontWeight: FontWeight.w500),
                                ),
                                selectedTitle: Text(
                                  dosageTime,
                                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                                ),
                              );
                            })).pSymmetric(),

                        //? DURATION
                        Text("Duration", style: subtitleTextStyle).pOnly(left: 16, right: 16, top: 10, bottom: 8),

                        CustomTextField(
                                controller: TextEditingController(
                                    text: drug.duration != null ? "For ${drug.duration!['value']} ${drug.duration!['unit']}" : ''),
                                usePadding: false,
                                readOnly: true,
                                onTap: () async {
                                  await showModalBottomSheet(
                                      context: context,
                                      builder: (context) {
                                        return Container(
                                            width: double.maxFinite,
                                            padding: const EdgeInsets.all(16),
                                            child: SingleChildScrollView(
                                              child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                                  children: List<Widget>.generate(AppConstants.drugDuration.keys.length, (index) {
                                                    final key = AppConstants.drugDuration.keys.elementAt(index);
                                                    final value = AppConstants.drugDuration[key];

                                                    return TextListTile(
                                                        text: key,
                                                        onTap: () async {
                                                          // context.pop();
                                                          if (value == null) {
                                                            final DateTime? pickedDate = await pickDate(context, returnDateObject: true);
                                                            if (pickedDate != null) {
                                                              DateTime today = DateTime.now();
                                                              int pickDateInDays =
                                                                  pickedDate.difference(DateTime(today.year, today.month, today.day)).inDays;
                                                              drug = drug.copyWith(duration: {"value": pickDateInDays, "unit": "Days"});
                                                              context.pop();
                                                            }
                                                          } else {
                                                            String val = key.split(' ')[1];
                                                            String unit = key.split(' ')[2];
                                                            if (val == 'a') {
                                                              val = '1';
                                                            }
                                                            drug = drug.copyWith(duration: {"value": int.parse(val), "unit": unit});
                                                            context.pop();
                                                          }
                                                        }).pOnly(bottom: 8);
                                                  })),
                                            ));
                                      });

                                  setState(() {});
                                },
                                borderRadius: 0,
                                suffixIcon: const Icon(Icons.arrow_drop_down_rounded),
                                onChanged: (value) {
                                  // drug = drug.copyWith(duration: value);
                                },
                                fillColor: AppColors.whiteSmoke,
                                hintText: "e.g For 5 days")
                            .pSymmetric(),

                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                  bottomNavigationBar: DualActionBottomNav(
                      text: "Back",
                      focusedText: "Save",
                      onPressed: () {
                        context.pop();
                        /* log("CLEAR THE CURRENT PATIENT (patient: $patientId) DRUG PRESCIPTION");
                        clearSavedDrugs(patientId);
                        context.pop();
                        searchController.clear();
                        forceStillTyping = false;
                        searchBarFocusNode.unfocus();*/
                      },
                      onFocusedPressed: () {
                        //log("SAVE THE CURRENT PATIENT (patient: $patientId) DRUG PRESCIPTION: $drug");
                        // saveDrug(patientId: patientId, drug: drug);
                        if (drug.name != "" &&
                            drug.quantity != null &&
                            drug.dosageFrequency != null &&
                            drug.dosageTime != null &&
                            drug.duration != null) {
                          if (selectedDrugs.contains(drug)) {
                            int index = selectedDrugs.indexOf(drug);
                            dev.log("contains drug");
                            selectedDrugs[index] = drug;
                          } else {
                            selectedDrugs.add(drug);
                          }
                          context.pop();
                          searchController.clear();
                          forceStillTyping = false;
                          searchBarFocusNode.unfocus();
                        } else {
                          showSnackMessage(context, 'You need to fill all the drug details');
                        }
                      }),
                ),
              ),
            );
          });
        });
  }
}

class TitledTextField extends StatelessWidget {
  const TitledTextField({super.key, required this.controller, required this.title, required this.hintText, this.maxLines, this.minLines});

  final TextEditingController controller;
  final String hintText;
  final String title;
  final int? maxLines;
  final int? minLines;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: GoogleFonts.urbanist(
              textStyle: const TextStyle(color: AppColors.eerieBlack, fontWeight: FontWeight.w700, fontSize: 14, height: 17.36 / 14)),
        ).pSymmetric(),
        const SizedBox(
          height: 4,
        ),
        CustomTextField(
            controller: controller,
            fillColor: AppColors.whiteSmoke,
            minLines: minLines,
            maxLines: maxLines,
            hintText: hintText,
            contentPadding: const EdgeInsets.all(16)),
      ],
    );
  }
}

class DrugType extends StatelessWidget {
  const DrugType({
    super.key,
    required this.drug,
  });

  final Drug drug;

  @override
  Widget build(BuildContext context) {
    return /*Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), border: Border.all(color: AppColors.blueViolet)),
      child: Text(drug.type?.capitalize ?? ''),
    );*/
        Container();
  }
}
