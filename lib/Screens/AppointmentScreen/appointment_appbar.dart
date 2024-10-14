import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healtether_clinic_app/Screens/AppointmentScreen/appointment_later.dart';
import 'package:healtether_clinic_app/Screens/AppointmentScreen/appointment_screen.dart';
import 'package:healtether_clinic_app/Screens/AppointmentScreen/done_appointment.dart';
import 'package:healtether_clinic_app/constants/app_text.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class AppointAppbar extends StatefulWidget {
  const AppointAppbar({
    Key? key,
  }) : super(key: key);

  @override
  State<AppointAppbar> createState() => _AppointAppbarState();
}

class _AppointAppbarState extends State<AppointAppbar> {
  final PageController pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppText.addAppointment,
          style: GoogleFonts.montserrat(fontWeight: FontWeight.w500),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SmoothPageIndicator(
                    controller: pageController,
                    count: 3,
                    effect: const ExpandingDotsEffect(
                        expansionFactor: 5,
                        dotColor: Color(0XFF5351C7),
                        strokeWidth: 3,
                        dotHeight: 8,
                        dotWidth: 8,
                        paintStyle: PaintingStyle.fill),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height *
                        0.7, // Adjust the height as needed
                    child: PageView(
                      controller: pageController,
                      scrollDirection: Axis.horizontal,
                      children: [
                        const AppointmentScreen(),
                        AppointLater(
                          pageController: pageController,
                        ),
                        DoneAppoint(),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
