import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healtether_clinic_app/Screens/Models/logout_button.dart';
import 'package:healtether_clinic_app/data_layer/services/shared_preferences_service.dart';

class LogoutPopup extends StatefulWidget {
  const LogoutPopup({super.key});

  @override
  LogoutPopupState createState() => LogoutPopupState();
}

class LogoutPopupState extends State<LogoutPopup> {
  bool _isYesButtonClicked = false;
  bool _isNoButtonClicked = false;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(7),
      ),
      child: Container(
        width: 380,
        height: 160,
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Text(
              'Do you want to Logout?',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                height: 19.2 / 16,
                letterSpacing: 0.16,
                color: const Color(0xFF000000),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 130,
                  height: 60,
                  child: LogoutDialogButton(
                    text: 'No',
                    onPressed: () {
                      setState(() {
                        _isYesButtonClicked = true;
                        _isNoButtonClicked = false;
                      });
                      Navigator.of(context).pop(false);
                    },
                    isSelected: _isNoButtonClicked,
                  ),
                ),
                const SizedBox(width: 4),
                Container(
                  width: 130,
                  height: 60,

                  child: LogoutDialogButton(
                    text: 'Yes',
                    onPressed: () {
                      _handleLogout(context);
                      setState(() {
                        _isYesButtonClicked = false;
                        _isNoButtonClicked = true;
                      });
                      Navigator.of(context).pop(true);
                    },
                    isSelected: _isYesButtonClicked,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void _handleLogout(BuildContext context) async {
  await SharedPrefService.deleteAccessToken();
}
