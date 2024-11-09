/*import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healtether_clinic_app/Screens/AppointmentScreen/widgets/custom_textfield.dart';
import 'package:healtether_clinic_app/Screens/DigitalScreensAll/symptoms_diagnosis/create_digital_prescription_screens.dart';
import 'package:healtether_clinic_app/business_logic/cubits/drug_cubit/drug_prescription_cubit.dart';
import 'package:healtether_clinic_app/data_layer/models/drug_model/drug_model.dart';
import 'package:healtether_clinic_app/data_layer/sample_objects/sample_objects.dart';
import 'package:healtether_clinic_app/constants/app_colors.dart';
import 'package:healtether_clinic_app/utils/extensions.dart/string_extensions.dart';
import 'package:healtether_clinic_app/utils/extensions.dart/widget_extensions.dart';
import 'package:healtether_clinic_app/utils/helper_functions/log.dart';
import 'package:healtether_clinic_app/utils/mixins/device_info_mixin.dart';
import 'package:healtether_clinic_app/widgets/buttons/my_selectable_container.dart';
import 'package:healtether_clinic_app/widgets/components/dual_action_bottom_nav.dart';

class AddDrugsModalBottomSheet extends StatefulWidget {
  const AddDrugsModalBottomSheet({super.key, required this.drug, required this.patientId});
  final Drug drug;
  final String patientId;

  @override
  State<AddDrugsModalBottomSheet> createState() => _AddDrugsModalBottomSheetState();
}

class _AddDrugsModalBottomSheetState extends State<AddDrugsModalBottomSheet> with DeviceInfoMixin {
  late final TextEditingController drugName;
  late final FocusNode? focusNode;
  bool editDrugName = false;
  late Drug drug;

  @override
  void initState() {
    super.initState();
    drugName = TextEditingController(text: widget.drug.name);
    focusNode = FocusNode();
    drug = widget.drug;
  }

  TextStyle get subtitleTextStyle => GoogleFonts.urbanist(textStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14, height: 17.36 / 14));

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, setState) {
      return ClipRRect(
        borderRadius: const BorderRadius.only(topRight: Radius.circular(16), topLeft: Radius.circular(16)),
        child: SizedBox(
          height: screenDimensions(context).height * 3 / 4,
          child: Scaffold(
            backgroundColor: Colors.white,
            bottomNavigationBar: DualActionBottomNav(
                text: "Clear all",
                focusedText: "Save",
                onPressed: () {
                  log("CLEAR THE CURRENT PATIENT (patient: ${widget.patientId}) DRUG PRESCIPTION");
                  context.pop();
                },
                onFocusedPressed: () {
                  log("SAVE THE CURRENT PATIENT (patient: ${widget.patientId}) DRUG PRESCIPTION: $drug");
                  context.pop();
                }),
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
                                    focusNode?.requestFocus();
                                  } else {
                                    log("Save new drug name");

                                    drug = widget.drug.copyWith(name: drugName.text);
                                  }
                                });
                              },
                              backgroundColor: AppColors.grey3,
                              icon: Icon(editDrugName ? Icons.check : Icons.edit, color: AppColors.darkBlueViolet, size: 18),
                            )
                          ],
                        ),

                        const SizedBox(height: 4),

                        //? contents: content
                        RichText(
                            text: TextSpan(
                                text: "Contents: ",
                                style: GoogleFonts.urbanist(
                                    textStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 14, height: 17.36 / 14)),
                                children: [
                              TextSpan(
                                  text: widget.drug.contents,
                                  style: const TextStyle(
                                    color: AppColors.blueViolet,
                                  ))
                            ])),

                        //? drug type
                        if (widget.drug.type != null) const SizedBox(height: 10),

                        if (widget.drug.type != null)
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), border: Border.all(color: AppColors.blueViolet)),
                            child: Text(widget.drug.type!.capitalize),
                          )
                      ],
                    ),
                  ).pOnly(left: 16, right: 16, top: 16, bottom: 6),

                  //? QUANTITY / DOSAGE
                  Text("Quantity/Dosage", style: subtitleTextStyle).pSymmetric(),

                  const SizedBox(
                    height: 8,
                  ),

                  CustomTextField(
                    controller: TextEditingController(text: widget.drug.quantity?.toString() ?? ''),
                    hintText: "Enter dosage",
                    usePadding: false,
                    fillColor: AppColors.whiteSmoke,
                    borderRadius: 0,
                    onChanged: (value) {
                      // if(value == null) return;
                      setState(() {
                        drug = widget.drug.copyWith(quantity: int.parse(value));
                      });
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
                        selected: widget.drug.dosageFrequency == freq,
                        onTap: () {
                          setState(() {
                            drug = widget.drug.copyWith(dosageFrequency: freq);
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

                  //? DOSAGE TIME
                  Text("Dosage time", style: subtitleTextStyle).pOnly(left: 16, right: 16, top: 10, bottom: 8),

                  Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: List<Widget>.generate(SampleObjects.dosageTime.length, (index) {
                        final dosageTime = SampleObjects.dosageTime.elementAt(index);

                        return SelectableContainer(
                          selected: widget.drug.dosageTime == dosageTime,
                          onTap: () {
                            setState(() {
                              setState(() {
                                drug = widget.drug.copyWith(dosageTime: dosageTime);
                              });
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
                          controller: TextEditingController(text: widget.drug.duration),
                          usePadding: false,
                          borderRadius: 0,
                          suffixIcon: const Icon(Icons.arrow_drop_down_rounded),
                          onChanged: (value) {
                            drug = widget.drug.copyWith(duration: value);
                          },
                          fillColor: AppColors.whiteSmoke,
                          hintText: "e.g For 5 days")
                      .pSymmetric(),

                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      );
    });
    ;
  }
}*/
