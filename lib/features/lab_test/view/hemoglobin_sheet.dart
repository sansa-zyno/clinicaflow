import 'package:flutter/material.dart';
import 'package:clinica_flow/core/constants/app_colors.dart';

class HemoglobinSheet extends StatefulWidget {
  const HemoglobinSheet({Key? key}) : super(key: key);

  @override
  State<HemoglobinSheet> createState() => _HemoglobinSheetState();
}

class _HemoglobinSheetState extends State<HemoglobinSheet> {
  bool isSelected = false;
  TextEditingController notesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      reverse: true,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.4 +
            MediaQuery.of(context).viewInsets.bottom,
        color: Colors.transparent,
        child: Stack(
          children: [
            Positioned(
                bottom: 0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.4 +
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
                            const Text(
                              'Hemoglobin',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                width: 70,
                                height: 35,
                                decoration: BoxDecoration(
                                  color: AppColors.greenColor,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: const Center(
                                  child: Text(
                                    'Done',
                                    style: TextStyle(
                                        color: AppColors.whiteColor,
                                        fontSize: 14),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isSelected = !isSelected;
                                  if (isSelected) {
                                    notesController.text =
                                        "Do the XYZ tests again after 20 days.";
                                  } else {
                                    notesController.clear();
                                  }
                                });
                              },
                              child: Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4.0),
                                  border: Border.all(
                                      color: const Color(0xFFA1A1A1)),
                                  // gradient: const LinearGradient(
                                  //   colors: [Color(0xFFF2F2F2), Color(0xFFE0E0E0)],
                                  //   stops: [0.0, 5.0],
                                  // ),
                                ),
                                child: isSelected
                                    ? const Icon(
                                        Icons.check,
                                        size: 18,
                                        color: Colors.black,
                                      )
                                    : null,
                              ),
                            ),
                            const SizedBox(
                              width: 6,
                            ),
                            const Text(
                              "Repeat",
                              style: TextStyle(
                                color: Color(0xFF868686),
                                fontSize: 13,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          "Notes",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 20),
                        ),
                        Container(
                          height: 150,
                          decoration: const BoxDecoration(
                            color: Color(0xFFF5F5F5),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              controller: notesController,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Write the remark here.',
                                hintStyle: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Roboto',
                                    color: Colors.grey),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
