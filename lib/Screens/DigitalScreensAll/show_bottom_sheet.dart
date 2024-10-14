/*import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healtether_clinic_app/Screens/AppointmentScreen/widgets/custom_textfield.dart';
import 'package:healtether_clinic_app/Screens/DigitalScreensAll/drugs_card_screen.dart';
import 'package:healtether_clinic_app/constants/constants.dart';

class ShowBottomSheet extends StatefulWidget {
  final String drugName;
  final String drugSubtitle;

  const ShowBottomSheet({
    Key? key,
    required this.drugName,
    required this.drugSubtitle,
  }) : super(key: key);

  @override
  State<ShowBottomSheet> createState() => _ShowBottomSheetState();
}

class _ShowBottomSheetState extends State<ShowBottomSheet> {
  TextEditingController quantityController = TextEditingController();
  TextEditingController durationController = TextEditingController();
  TextEditingController drugNameController = TextEditingController();

  DateTime? selectedDate1;
  DateTime? selectedDate2;
  String? selectedOption;
  bool isQuantityFilled = false;
  bool isEditing = false;
  String? currentDrugName;

  @override
  void initState() {
    super.initState();
    quantityController.addListener(() {
      setState(() {
        isQuantityFilled = quantityController.text.isNotEmpty;
        currentDrugName = widget.drugName;
        drugNameController = TextEditingController(text: currentDrugName);
      });
    });
  }

  @override
  void dispose() {
    quantityController.dispose();
    durationController.dispose();
    drugNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isTextFieldFilled = durationController.text.isNotEmpty;
    return SingleChildScrollView(
      reverse: true,
      child: Container(
        height: MediaQuery.of(context).size.height / 1.130 +
            MediaQuery.of(context).viewInsets.bottom -
            20,
        color: Colors.transparent,
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 1.130 +
                    MediaQuery.of(context).viewInsets.bottom -
                    20,
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
                      const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: AppColors.white1Color,
                                  borderRadius: BorderRadius.circular(2),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              widget.drugName,
                                              style: GoogleFonts.urbanist(
                                                textStyle: const TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 17,
                                                  color: Color(0xFF202741),
                                                ),
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                isEditing = !isEditing;
                                              });
                                            },
                                            child: Container(
                                              height: 20,
                                              width: 25,
                                              decoration: const BoxDecoration(
                                                color: Color(0xffE8E8E8),
                                                shape: BoxShape.circle,
                                              ),
                                              child: Center(
                                                child: Icon(
                                                  Icons.edit,
                                                  //isEditing ? Icons.check : Icons.edit,
                                                  size: 14,
                                                  color:
                                                      const Color(0xff0B0B0B),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      // if (isEditing)
                                      //   const Divider(color: Colors.black,thickness: 1),
                                      // TextField(
                                      //   controller: drugNameController,
                                      //   style: GoogleFonts.urbanist(
                                      //     textStyle: const TextStyle(
                                      //       fontWeight: FontWeight.w600,
                                      //       fontSize: 17,
                                      //       color: Color(0xFF202741),
                                      //     ),
                                      //   ),
                                      //   decoration: InputDecoration(
                                      //     hintText: 'Enter drug name',
                                      //   ),
                                      //   onSubmitted: (value) {
                                      //     setState(() {
                                      //       currentDrugName = value;
                                      //       isEditing = false;
                                      //     });
                                      //   },
                                      // ),
                                      const SizedBox(height: 10),
                                      Row(
                                        children: [
                                          Text(
                                            'Contents: ',
                                            style: GoogleFonts.urbanist(
                                              textStyle: const TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 13,
                                                  color: Color(0xff0C091F)),
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              widget.drugSubtitle,
                                              maxLines: 2,
                                              style: GoogleFonts.urbanist(
                                                textStyle: const TextStyle(
                                                  color: Color(0xFF3351C7),
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 14),
                                      if (widget.drugName == 'Ambrowell 100ml')
                                        Row(
                                          children: [
                                            Container(
                                              width: 40,
                                              height: 20,
                                              decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xffF8F7FC),
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                  border: Border.all(
                                                      color: const Color(
                                                          0xFF1227E3))),
                                              child: const Center(
                                                child: Text(
                                                  'Syp',
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      if (widget.drugName == 'Meronem')
                                        Row(
                                          children: [
                                            Container(
                                              width: 40,
                                              height: 20,
                                              decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xffF8F7FC),
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                  border: Border.all(
                                                      color: const Color(
                                                          0xFF1227E3))),
                                              child: const Center(
                                                child: Text(
                                                  'Inj',
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      if (widget.drugName !=
                                              'Ambrowell 100ml' &&
                                          widget.drugName != 'Meronem')
                                        Row(
                                          children: [
                                            Container(
                                              width: 40,
                                              height: 20,
                                              decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xffF8F7FC),
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                  border: Border.all(
                                                      color: const Color(
                                                          0xFF1227E3))),
                                              child: const Center(
                                                child: Text(
                                                  'Tab',
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Row(
                              children: [
                                Text(
                                  AppText.quantity,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, right: 8),
                              child: CustomTextField(
                                controller: quantityController,
                                hintText: 'Quantity/Dosage',
                                height: 45,
                              ),
                            ),
                            const SizedBox(height: 9),
                            const Row(
                              children: [
                                Text('Dosage Frequency',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const DrugCard(name: "SOS"),
                                const DrugCard(name: "Stat"),
                                const DrugCard(
                                  name: "1-1-1",
                                ),
                                DrugCard(
                                    name: "1-0-1",
                                    isSelected: isQuantityFilled),
                                const DrugCard(name: "1-0-0"),
                              ],
                            ),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                DrugCard(name: "1-1-1"),
                                DrugCard(name: "0-0-1"),
                                DrugCard(name: "0-1-0"),
                                DrugCard(name: "1-0-0"),
                                DrugCard(name: "0-1-1"),
                              ],
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 14.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  DrugCard(name: "Other"),
                                ],
                              ),
                            ),
                            const SizedBox(height: 5),
                            const Row(
                              children: [
                                Text('Dosage Time',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                DrugCard(
                                    name: "After Meal",
                                    isSelected: isQuantityFilled),
                                const DrugCard(name: "Before Meal"),
                                const DrugCard(name: "Empty Stomach"),
                              ],
                            ),
                            const SizedBox(height: 5),
                            const Row(
                              children: [
                                Text(
                                  'Duration',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            GestureDetector(
                              onTap: () {
                                showBottomSheet(context);
                              },
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 45,
                                          decoration: BoxDecoration(
                                            color: AppColors.white1Color,
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 12.0),
                                                  child: CustomTextField(
                                                    controller:
                                                        durationController,
                                                    hintText: 'e.g. for 5 days',
                                                    height: 45,
                                                  ),
                                                ),
                                              ),
                                              const IconButton(
                                                icon: Icon(Icons
                                                    .keyboard_arrow_down_outlined),
                                                onPressed: null,
                                              ),
                                            ],
                                          ),
                                        ),
                                        if (durationController.text.isNotEmpty)
                                          const Padding(
                                            padding: EdgeInsets.only(
                                                left: 12.0, top: 8.0),
                                            child: Text(
                                              'e.g. from 01-03-24 to 05-03-24',
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 5),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                quantityController.clear();
                                durationController.clear();
                              },
                              child: Container(
                                width: 165,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: AppColors.white1Color,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Center(
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        isTextFieldFilled = !isTextFieldFilled;
                                      });
                                    },
                                    child: Text(
                                      isTextFieldFilled ? 'Clear All' : 'Back',
                                      style: const TextStyle(
                                        color: AppColors.blackColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                width: 165,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: isTextFieldFilled
                                      ? AppColors.greenColor
                                      : AppColors.white1Color,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Center(
                                  child: Text(
                                    AppText.save,
                                    style: TextStyle(
                                      color: isTextFieldFilled
                                          ? AppColors.whitColor
                                          : AppColors.greyColor,
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

  void showBottomSheet(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              height: MediaQuery.of(context).size.height / 1.9,
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: [
                        buildOptionContainer('Custom', setState, context),
                        buildOptionContainer('For 3 days', setState, context),
                        buildOptionContainer('For 5 days', setState, context),
                        buildOptionContainer('For a week', setState, context),
                        buildOptionContainer('For 2 weeks', setState, context),
                        buildOptionContainer('For a month', setState, context),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );

    if (selectedOption != null) {
      if (selectedOption == 'Custom') {
        durationController.text = selectedOption!;
        await showCustomDatePickerBottomSheet(context);
      } else {
        setState(() {
          durationController.text = selectedOption!;
        });
      }
    }
  }

  Widget buildOptionContainer(
      String option, StateSetter setState, BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedOption = option; // Update selectedOption on tap
          Navigator.pop(context); // Close the bottom sheet
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: const Color(0xffF7F7F7),
          borderRadius: BorderRadius.circular(5),
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.grey.withOpacity(0.3),
          //     spreadRadius: 1,
          //     blurRadius: 5,
          //     offset: const Offset(0, 2),
          //   ),
          // ],
        ),
        child: Text(
          option,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Future<void> showCustomDatePickerBottomSheet(BuildContext context) async {
    DateTime? startDate;
    DateTime? endDate;
    await showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height / 1.2,
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    const Text('Select the start and end date for medication',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: AppColors.greenColor)),
                    const SizedBox(height: 10),
                    Expanded(
                      child: Column(
                        children: [
                          CalendarDatePicker(
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101),
                            onDateChanged: (DateTime date) {
                              setState(() {
                                startDate = date;
                              });
                              Navigator.pop(context);
                            },
                          ),
                          const SizedBox(height: 20),
                          CalendarDatePicker(
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101),
                            onDateChanged: (DateTime date) {
                              setState(() {
                                endDate = date;
                                if (startDate != null && endDate != null) {
                                  durationController.text =
                                      '${startDate!.day}-${startDate!.month}-${startDate!.year} to ${endDate!.day}-${endDate!.month}-${endDate!.year}';
                                  Navigator.pop(context);
                                }
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}*/
