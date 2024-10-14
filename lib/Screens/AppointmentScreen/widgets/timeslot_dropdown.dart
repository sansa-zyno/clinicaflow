import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TimeSlotDropdown extends StatefulWidget {
  final String? value;
  final List<Map<String, dynamic>> items;
  final Function(Map<String, dynamic>?) onChanged;
  final String hintText;

  const TimeSlotDropdown({
    Key? key,
    required this.value,
    required this.items,
    required this.onChanged,
    required this.hintText,
  }) : super(key: key);

  @override
  TimeSlotDropdownState createState() => TimeSlotDropdownState();
}

class TimeSlotDropdownState extends State<TimeSlotDropdown> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      color: const Color(0xffF5F5F5),
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: 12, horizontal: 4),
        child: DropdownButtonFormField<Map<String, dynamic>>(
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: GoogleFonts.montserrat(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
            border: InputBorder.none,
            isDense: true,
          ),
          value: widget.value != null
              ? widget.items.firstWhere(
                  (timeSlot) =>
                      '${_formatTime(timeSlot['startTime'])} - ${_formatTime(timeSlot['endTime'])}' ==
                      widget.value,
                  orElse: () => widget.items.first,
                )
              : null,
          items: widget.items.map((Map<String, dynamic> timeSlot) {
            return DropdownMenuItem<Map<String, dynamic>>(
              value: timeSlot,
              child: Container(
                width:
                    MediaQuery.of(context).size.width * 0.25,
                child: Text(
                  '${_formatTime(timeSlot['startTime'])} - ${_formatTime(timeSlot['endTime'])}',
                  style: GoogleFonts.montserrat(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            );
          }).toList(),
          onChanged: (Map<String, dynamic>? newValue) {
            widget.onChanged(newValue);
          },
        ),
      ),
    );
  }

  String _formatTime(Map<String, dynamic> time) {
    String tt = time['tt'].toUpperCase();
    return '${time['hours']}:${time['min']} $tt';
  }
}
