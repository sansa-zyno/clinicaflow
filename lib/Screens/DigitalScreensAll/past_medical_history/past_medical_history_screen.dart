import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:healtether_clinic_app/Screens/AppointmentScreen/widgets/custom_textfield.dart';
import 'package:healtether_clinic_app/Screens/DigitalScreensAll/symptoms_diagnosis/create_digital_prescription_screens.dart';
import 'package:healtether_clinic_app/business_logic/cubits/allergy_cubit/allergy_cubit.dart';
import 'package:healtether_clinic_app/business_logic/cubits/appointment_cubit/appointment_cubit.dart';
import 'package:healtether_clinic_app/business_logic/cubits/drug_cubit/drug_prescription_cubit.dart';
import 'package:healtether_clinic_app/business_logic/cubits/past_medical_history_cubit/past_medical_history_cubit.dart';
import 'package:healtether_clinic_app/business_logic/cubits/prescription/prescription_report_cubit.dart';
import 'package:healtether_clinic_app/business_logic/cubits/vitals_cubit/vitals_cubit.dart';
import 'package:healtether_clinic_app/data_layer/models/allergies/allergies.dart';
import 'package:healtether_clinic_app/data_layer/models/appointment_models/appointment_model.dart';
import 'package:healtether_clinic_app/data_layer/models/drug_model/drug_model.dart';
// import 'package:healtether_clinic_app/business_logic/cubits/home_page_bottom_nav_cubit/home_page_bottom_nav_cubit.dart';
import 'package:healtether_clinic_app/data_layer/models/history_item/history_item.dart';
import 'package:healtether_clinic_app/constants/constants.dart';
import 'package:healtether_clinic_app/constants/typography.dart';
import 'package:healtether_clinic_app/utils/enums/bloc_enums.dart';
import 'package:healtether_clinic_app/utils/enums/route_enums.dart';
import 'package:healtether_clinic_app/data_layer/models/user_model/user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healtether_clinic_app/utils/extensions.dart/widget_extensions.dart';
import 'package:healtether_clinic_app/utils/helper_functions/log.dart';
import 'package:healtether_clinic_app/utils/mixins/app_bar_mixin.dart';
import 'package:healtether_clinic_app/utils/mixins/ui_info_mixin.dart';
import 'package:healtether_clinic_app/widgets/components/dual_action_bottom_nav.dart';
import 'package:healtether_clinic_app/widgets/section_text.dart';
import 'package:healtether_clinic_app/widgets/text_list_tile.dart';
import 'dart:developer' as dev;

class PastMedicalHistoryScreen extends StatefulWidget {
  final Appointment appointment;
  final List<HistoryItem>? pastHistory;
  final List<HistoryItem>? familyHistory;
  final List<HistoryItem>? pastProcedureHistory;
  final List<HistoryItem>? allergies;
  final List<HistoryItem>? medication;
  const PastMedicalHistoryScreen(
      {Key? key, required this.appointment, this.pastHistory, this.familyHistory, this.pastProcedureHistory, this.allergies, this.medication})
      : super(key: key);

  @override
  State<PastMedicalHistoryScreen> createState() => _PastMedicalHistoryScreenState();
}

class _PastMedicalHistoryScreenState extends State<PastMedicalHistoryScreen> with AppBarMixin, UiInfoMixin {
  late final UserModel? user;
  bool hasNavigated = false;
  bool addSpace = false;
  late List<HistoryItem> pastHistory;
  late List<HistoryItem> familyHistory;
  late List<HistoryItem> pastProcedures;
  late List<HistoryItem> allergies;
  late List<HistoryItem> medicationHistory;
  late final TextEditingController searchController;
  late final ScrollController scrollController;
  late final FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    if (widget.pastHistory != null && widget.pastHistory!.isNotEmpty) {
      pastHistory = List.generate(widget.pastHistory!.length, (index) => widget.pastHistory![index]);
    } else {
      pastHistory = List.filled(2, HistoryItem.empty(), growable: true); // initial two items according to the figma UI
    }
    if (widget.familyHistory != null && widget.familyHistory!.isNotEmpty) {
      familyHistory = List.generate(widget.familyHistory!.length, (index) => widget.familyHistory![index]);
    } else {
      familyHistory = List.filled(2, HistoryItem.empty(), growable: true); // initial two items according to the figma UI
    }
    if (widget.pastProcedureHistory != null && widget.pastProcedureHistory!.isNotEmpty) {
      pastProcedures = List.generate(widget.pastProcedureHistory!.length, (index) => widget.pastProcedureHistory![index]);
    } else {
      pastProcedures = List.filled(2, HistoryItem.empty(), growable: true); // initial two items according to the figma UI
    }
    if (widget.allergies != null && widget.allergies!.isNotEmpty) {
      allergies = List.generate(widget.allergies!.length, (index) => widget.allergies![index]);
    } else {
      allergies = List.filled(2, HistoryItem.empty(), growable: true); // initial two items according to the figma UI
    }
    if (widget.medication != null && widget.medication!.isNotEmpty) {
      medicationHistory = List.generate(widget.medication!.length, (index) => widget.medication![index]);
    } else {
      medicationHistory = List.filled(2, HistoryItem.empty(), growable: true); // initial two items according to the figma UI
    }

    focusNode = FocusNode();
    searchController = TextEditingController();
    scrollController = ScrollController();
  }

  bool get isTyping => focusNode.hasFocus;

  void clear() {
    setState(() {
      pastHistory = List.filled(2, HistoryItem.empty(), growable: true); // initial two items according to the figma UI
      familyHistory = List.filled(2, HistoryItem.empty(), growable: true); // initial two items according to the figma UI
      pastProcedures = List.filled(2, HistoryItem.empty(), growable: true); // initial two items according to the figma UI
      allergies = List.filled(2, HistoryItem.empty(), growable: true); // initial two items according to the figma UI
      medicationHistory = List.filled(2, HistoryItem.empty(), growable: true); // initial two items according to the figma UI
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, title: "Digital Prescription", backgroundColor: AppColors.whitColor),
      body: BlocListener<PastMedicalHistoryCubit, PastMedicalHistoryState>(
          listener: (context, state) {
            if (state.state == PastMedicalHistoryStates.pastMedicalHistoryPosted && !hasNavigated) {
              dev.log(state.state.toString());
              hasNavigated = true;
              showSnackMessage(context, 'Past Medical History saved successfully.');
              context.read<PastMedicalHistoryCubit>().getPastMedicalHistory(patientId: widget.appointment.patientId!);
              context.read<PrescriptionReportCubit>().getPrescriptionReport(appointmentId: widget.appointment.id!);
              //to update home screen
              context.read<AppointmentCubit>().getAppointmentById(id: widget.appointment.id!);
              context.pushReplacementNamed(AppRoutes.vitals.name, extra: {
                'appointment': widget.appointment,
                'vitals': context.read<VitalsCubit>().state.savedVital,
              });
            }
            /*if (state.state == PastMedicalHistoryStates.pastMedicalHistoryFetched) {
            if (state.pastHistory != null && state.pastHistory!.isNotEmpty) {
              pastHistory = List.generate(state.pastHistory!.length, (index) => state.pastHistory![index]);
            } else {
              pastHistory = List.filled(2, HistoryItem.empty(), growable: true); // initial two items according to the figma UI
            }
            if (state.familyHistory != null && state.familyHistory!.isNotEmpty) {
              familyHistory = List.generate(state.familyHistory!.length, (index) => state.familyHistory![index]);
            } else {
              familyHistory = List.filled(2, HistoryItem.empty(), growable: true); // initial two items according to the figma UI
            }
            if (state.pastProcedures != null && state.pastProcedures!.isNotEmpty) {
              pastProcedures = List.generate(state.pastProcedures!.length, (index) => state.pastProcedures![index]);
            } else {
              pastProcedures = List.filled(2, HistoryItem.empty(), growable: true); // initial two items according to the figma UI
            }
            if (state.allergies != null && state.allergies!.isNotEmpty) {
              allergies = List.generate(state.allergies!.length, (index) => state.allergies![index]);
            } else {
              allergies = List.filled(2, HistoryItem.empty(), growable: true); // initial two items according to the figma UI
            }
            if (state.medicationHistory != null && state.medicationHistory!.isNotEmpty) {
              medicationHistory = List.generate(state.medicationHistory!.length, (index) => state.medicationHistory![index]);
            } else {
              medicationHistory = List.filled(2, HistoryItem.empty(), growable: true); // initial two items according to the figma UI
            }
          }*/
          },
          child: CustomScrollView(
            controller: scrollController,
            slivers: [
              //? SECTION TEXT | Medical condition investigation
              SliverToBoxAdapter(
                child: const SectionText(
                  "MEDICAL CONDITION INVESTIGATION",
                  textStyle: TextStyle(fontSize: 18, height: 24 / 20),
                  underlineWidth: 358,
                  underlineColor: AppColors.eerieBlack,
                ).pOnly(left: 16, right: 16, top: 10, bottom: 12),
              ),
              const SliverToBoxAdapter(child: SizedBox.shrink()),
              SliverToBoxAdapter(child: buildNotTypingView()),
            ],
          )),
      bottomNavigationBar: BlocBuilder<PastMedicalHistoryCubit, PastMedicalHistoryState>(builder: (context, state) {
        if (state.state == PastMedicalHistoryStates.postingPastMedicalHistory) {
          return const SizedBox(height: 100, child: Center(child: CircularProgressIndicator()));
        } else {
          return DualActionBottomNav(
            text: "Clear All",
            focusedText: 'Add Vitals',
            onPressed: clear,
            onFocusedPressed: () {
              hasNavigated = false;
              context.read<PastMedicalHistoryCubit>().postPastMedicalHistory(
                  patientId: widget.appointment.patientId!,
                  medication: medicationHistory.map((e) => e.toMap()).toList(),
                  allergies: allergies.map((e) => e.toMap()).toList(),
                  familyHistory: familyHistory.map((e) => e.toMap()).toList(),
                  pastHistory: pastHistory.map((e) => e.toMap()).toList(),
                  pastProcedureHistory: pastProcedures.map((e) => e.toMap()).toList());
            },
          );
        }
      }),
    );
  }

  Widget buildNotTypingView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //? PAST HISTORY
        HistoryItemWidget(
            title: "Past history",
            subtitle2: 'Since',
            onAdd: () => setState(() {
                  pastHistory.add(HistoryItem.empty());
                }),
            items: pastHistory,
            onRemove: (item) => setState(() {
                  pastHistory.remove(item);
                })).pOnly(bottom: 42),

        //? FAMILY HISTORY
        HistoryItemWidget(
            title: "Family history",
            subtitle2: 'Since',
            onAdd: () => setState(() {
                  familyHistory.add(HistoryItem.empty());
                }),
            items: familyHistory,
            onRemove: (item) => setState(() {
                  familyHistory.remove(item);
                })).pOnly(bottom: 42),

        //? PAST MEDICAL PROCEDURES
        HistoryItemWidget(
            title: "Past medical procedures",
            subtitle1: "Procedures",
            subtitle2: "Done in",
            hintText1: "Procedure name",
            onAdd: () => setState(() {
                  pastProcedures.add(HistoryItem.empty());
                }),
            items: pastProcedures,
            onRemove: (item) => setState(() {
                  pastProcedures.remove(item);
                })).pOnly(bottom: 42),

        //? ALLERGIES
        HistoryItemWidget(
            title: "Allergies",
            subtitle1: "Allergies",
            subtitle2: "Since",
            hintText1: "Ex. Pollen",
            onAdd: () => setState(() {
                  allergies.add(HistoryItem.empty());
                }),
            items: allergies,
            onRemove: (item) => setState(() {
                  allergies.remove(item);
                })).pOnly(bottom: 42),

        //? MEDICATION HISTORY
        HistoryItemWidget(
          title: "Medication History",
          subtitle1: "Drugs",
          subtitle2: "Since",
          hintText1: "Drug name",
          onAdd: () => setState(() {
            medicationHistory.add(HistoryItem.empty());
          }),
          items: medicationHistory,
          onRemove: (item) => setState(() {
            medicationHistory.remove(item);
          }),
        ).pOnly(bottom: 42),

        //HistoryWidget getting rebuilt on setSate so we cant call setState to add more space for _showOverlay
        const SizedBox(height: 250)
      ],
    );
  }
}

class SelectedItemContainer extends StatelessWidget {
  const SelectedItemContainer({
    super.key,
    required this.title,
    required this.onClose,
  });
  final String title;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(color: AppColors.lightAqua2, borderRadius: BorderRadius.circular(7)),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Text(title),
          const SizedBox(width: 10),
          MyIconContainer(
              backgroundColor: AppColors.whiteSmoke,
              onTap: onClose,
              size: 20,
              icon: const Icon(Icons.close, color: AppColors.darkBlueViolet, size: 14))
        ]));
  }
}

class SectionRow extends StatelessWidget {
  const SectionRow({
    super.key,
    required this.title,
    required this.onAdd,
  });

  final String title;
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // title
        Expanded(
          child: Text(
            title,
            style: AppTypography.H7_SB,
          ),
        ),

        // add
        GestureDetector(
          onTap: onAdd,
          child: SectionText(
            "Add",
            textAlign: TextAlign.center,
            textStyle: AppTypography.CTA_1_SB.copyWith(color: AppColors.darkTeal),
            underlineWidth: 40,
            underlineColor: AppColors.darkTeal,
          ),
        )
      ],
    );
  }
}

class HistoryItemWidget extends StatefulWidget {
  const HistoryItemWidget({
    super.key,
    required this.title,
    required this.onAdd,
    required this.items,
    required this.onRemove,
    this.subtitle1 = 'Diseases',
    this.subtitle2 = 'Diagnosed in',
    this.hintText1 = 'Disease name',
    this.hintText2 = 'Year',
  });

  final String title;
  final VoidCallback onAdd;
  final void Function(HistoryItem item) onRemove;
  final String subtitle1;
  final String subtitle2;
  final String hintText1;
  final String hintText2;
  final List<HistoryItem> items;

  @override
  State<HistoryItemWidget> createState() => _HistoryItemWidgetState();
}

class _HistoryItemWidgetState extends State<HistoryItemWidget> {
  OverlayEntry? _overlayEntry;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //* row with title and add button
        SectionRow(title: widget.title, onAdd: widget.onAdd).pSymmetric(),

        const SizedBox(
          height: 12,
        ),

        //?subtitle 1 and subtitle 2
        Table(
          columnWidths: const {1: FixedColumnWidth(100)},
          children: [
            TableRow(children: [
              //? Table headers
              Text(
                widget.subtitle1,
                style: AppTypography.CTA_4_B.copyWith(color: AppColors.grey4),
              ).pOnly(bottom: 6),
              Text(
                widget.subtitle2,
                style: AppTypography.CTA_4_B.copyWith(color: AppColors.grey4),
              ).pOnly(bottom: 6)
            ]),

            //? History Items
            ...List<TableRow>.generate(widget.items.length, (index) {
              HistoryItem item = widget.items.elementAt(index);
              LayerLink layerLink = LayerLink();
              TextEditingController controller = TextEditingController(text: item.name);

              return TableRow(children: [
                CompositedTransformTarget(
                  link: layerLink,
                  child: CustomTextField(
                    usePadding: false,
                    borderRadius: 0,
                    height: 52,
                    hintText: widget.hintText1,
                    controller: controller,
                    onTap: () {
                      if (_overlayEntry != null) {
                        _removeOverlay();
                      }
                    },
                    onChanged: (value) {
                      item = item.copyWith(name: value);
                      widget.items[index] = item;
                      if (_overlayEntry != null) {
                        _removeOverlay();
                        if (widget.title == 'Allergies') {
                          context.read<AllergyCubit>().search(value);
                          _showOverlay(context, buildAllergySearchResults(controller, item, index), layerLink);
                        } else if (widget.title == 'Medication History') {
                          context.read<DrugPrescriptionCubit>().searchDrugs(value);
                          _showOverlay(context, buildMedicationsSearchResults(controller, item, index), layerLink);
                        }
                      } else {
                        if (widget.title == 'Allergies') {
                          context.read<AllergyCubit>().search(value);
                          _showOverlay(context, buildAllergySearchResults(controller, item, index), layerLink);
                        } else if (widget.title == 'Medication History') {
                          context.read<DrugPrescriptionCubit>().searchDrugs(value);
                          _showOverlay(context, buildMedicationsSearchResults(controller, item, index), layerLink);
                        }
                      }
                    },
                  ).pOnly(right: 12, bottom: 8),
                ),
                Row(
                  children: [
                    Expanded(
                        child: CustomTextField(
                            usePadding: false,
                            borderRadius: 0,
                            height: 52,
                            keyBoardType: TextInputType.number,
                            inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(4)],
                            controller: TextEditingController(text: item.year),
                            onChanged: (value) {
                              if (value.length == 4) {
                                int noOfYears = DateTime.now().year - int.parse(value);
                                item = item.copyWith(year: noOfYears.toString());
                              } else {
                                item = item.copyWith(year: "");
                              }
                              widget.items[index] = item;
                            },
                            hintText: widget.hintText2)),
                    const SizedBox(
                      width: 12,
                    ),
                    MyIconContainer(
                      icon: const Icon(Icons.close, size: 18),
                      backgroundColor: AppColors.accentColor2,
                      onTap: () {
                        log("Close");

                        widget.onRemove(item);
                      },
                    ),
                  ],
                ).pOnly(bottom: 8)
              ]);
            }),
          ],
        ).pSymmetric()
      ],
    );
  }

  void _showOverlay(BuildContext context, Widget widget, LayerLink layerLink) {
    _overlayEntry = _createOverlayEntry(widget, layerLink);
    Overlay.of(context)?.insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  OverlayEntry _createOverlayEntry(Widget widget, LayerLink layerLink) {
    return OverlayEntry(
      builder: (context) => Positioned(
        width: 360,
        child: CompositedTransformFollower(
          link: layerLink,
          showWhenUnlinked: false,
          offset: Offset(0.0, 60.0),
          child: Material(elevation: 1.0, child: Container(height: 325, child: SingleChildScrollView(child: widget))),
        ),
      ),
    );
  }

  Widget buildAllergySearchResults(TextEditingController controller, HistoryItem item, int itemIndex) {
    return BlocBuilder<AllergyCubit, AllergyState>(builder: (context, state) {
      if (state.state == AllergyStates.searchingForAllergies) {
        return Container();
      } else if (state.state == AllergyStates.searchingForAllergiesFailed) {
        return Container();
      } else {
        return Column(
            children: List<Widget>.generate(state.allergies?.length ?? 0, (index) {
          Allergy allergy = state.allergies!.elementAt(index);

          return TextListTile(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
            text: allergy.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            /*leading: Checkbox(
                value: selectedTests.contains(test),
                onChanged: (value) {
                  if (value == false) {
                    selectedTests.remove(test);
                  } else {
                    selectTest(test);
                  }
                }),*/
            onTap: () {
              controller.text = allergy.name;
              item = item.copyWith(name: allergy.name);
              widget.items[itemIndex] = item;
              _removeOverlay();
              /*if (selectedTests.contains(test) == true) {
                selectedTests.remove(test);
              } else {
                selectTest(test);
              }*/
            },
          ).pOnly(bottom: 8);
        }));
      }
    });
  }

  Widget buildMedicationsSearchResults(TextEditingController controller, HistoryItem item, int itemIndex) {
    return BlocBuilder<DrugPrescriptionCubit, DrugPrescriptionState>(builder: (context, state) {
      if (state.state == DrugPrescriptionStates.searchingForDrugs) {
        return Container();
      } else if (state.state == DrugPrescriptionStates.searchingForDrugsFailed) {
        return Container();
      } else {
        return Column(
            children: List<Widget>.generate(state.drugs?.length ?? 0, (index) {
          Drug drug = state.drugs!.elementAt(index);

          return TextListTile(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
            text: drug.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            /*leading: Checkbox(
                value: selectedTests.contains(test),
                onChanged: (value) {
                  if (value == false) {
                    selectedTests.remove(test);
                  } else {
                    selectTest(test);
                  }
                }),*/
            onTap: () {
              controller.text = drug.name;
              item = item.copyWith(name: drug.name);
              widget.items[itemIndex] = item;
              _removeOverlay();
            },
          ).pOnly(bottom: 8);
        }));
      }
    });
  }
}
