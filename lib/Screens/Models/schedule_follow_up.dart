/*import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../ScheduledAppoint/AppointmentFirstScreen/widgets/date_cards.dart';

class SchedulfollowBox extends StatefulWidget {
  @override
  _SchedulfollowBoxState createState() => _SchedulfollowBoxState();
}

class _SchedulfollowBoxState extends State<SchedulfollowBox> {
  DateTime? _selectedDate;
  String selectedDate = '';
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Text('Schedule Follow-up'),
      onTap: () {
        showFollowUpBox(context);
      },
    );
  }

  void showFollowUpBox(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'SCHEDULE FOLLOW-UP',
            style: GoogleFonts.montserrat(
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
          content: SizedBox(
            width: 700,
            height: 390,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(
                    right: 178.0,
                  ),
                  child: SizedBox(
                    height: 1,
                    width: 54,
                    child: Divider(
                      thickness: 2,
                      color: Color(0xff52CFAC),
                    ),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Follow-up date',
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        final DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                          builder: (BuildContext context, Widget? child) {
                            return Theme(
                              data: ThemeData.light().copyWith(
                                colorScheme: ColorScheme.light(
                                  primary:
                                      Color(0xff32856E), // Your chosen color
                                  onPrimary: Colors.white,
                                ),
                              ),
                              child: child!,
                            );
                          },
                        );
                        if (pickedDate != null && pickedDate != _selectedDate) {
                          setState(() {
                            _selectedDate = pickedDate;
                          });
                        }
                      },
                      child: Container(
                        height: 56,
                        color: Color(0xffF5F5F5),
                        width: 120,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 15, bottom: 10, left: 10, right: 30),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  _selectedDate != null
                                      ? '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'
                                      : 'Select',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: _selectedDate != null
                                        ? Colors.black
                                        : Colors.grey,
                                  ),
                                ),
                              ),
                              Icon(
                                Icons.arrow_drop_down,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: 36,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      DateCards(
                        width: 50,
                        isSelected: selectedDate == 'Today',
                        onTap: () {
                          setState(() {
                            selectedDate = 'Today';
                          });
                        },
                        text: 'Today',
                      ),
                      DateCards(
                        width: 80,
                        isSelected: selectedDate == 'Tomorrow',
                        onTap: () {
                          setState(() {
                            selectedDate = 'Tomorrow';
                          });
                        },
                        text: 'Tomorrow',
                      ),
                      DateCards(
                        width: 97,
                        isSelected: selectedDate == 'After a week',
                        onTap: () {
                          setState(() {
                            selectedDate = 'After a week';
                          });
                        },
                        text: 'After a week',
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Time slot',
                      style: GoogleFonts.montserrat(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        final DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                          builder: (BuildContext context, Widget? child) {
                            return Theme(
                              data: ThemeData.light().copyWith(
                                colorScheme: ColorScheme.light(
                                  primary:
                                      Color(0xff32856E), // Your chosen color
                                  onPrimary: Colors.white,
                                ),
                              ),
                              child: child!,
                            );
                          },
                        );
                        if (pickedDate != null && pickedDate != _selectedDate) {
                          setState(() {
                            _selectedDate = pickedDate;
                          });
                        }
                      },
                      child: Container(
                        height: 56,
                        color: Color(0xffF5F5F5),
                        width: 130,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 15, bottom: 10, left: 10, right: 30),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  _selectedDate != null
                                      ? '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'
                                      : 'Select',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: _selectedDate != null
                                        ? Colors.black
                                        : Colors.grey,
                                  ),
                                ),
                              ),
                              Icon(
                                Icons.arrow_drop_down,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
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
                                color: Colors.grey,
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
                SizedBox(
                  height: 30,
                ),
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
                            'Schedule',
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
              ],
            ),
          ),
        );
      },
    );
  }
}*/
