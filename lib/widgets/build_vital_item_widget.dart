import 'dart:math' as Math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healtether_clinic_app/Screens/AppointmentScreen/widgets/custom_textfield.dart';
import 'package:healtether_clinic_app/constants/app_colors.dart';
import 'package:healtether_clinic_app/utils/helper_functions/log.dart';

class VitalItem extends StatefulWidget {
  const VitalItem(
      {super.key,
      required this.title,
      required this.unit,
      required this.hintText,
      required this.controller});
  final String title;
  final String unit;
  final String hintText;
  final TextEditingController controller;

  @override
  State<VitalItem> createState() => _VitalItemState();
}

class _VitalItemState extends State<VitalItem> {
  late final TextEditingController real = TextEditingController();
  late final TextEditingController fraction = TextEditingController();

  @override
  void initState() {
    super.initState();
    final values = widget.controller.text.split('/');

    print("controller.text: ${widget.controller.text}");

    real.text = values[0].trim();

    if (values.length > 1) {
      fraction.text = values[1].trim();
    }
  }

  @override
  Widget build(BuildContext context) {
    log(widget.title.toLowerCase().contains('blood pres'));
    return widget.title.toLowerCase().contains('blood pres')
        ? Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            //? title
            Text(widget.title,
                style: GoogleFonts.urbanist(
                  textStyle: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w600),
                )),

            const SizedBox(height: 10),

            Row(
              children: [
                Expanded(
                    flex: 2,
                    child: CustomTextField(
                        controller: real,
                        fillColor: AppColors.fillColor2,
                        onChanged: (value) {
                          final text = widget.controller.text;
                          List<String> values = text.split('/');
                          values[0] = value;

                          widget.controller.text = values.join('/');
                        },
                        hintText: "${100 + Math.Random().nextInt(50)}")),
                const Text("/"),
                Expanded(
                    flex: 2,
                    child: CustomTextField(
                        controller: fraction,
                        onChanged: (value) {
                          final text = widget.controller.text;
                          List<String> values = text.split('/');
                          values[1] = value;

                          widget.controller.text = values.join('/');
                        },
                        fillColor: AppColors.fillColor2,
                        hintText: "${100 + Math.Random().nextInt(50)}")),
                Expanded(
                  child: Text(
                    widget.unit,
                    textAlign: TextAlign.right,
                    style: GoogleFonts.urbanist(
                      textStyle: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF0C091F),
                        // fontFamily: 'Urbanist'
                      ),
                    ),
                  ),
                )
              ],
            )
          ])
        : Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  widget.title,
                  style: GoogleFonts.urbanist(
                    textStyle: const TextStyle(
                      // fontFamily: "Urbanist",
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                      color: Color(0xFF0C091F),
                    ),
                  ),
                ),
              ),
              // const SizedBox(width: 8),
              Expanded(
                  flex: 2,
                  child: CustomTextField(
                      controller: widget.controller,
                      fillColor: AppColors.fillColor2,
                      hintText: widget.hintText)),
              const SizedBox(width: 6),
              Expanded(
                flex: 1,
                child: Text(
                  widget.unit,
                  textAlign: TextAlign.right,
                  style: GoogleFonts.urbanist(
                    textStyle: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF0C091F),
                      // fontFamily: 'Urbanist'
                    ),
                  ),
                ),
              ),
            ],
          );
  }
}
