import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CancelApoointBox extends StatefulWidget {
  @override
  _CancelApoointBoxState createState() => _CancelApoointBoxState();
}

class _CancelApoointBoxState extends State<CancelApoointBox> {
  DateTime? _selectedDate;
  String selectedDate = '';
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Text('Cancel Appointment'),
      onTap: () {
        cancelAppointBox(context);
      },
    );
  }

  void cancelAppointBox(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: SizedBox(
            width: 600,
            child: Text(
              'Do you want to Cancel the scheduled appointment ?',
              style: GoogleFonts.montserrat(
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          content: SizedBox(
            width: 700,
            height: 160,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 52,
                        width: 102,
                        decoration: BoxDecoration(
                          color: Color(0xff03BF9C),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Center(
                          child: Text(
                            'Yes',
                            style: GoogleFonts.montserrat(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 52,
                        width: 102,
                        decoration: BoxDecoration(
                          color: Color(0xffF5F5F5),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Center(
                          child: Text(
                            'Exit',
                            style: GoogleFonts.montserrat(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _isSelected = !_isSelected;
                        });
                      },
                      child: Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          color: _isSelected
                              ? Color(0xff5351C7)
                              : Color(0xffF5F5F5),
                          borderRadius: BorderRadius.circular(4),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              spreadRadius: 0,
                              blurRadius: 1,
                              offset: Offset(-1, -3),
                            ),
                          ],
                        ),
                        child: _isSelected
                            ? Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 16,
                              )
                            : null,
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    SizedBox(
                      width: 196,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Notify patient on Whatsapp',
                            style: GoogleFonts.montserrat(
                                color: Colors.grey[700],
                                fontWeight: FontWeight.w500,
                                fontSize: 13),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "This will automatically send a remainder to patient's Whatsapp 20hrs ago to visit again.",
                            style: GoogleFonts.montserrat(
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                                fontSize: 11),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
