import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healtether_clinic_app/constants/constants.dart';
import 'package:healtether_clinic_app/utils/mixins/ui_info_mixin.dart';
import 'package:healtether_clinic_app/widgets/buttons/my_selectable_container.dart';
import 'package:intl/intl.dart';

class ScheduleSearchBox extends StatefulWidget {
  final Function(DateTime)? onDateSelected; // Define onDateSelected callback

  const ScheduleSearchBox({Key? key, this.onDateSelected}) : super(key: key);

  @override
  _ScheduleSearchBoxState createState() => _ScheduleSearchBoxState();
}

class _ScheduleSearchBoxState extends State<ScheduleSearchBox>
    with UiInfoMixin {
  // DateTime? _selectedDate;

  String formattedDate = "Today";
  String attendingDoc = "Dr. Ajit Bhalla";

  List<String> attendingDocs = [
    "Ajit Bhalla",
    "Kim Jones",
    "Annie Beasant",
    "Other"
  ];

  List<String> dates = ["Today", "Tomorrow", "Day after tomorrow", "Custom"];

  @override
  void dispose() {
    formattedDate = "Today";

    dates[0] = formattedDate;

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.tune_outlined,
        color: Color(0xff413D56),
      ),
      onPressed: () {
        showDateBox(context);
      },
    );
  }

  void showDateBox(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'SORT BY',
                  style: GoogleFonts.montserrat(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(
                    right: 178.0,
                  ),
                  child: const SizedBox(
                    height: 1,
                    width: 54,
                    child: Divider(
                      thickness: 2,
                      color: Color(0xff52CFAC),
                    ),
                  ),
                ),
              ],
            ),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Date',
                  style: GoogleFonts.roboto(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: List<Widget>.generate(dates.length, (index) {
                      final currentDate = dates.elementAt(index);

                      return SelectableContainer(
                          selected: currentDate == formattedDate,
                          onTap: () async {
                            if (index != dates.length - 1) {
                              setState(() {
                                formattedDate = currentDate;
                              });
                            } else {
                              final dynamic pickedDate = await pickDate(context,
                                  returnDateObject: true);
                              if (pickedDate != null) {
                                setState(() {
                                  formattedDate = DateFormat('dd/MM/yyyy')
                                      .format(pickedDate);
                                  dates[0] = formattedDate;
                                });
                                widget.onDateSelected
                                    ?.call(pickedDate); // Call callback
                              }
                            }
                          },
                          title: Text(currentDate,
                              style: GoogleFonts.urbanist(
                                  textStyle: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.eerieBlack))),
                          selectedTitle: Text(currentDate,
                              style: GoogleFonts.urbanist(
                                  textStyle: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ))));
                    })),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  'Attending Doc',
                  style: GoogleFonts.roboto(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children:
                        List<Widget>.generate(attendingDocs.length, (index) {
                      final doc = attendingDocs.elementAt(index);

                      return SelectableContainer(
                          selected: attendingDoc == doc,
                          onTap: () {
                            setState(() {
                              attendingDoc = doc;
                            });
                          },
                          title: Text("${doc != "Other" ? 'Dr.' : ''} $doc",
                              style: GoogleFonts.urbanist(
                                  textStyle: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.eerieBlack))),
                          selectedTitle:
                              Text("${doc != "Other" ? 'Dr.' : ''} $doc",
                                  style: GoogleFonts.urbanist(
                                      textStyle: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ))));
                    })),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 46,
                        width: 102,
                        decoration: BoxDecoration(
                          color: const Color(0xff198E79),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Center(
                          child: Text(
                            'Apply',
                            style: GoogleFonts.urbanist(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 46,
                        width: 102,
                        decoration: BoxDecoration(
                          color: const Color(0xffF5F5F5),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Center(
                          child: Text(
                            'Exit',
                            style: GoogleFonts.urbanist(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
      },
    );
  }
}
