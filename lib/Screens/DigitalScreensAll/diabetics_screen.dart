import 'package:flutter/material.dart';

import 'package:healtether_clinic_app/data_layer/models/past_history/past_history.dart';
import 'package:go_router/go_router.dart';

import 'package:healtether_clinic_app/utils/extensions.dart/string_extensions.dart';

// import 'package:healtether_clinic_app/Screens/DigitalScreensAll/family_history_screen.dart';

class DiabeticsScreen extends StatefulWidget {
  const DiabeticsScreen({super.key, required this.pastHistory});
  final PastHistory pastHistory;

  @override
  State<DiabeticsScreen> createState() => _DiabeticsScreenState();
}

class _DiabeticsScreenState extends State<DiabeticsScreen> {
  List<String> options = [
    'less than 6 months ago',
    '6 months ago',
    'a year ago',
    '2 years ago',
    '5 years ago',
    '10 years ago',
  ];

  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, setState) {
      return AlertDialog(
        title: RichText(
          text: TextSpan(
            text: widget.pastHistory.disease.capitalize,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black,
            ),
            children: const <TextSpan>[
              TextSpan(
                text: ' diagnosed in the year',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        final DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: selectedDate is DateTime ? selectedDate as DateTime : DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                          initialDatePickerMode: DatePickerMode.year,
                        );
                        if (pickedDate != null) {
                          setState(() {
                            selectedDate = pickedDate;
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: const Color(0xFFF5F5F5),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      child: Text(
                        selectedDate != null ? (selectedDate as DateTime).year.toString() : 'Select Year',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (selectedDate == null) return;

                      //* UPDATING HISTORY
                      final updatedHistory = widget.pastHistory.copyWith(duration: double.parse(selectedDate!.millisecondsSinceEpoch.toString()));

                      context.pop(updatedHistory);
                    },
                    child: Container(
                      width: 80,
                      height: 40,
                      decoration: BoxDecoration(
                        color: const Color(0xFF32856E),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Center(
                        child: Text(
                          "Save",
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: options.map((option) {
                return GestureDetector(
                  onTap: () {
                    if (option.contains('6')) {
                      selectedDate = DateTime.now().add(const Duration(days: -30 * 6));
                    } else if (option.contains('2')) {
                      selectedDate = DateTime.now().add(const Duration(days: -365 * 2));
                    } else if (option.contains('5')) {
                      selectedDate = DateTime.now().add(const Duration(days: -365 * 5));
                    } else if (option.contains('10')) {
                      selectedDate = DateTime.now().add(const Duration(days: -365 * 10));
                    } else if (option.contains('a year ago')) {
                      selectedDate = DateTime.now().add(const Duration(days: -365));
                    }
                    setState(() {});
                  },
                  child: Chip(
                    label: Text(
                      option,
                      style: const TextStyle(fontSize: 12),
                    ),
                    backgroundColor: const Color(0xFFF5F5F5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    side: BorderSide.none,
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      );
    });
  }
}
