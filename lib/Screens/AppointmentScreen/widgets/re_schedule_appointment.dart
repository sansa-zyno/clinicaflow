import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healtether_clinic_app/widgets/green_line_widget.dart';
import 'package:healtether_clinic_app/constants/constants.dart';

class ReScheduleAppointment extends StatefulWidget {
  const ReScheduleAppointment({super.key});

  @override
  State<ReScheduleAppointment> createState() =>
      _ScheduleNewAppointmentScreenState();
}

class _ScheduleNewAppointmentScreenState extends State<ReScheduleAppointment> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Container(
      color: AppColors.whiteColor,
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'RE-SCHEDULE FOLLOW-UP',
                      style: GoogleFonts.urbanist(
                        textStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff0C091F)),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: const GreenLine(),
                    ),
                  ],
                ),
                Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.blackColor),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const Icon(
                      Icons.close_rounded,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: height * 0.02),
            Text(
              'Set up a date ',
              style: GoogleFonts.roboto(
                textStyle: const TextStyle(
                  // fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  height: 19.2 / 16,
                  letterSpacing: 0.16,
                  color: Color(0xFF0C091F),
                ),
              ),
            ),
            SizedBox(height: height * 0.01),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: const Color(0xff198E79),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Center(
                      child: Text('None',
                          style: GoogleFonts.urbanist(
                            textStyle: const TextStyle(
                                color: AppColors.whiteColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 16),
                          )),
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: const Color(0xffF7F7F7),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Center(
                      child: Text('After 3 days',
                          style: GoogleFonts.urbanist(
                            textStyle: const TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 16),
                          )),
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: const Color(0xffF7F7F7),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Center(
                      child: Text('After a week',
                          style: GoogleFonts.urbanist(
                            textStyle: const TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 16),
                          )),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: height * 0.01),
            InkWell(
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2100),
                );
                if (pickedDate != null) {
                  // Handle the selected date
                  if (kDebugMode) {
                    print(pickedDate.toString());
                  }
                }
              },
              child: Container(
                height: 40,
                width: width * 0.3,
                decoration: BoxDecoration(
                  color: const Color(0xffF7F7F7),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Center(
                  child: Text('Custom',
                      style: GoogleFonts.urbanist(
                        textStyle: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 16),
                      )),
                ),
              ),
            ),
            SizedBox(height: height * 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Time',
                  style: GoogleFonts.roboto(
                    textStyle: const TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                ),
                Container(
                  width: 160,
                  height: 52,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8F7FC),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: DropdownButton<String>(
                    isExpanded: true,
                    underline: const SizedBox(),
                    icon: const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: Color(0xFF000000),
                      size: 28,
                    ),
                    hint: Text(
                      'Select',
                      style: TextStyle(color: Color(0xffACACAC)),
                    ),
                    items: <String>['Option 1', 'Option 2', 'Option 3']
                        .map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {},
                  ),
                ),
              ],
            ),
            SizedBox(height: height * 0.03),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        color: const Color(0xff198E79),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Center(
                        child: Text('Done',
                            style: GoogleFonts.urbanist(
                              textStyle: const TextStyle(
                                  color: AppColors.whiteColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16),
                            )),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                          color: const Color(0xffF7F7F7),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Center(
                          child: Text('Exit',
                              style: GoogleFonts.urbanist(
                                textStyle: const TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 16),
                              )),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              child: Row(
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(6),
                      color: const Color(0xFFFFFFFF),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 30),
                        Text(
                          'Notify patient on Whatsapp',
                          style: GoogleFonts.roboto(
                            textStyle: const TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              height: 19.2 / 16,
                              letterSpacing: 0.16,
                              color: Color(0xFF868686),
                            ),
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          'This will automatically send a reminder to patient’s Whatsapp 20 hours ago to visit again.',
                          style: GoogleFonts.roboto(
                            textStyle: const TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              fontSize: 11,
                              height: 13.2 / 11,
                              color: Color(0xFF868686),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
