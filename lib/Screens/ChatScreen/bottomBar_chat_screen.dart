import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healtether_clinic_app/Screens/AppointmentScreen/appointment_screen.dart';
import 'package:healtether_clinic_app/constants/constants.dart';
import 'package:healtether_clinic_app/constants/app_text.dart';

class BottomBarChat extends StatefulWidget {
  const BottomBarChat({super.key});

  @override
  State<BottomBarChat> createState() => _BottomBarChatState();
}

class _BottomBarChatState extends State<BottomBarChat> {
  int _selectedIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.skyBlueColor,
        boxShadow: [
          BoxShadow(
            color: AppColors.grenColor.withOpacity(0.5),
            blurRadius: 25,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
            onTap: () => setState(() {
              _selectedIndex = 0;
            }),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(_selectedIndex == 0
                    ? 'assets/homeimages/icon_home.png'
                    : 'assets/homeimages/Group.png'),
                Text(
                  AppText.home,
                  style: GoogleFonts.montserrat(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: _selectedIndex == 0
                        ? AppColors.whiteColor
                        : AppColors.blackColor,
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                _selectedIndex = 1;
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return const AppointmentScreen();
                }));
              });
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(_selectedIndex == 1
                    ? 'assets/homeimages/Vector (9).png'
                    : 'assets/homeimages/Group (1).png'),
                Text(
                  AppText.appointments,
                  style: GoogleFonts.montserrat(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: _selectedIndex == 1
                        ? AppColors.whiteColor
                        : AppColors.blackColor,
                  ),
                )
              ],
            ),
          ),
          InkWell(
            onTap: () => setState(() {
              _selectedIndex = 2;
            }),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(_selectedIndex == 2
                    ? 'assets/homeimages/Vector (10).png'
                    : 'assets/homeimages/Vector (4).png'),
                Text(
                  AppText.chats,
                  style: GoogleFonts.montserrat(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: _selectedIndex == 2
                        ? AppColors.whiteColor
                        : AppColors.blackColor,
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () => setState(() {
              _selectedIndex = 3;
            }),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(_selectedIndex == 3
                    ? 'assets/homeimages/Vector (11).png'
                    : 'assets/homeimages/Vector (5).png'),
                Text(
                  AppText.notifications,
                  style: GoogleFonts.montserrat(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: _selectedIndex == 3
                        ? AppColors.whiteColor
                        : AppColors.blackColor,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
