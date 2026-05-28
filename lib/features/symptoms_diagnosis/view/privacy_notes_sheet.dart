import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:clinica_flow/features/symptoms_diagnosis/model/symptom.dart';
import 'package:clinica_flow/core/constants/app_colors.dart';
import 'package:clinica_flow/shared/widgets/containers/sx_dx_container.dart';
import '../../../core/constants/app_text.dart';

class PrivacyNotesSheet extends StatefulWidget {
  const PrivacyNotesSheet(
      {required this.symptom, Key? key, required this.onSave})
      : super(key: key);
  final Symptom symptom;
  final void Function(Symptom) onSave;

  @override
  State<PrivacyNotesSheet> createState() => _PrivacyNotesSheetState();
}

class _PrivacyNotesSheetState extends State<PrivacyNotesSheet> {
  //bool isFocused = false;
  final TextEditingController privateNotesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    privateNotesController.text = widget.symptom.privateNote ?? '';
  }

  @override
  void dispose() {
    privateNotesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      reverse: true,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.65 +
            MediaQuery.of(context).viewInsets.bottom,
        color: Colors.transparent,
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.65 +
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
                          SxDxContainer(text: widget.symptom.type),
                          const SizedBox(width: 5),
                          Expanded(
                            child: Text(
                              widget.symptom.name,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        AppText.privateNotes,
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 20),
                      ),
                      const Divider(color: AppColors.blackColor),
                      const SizedBox(height: 4),
                      Container(
                        height: 325,
                        decoration: const BoxDecoration(
                          color: Color(0xFFEDFFFA),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: privateNotesController,
                            minLines: 5,
                            maxLines: 10,
                            maxLength: 350,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Add your notes here.',
                              hintStyle: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Urbanist',
                                  color: Colors.grey),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Row(
                          children: [
                            Container(
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
                                  final newSymptom = widget.symptom.clear();
                                  widget.onSave(newSymptom);
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
                            const Spacer(),
                            Container(
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
                                onPressed: () {
                                  final newSymptom = widget.symptom.copyWith(
                                      // timePeriod: int.parse(timePeriod),
                                      // timeUnit: duration,
                                      privateNote:
                                          privateNotesController.text.trim());

                                  context.pop();

                                  widget.onSave(newSymptom);
                                },
                                child: const Text(
                                  AppText.save,
                                  style: TextStyle(
                                    color: AppColors.whiteColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
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
}
