import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healtether_clinic_app/business_logic/cubits/staff_cubit/staff_cubit.dart';
import 'package:healtether_clinic_app/constants/constants.dart';
import 'package:healtether_clinic_app/utils/mixins/ui_info_mixin.dart';
import 'package:healtether_clinic_app/widgets/buttons/my_selectable_container.dart';
import 'package:intl/intl.dart';

class AppointmentFilter extends StatefulWidget {
  const AppointmentFilter({super.key});

  @override
  State<AppointmentFilter> createState() => _AppointmentFilterState();
}

class _AppointmentFilterState extends State<AppointmentFilter> with UiInfoMixin {
  // DateTime? _selectedDate;

  String formattedDate = "Today";
  String attendingDoc = '';
  Map filter = {'selectedDate': '', 'selectedDoctor': ''};

  List<String> dates = ["Today", "Tomorrow", "Day after tomorrow", "Custom"];

  DateTime now = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    filter['selectedDate'] = '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<DateTime?> _showDatePickerBottomSheet(BuildContext context) async {
    DateTime? pickedDate = await showModalBottomSheet<DateTime>(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          height: 370,
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: CalendarDatePicker(
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                  onDateChanged: (date) {
                    Navigator.pop(context, date); // Return selected date
                  },
                ),
              ),
            ],
          ),
        );
      },
    );

    return pickedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'SORT BY',
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Container(
                padding: const EdgeInsets.only(right: 178.0),
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
          const SizedBox(height: 10),
          Text(
            'Date',
            style: GoogleFonts.roboto(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
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
                          if (formattedDate == currentDate) {
                            formattedDate = '';
                          } else {
                            formattedDate = currentDate;
                          }
                        });
                        if (formattedDate == 'Today') {
                          filter['selectedDate'] = '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
                        } else if (formattedDate == 'Tomorrow') {
                          DateTime nextDay = now.add(const Duration(days: 1));
                          filter['selectedDate'] =
                              '${nextDay.year}-${nextDay.month.toString().padLeft(2, '0')}-${(nextDay.day).toString().padLeft(2, '0')}';
                        } else if (formattedDate == 'Day after tomorrow') {
                          DateTime nextnextDay = now.add(const Duration(days: 2));
                          filter['selectedDate'] =
                              '${nextnextDay.year}-${nextnextDay.month.toString().padLeft(2, '0')}-${(nextnextDay.day).toString().padLeft(2, '0')}';
                        } else {
                          filter['selectedDate'] = formattedDate;
                        }
                      } else {
                        //final dynamic pickedDate = await pickDate(context, returnDateObject: true);
                        final pickedDate = await _showDatePickerBottomSheet(context);
                        if (pickedDate != null) {
                          setState(() {
                            formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                            dates[0] = formattedDate;
                          });
                          //widget.onDateSelected?.call(pickedDate); // Call callback
                          filter['selectedDate'] = formattedDate;
                        }
                      }
                    },
                    title: Text(currentDate,
                        style:
                            GoogleFonts.urbanist(textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.eerieBlack))),
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
          BlocBuilder<StaffCubit, StaffState>(builder: (context, state) {
            return state.doctors == null
                ? const Padding(
                    padding: EdgeInsets.all(25.0),
                    child: Center(child: CircularProgressIndicator()),
                  )
                : Expanded(
                    child: SingleChildScrollView(
                      child: Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: List<Widget>.generate(state.doctors!.length, (index) {
                            final doc = "${state.doctors![index]['firstName']} ${state.doctors![index]['lastName']}";

                            return SelectableContainer(
                                selected: attendingDoc == doc,
                                onTap: () {
                                  setState(() {
                                    if (attendingDoc == doc) {
                                      attendingDoc = '';
                                    } else {
                                      attendingDoc = doc;
                                    }
                                  });
                                  filter['selectedDoctor'] = attendingDoc;
                                },
                                title: Text("${doc != "Other" ? 'Dr.' : ''}$doc",
                                    style: GoogleFonts.urbanist(
                                        textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.eerieBlack))),
                                selectedTitle: Text("${doc != "Other" ? 'Dr.' : ''}$doc",
                                    style: GoogleFonts.urbanist(
                                        textStyle: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ))));
                          })),
                    ),
                  );
          }),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 46,
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
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context, filter); // Return selected date
                  },
                  child: Container(
                    height: 46,
                    decoration: BoxDecoration(
                      color: const Color(0xff198E79),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Center(
                      child: Text(
                        'Apply',
                        style: GoogleFonts.urbanist(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.white),
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
  }
}
