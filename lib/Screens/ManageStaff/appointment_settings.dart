// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healtether_clinic_app/Screens/AppointmentScreen/appointment_detail.dart';
import 'package:healtether_clinic_app/Screens/AppointmentScreen/widgets/custom_textfield.dart';
import 'package:healtether_clinic_app/Screens/ManageStaff/staff_records_screen.dart';
import 'package:healtether_clinic_app/business_logic/cubits/staff_cubit/staff_cubit.dart';
import 'package:healtether_clinic_app/data_layer/models/appointment_slot/appointment_slot.dart';
import 'package:healtether_clinic_app/data_layer/models/appointment_slot/time_slot.dart';
import 'package:healtether_clinic_app/data_layer/models/day.dart';
import 'package:healtether_clinic_app/constants/app_icons.dart';
import 'package:healtether_clinic_app/data_layer/models/staff_model/create_staff_model.dart';
import 'package:healtether_clinic_app/data_layer/models/staff_model/staff_model.dart';
import 'package:healtether_clinic_app/data_layer/services/shared_preferences_service.dart';
import 'package:healtether_clinic_app/utils/enums/bloc_enums.dart';
import 'package:healtether_clinic_app/utils/enums/route_enums.dart';
import 'package:healtether_clinic_app/utils/extensions.dart/string_extensions.dart';
import 'package:healtether_clinic_app/utils/extensions.dart/widget_extensions.dart';
import 'package:healtether_clinic_app/utils/helper_functions/log.dart';
import 'package:healtether_clinic_app/utils/mixins/app_bar_mixin.dart';
import 'package:healtether_clinic_app/constants/constants.dart';
import 'package:healtether_clinic_app/widgets/buttons/my_elevated_button.dart';
import 'package:healtether_clinic_app/widgets/buttons/my_selectable_container.dart';
import 'package:healtether_clinic_app/widgets/buttons/my_text_button.dart';
import 'package:healtether_clinic_app/widgets/components/scrollable_row.dart';
import 'package:healtether_clinic_app/widgets/time_slot_item.dart';
import 'package:intl/intl.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:uuid/uuid.dart';
import 'dart:developer' as dev;

class AppointmentSettings extends StatefulWidget {
  final CreateStaff createStaff;
  const AppointmentSettings({super.key, required this.createStaff});

  @override
  State<AppointmentSettings> createState() => _AppointmentSettingsState();
}

class _AppointmentSettingsState extends State<AppointmentSettings> with AppBarMixin {
  late List<AppointmentSlot> appointmentSlots;
  int idx = 0;
  final PageController pageController = PageController(initialPage: 4);
  TextEditingController appointmentDuration = TextEditingController();

  BoxDecoration get decoration => BoxDecoration(border: Border.all(color: AppColors.lightGrey), borderRadius: BorderRadius.circular(12));

  @override
  void initState() {
    super.initState();

    appointmentSlots = [
      AppointmentSlot(
        id: Uuid().v4(),
        timeSlots: [TimeSlot(Uuid().v4())],
        duration: '',
        days: [],
      ),
    ];
  }

  final List<Day> days = [
    Day(dayOfWeek: 7),
    Day(dayOfWeek: 1),
    Day(dayOfWeek: 2),
    Day(dayOfWeek: 3),
    Day(dayOfWeek: 4),
    Day(dayOfWeek: 5),
    Day(dayOfWeek: 6),
  ];

//keeps track of days selected in each appointment and add to a List
  List<List<Day>> get daysSet {
    List<List<Day>> res = [];
    for (var slot in appointmentSlots) {
      res.add(slot.days.toSet().toList());
    }
    return res;
  }

  //keeps track of days selected accross all appointments
  List<Day> get daysSetOneList {
    List<Day> res = [];
    for (var slot in appointmentSlots) {
      res.addAll(slot.days);
    }
    return res.toSet().toList();
  }

  Map<String, dynamic> filterAppointments(int i) {
    List<TimeSlot> res = appointmentSlots[i].timeSlots;

    res = res.where((element) => element.start != null && element.finish != null).toList();
    return {"_duration": appointmentSlots[i].duration, "_timeSlots": res};
  }

  int timeSlotTitle = 0;
  List<String> timeSlots = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add member'),
        actions: [
          /*TextButton(
            onPressed: () {},
            child: const Text(
              'Skip',
              style: TextStyle(color: Color(0XFF4646B5), fontSize: 18),
            ),
          ),*/
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: BlocBuilder<StaffCubit, StaffState>(builder: (context, state) {
        if (state.errorMessage != null) {
          return Center(child: Text('Error: ${state.errorMessage}'));
        }
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SmoothPageIndicator(
                  controller: pageController,
                  count: 5,
                  effect: const ExpandingDotsEffect(
                    expansionFactor: 5,
                    dotColor: Color(0XFF5351C7),
                    strokeWidth: 3,
                    dotHeight: 8,
                    dotWidth: 8,
                    paintStyle: PaintingStyle.fill,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Appointment Settings',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(
                  height: 6,
                ),
                //start here
                ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: appointmentSlots.length,
                    itemBuilder: (context, mainIndex) {
                      appointmentDuration = TextEditingController(text: appointmentSlots[mainIndex].duration);
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Visibility(
                            visible: idx != mainIndex, //if index not equal
                            child: Container(
                                padding: const EdgeInsets.all(8),
                                // width: double.maxFinite,
                                decoration: BoxDecoration(color: AppColors.whiteSmoke, borderRadius: BorderRadius.circular(8)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("For ${daysSet[mainIndex].map((e) => e.day.capitalize[0]).join(', ')}"),
                                    GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            idx = mainIndex;
                                          });
                                        },
                                        child: AppIcons.arrowDropDown)
                                  ],
                                )),
                          ),
                          const SizedBox(height: 8),
                          Visibility(
                            visible: idx == mainIndex, //if index is equal
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 8),
                              decoration: decoration,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // for | up arrow
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "For",
                                        style: GoogleFonts.urbanist(
                                            textStyle: TextStyle(color: AppColors.eerieBlack, fontWeight: FontWeight.w500, fontSize: 17)),
                                      ),
                                      GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              idx = mainIndex + 1;
                                            });
                                          },
                                          child: AppIcons.arrowUp)
                                    ],
                                  ).pOnly(bottom: 16),

                                  ScrollableRow(
                                      children: List<Widget>.generate(days.length, (index) {
                                    final String day = days[index].day;
                                    final bool selected = appointmentSlots[mainIndex].hasDay(days[index]);
                                    bool tappable = true;

                                    log("Day set: $daysSet");

                                    // if day has already been set and it doesnt belong to the current selected appointment

                                    if (daysSetOneList.contains(days[index]) && appointmentSlots[mainIndex].hasDay(days[index]) == false) {
                                      // print("Aready set day: $day");
                                      tappable = false;
                                    }

                                    // print(daysSet.contains(Day(dayOfWeek: 7)));

                                    return SelectableContainer(
                                      title: Text(
                                        day[0].capitalize,
                                        style: !tappable ? const TextStyle(color: AppColors.grey) : null,
                                      ),
                                      borderColor: tappable ? AppColors.eerieBlack : AppColors.whiteSmoke,
                                      backgroundColor: tappable ? null : AppColors.whiteSmoke,
                                      selectedTitle: Text(day[0].capitalize, style: TextStyle(color: Colors.white)),
                                      onTap: () {
                                        log("tapped: $day, selected: $selected, tappable: $tappable");
                                        if (!tappable) {
                                          log("cannot be tapped: $day");
                                          return;
                                        }
                                        setState(() {
                                          if (selected) {
                                            log("Removing day");
                                            appointmentSlots[mainIndex].removeDay(days[index]);
                                          } else {
                                            log("Adding day");
                                            appointmentSlots[mainIndex].addDay(days[index]);
                                          }
                                        });
                                      },
                                      selected: selected,
                                    ).pSymmetric(horizontal: 2);
                                  })).pOnly(bottom: 16),

                                  //? CONTAINER WITH TIME SLOTS
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                    constraints: BoxConstraints(minHeight: 0, maxHeight: MediaQuery.of(context).size.height / 2),
                                    decoration: decoration,
                                    child: SingleChildScrollView(
                                        // itemCount: appointmentSlots.length,
                                        child: Column(children: [
                                      //? LIST OF TIME SLOTS
                                      ...List<Widget>.generate(appointmentSlots[mainIndex].timeSlots.length, (index) {
                                        final tSlot = appointmentSlots[mainIndex].timeSlots[index];

                                        return Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("Slot ${index + 1}",
                                                style: GoogleFonts.urbanist(
                                                    textStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 17, height: 22.78 / 17))),
                                            const SizedBox(height: 8),
                                            TimeSlotItem(
                                                slot: tSlot,
                                                onTap: () => {},
                                                /*updateSelectedAppointmentSlot(
                                                        appointmentSlots[
                                                            mainIndex],
                                                        mainIndex),*/
                                                selected: appointmentSlots[mainIndex].timeSlots[index] == tSlot,
                                                onStartChanged: (newTime) {
                                                  updateTimeSlot(appointmentSlots[mainIndex], index,
                                                      appointmentSlots[mainIndex].timeSlots[index].copyWith(start: newTime));
                                                },
                                                onFinishChanged: (newTime) {
                                                  // update the timeslot
                                                  updateTimeSlot(appointmentSlots[mainIndex], index,
                                                      appointmentSlots[mainIndex].timeSlots[index].copyWith(finish: newTime));
                                                },
                                                showDelete: appointmentSlots.length > 1,
                                                onDelete: () {
                                                  deleteAppointmentTimeSlot(appointmentSlots[mainIndex], index);
                                                }).pOnly(bottom: 16),
                                          ],
                                        );
                                      }),

                                      // const SizedBox(height: 16),

                                      //? ADD NEW SLOT
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          MyTextButton(
                                              text: 'Add slot',
                                              onTap: () {
                                                log("Add slot");
                                                setState(() {
                                                  appointmentSlots[mainIndex].timeSlots.add(TimeSlot(Uuid().v4()));
                                                });
                                              }),
                                        ],
                                      )
                                    ])),
                                  ),

                                  //? APPOINTMENT DURATION
                                  Row(
                                    children: [
                                      // text
                                      SectionText2("Appointment duration"),

                                      const SizedBox(
                                        width: 12,
                                      ),

                                      // duration textfield
                                      Expanded(child: Builder(builder: (context) {
                                        return CustomTextField(
                                            keyBoardType: TextInputType.number,
                                            inputFormatters: [LengthLimitingTextInputFormatter(2), FilteringTextInputFormatter.digitsOnly],
                                            controller: appointmentDuration,
                                            hintText: '',
                                            onChanged: (x) {
                                              appointmentSlots[mainIndex].duration = x;
                                            },
                                            height: 54);
                                      })),

                                      const SizedBox(
                                        width: 8,
                                      ),

                                      // unit(minutes)
                                      Text(
                                        "Minutes",
                                        style: GoogleFonts.roboto(textStyle: TextStyle(fontSize: 14, height: 17.16 / 14)),
                                      )
                                    ],
                                  ).pSymmetric(horizontal: 0, vertical: 16),

                                  // delete | preview
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      // delete
                                      // MyElevatedButton(
                                      //   text: "Delete",
                                      //   backgroundColor: Colors.white,

                                      //   onPressed: ,
                                      //   height: 46,
                                      // ),

                                      MyTextButton(
                                        text: "Delete",
                                        textStyle: TextStyle(color: AppColors.eerieBlack, fontWeight: FontWeight.w600),
                                        onTap: () => deleteAppointment(appointmentSlots[mainIndex], mainIndex),
                                      ),

                                      // preview
                                      MyElevatedButton(
                                        text: "Preview",
                                        backgroundColor: AppColors.whiteSmoke,
                                        textStyle: TextStyle(color: AppColors.eerieBlack),
                                        onPressed: () {
                                          timeSlots = generateTimeSlots(mainIndex, timeSlotTitle);
                                          if (timeSlots.isNotEmpty) {
                                            showTimeSlot(mainIndex);
                                          }
                                        },
                                        height: 46,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
                //end here

                const SizedBox(
                  height: 20,
                ),
                MyTextButton(
                    text: 'Schedule for the other days',
                    onTap: () {
                      if (daysSetOneList.length < 7) {
                        appointmentSlots.add(
                          AppointmentSlot(
                            id: Uuid().v4(),
                            timeSlots: [TimeSlot(Uuid().v4())],
                            duration: '',
                            days: [],
                          ),
                        );
                        idx = appointmentSlots.length - 1;
                        setState(() {});
                        //log("Schedule days");
                      }
                    }),
                SizedBox(height: 50),
                state.state == StaffStates.creatingStaff
                    ? Center(child: CircularProgressIndicator())
                    : GestureDetector(
                        onTap: () async {
                          if (appointmentSlots.isNotEmpty) {
                            String clinicId = '';
                            clinicId = (await SharedPrefService.getClinicId())!;
                            widget.createStaff.availableTimeSlot = appointmentSlots;
                            widget.createStaff.clientId = clinicId;
                            context.read<StaffCubit>().createStaff(widget.createStaff, context).then((_) {
                              if (state.errorMessage == null) {
                                Navigator.pop(context);
                                Navigator.pop(context);
                                Navigator.pop(context);
                                Navigator.pop(context);
                                Navigator.pop(context);
                                Navigator.pop(context);
                                context.pushNamed(AppRoutes.manageStaff.name);
                              }
                            });
                          } else {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                    content: Text("Please add schedules"),
                                  );
                                });
                          }
                        },
                        child: Container(
                          height: 52,
                          margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                          decoration: BoxDecoration(
                            color: AppColors.greenColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              AppText.save,
                              style: GoogleFonts.montserrat(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: AppColors.whiteColor,
                              ),
                            ),
                          ),
                        ),
                      ),
              ],
            ),
          ),
        );
      }),
    );
  }

  showTimeSlot(int appointmentIndex) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          log(timeSlots.toString());
          return Container(
            padding: const EdgeInsets.all(16),
            width: MediaQuery.of(context).size.width,
            constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height / 2),
            decoration:
                BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                        onTap: () {
                          if (timeSlotTitle > 0) {
                            timeSlotTitle = timeSlotTitle - 1;
                            if (timeSlotTitle >= 0) {
                              log(timeSlots.toString());
                              timeSlots = generateTimeSlots(appointmentIndex, timeSlotTitle);
                              context.pop();
                              showTimeSlot(appointmentIndex);
                            } else {
                              timeSlotTitle = 0;
                            }
                          }
                        },
                        child: Icon(Icons.arrow_back_ios, size: 20)),
                    Text('Slot ${timeSlotTitle + 1}'),
                    InkWell(
                      onTap: () {
                        if (timeSlotTitle < filterAppointments(appointmentIndex)['_timeSlots'].length) {
                          timeSlotTitle = timeSlotTitle + 1;
                          if (timeSlotTitle < filterAppointments(appointmentIndex)['_timeSlots'].length) {
                            log(timeSlots.toString());
                            timeSlots = generateTimeSlots(appointmentIndex, timeSlotTitle);
                            context.pop();
                            showTimeSlot(appointmentIndex);
                          } else {
                            timeSlotTitle = timeSlotTitle - 1;
                          }
                        }
                      },
                      child: Icon(Icons.arrow_forward_ios, size: 20),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: GridView.builder(
                        itemCount: timeSlots.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, childAspectRatio: 5.0, crossAxisSpacing: 15, mainAxisSpacing: 12),
                        itemBuilder: (ctx, index) => Container(
                              decoration: BoxDecoration(border: Border.all(color: Color(0xffE1E1E1)), borderRadius: BorderRadius.circular(8)),
                              child: Center(
                                child: Text(
                                  timeSlots[index],
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            )),
                  ),
                ),
              ],
            ),
          );
        });
  }

  void deleteAppointment(AppointmentSlot slot, int index) {
    setState(() {
      if (appointmentSlots.length > 1) {
        appointmentSlots.remove(slot);
      }
    });
  }

  void deleteAppointmentTimeSlot(AppointmentSlot slot, timeSlotindex) {
    setState(() {
      if (slot.timeSlots.length > 1) {
        slot.timeSlots.remove(slot.timeSlots[timeSlotindex]);
      }
    });
  }

  void updateTimeSlot(AppointmentSlot slot, int timeSlotindex, TimeSlot newTimeSlot) {
    slot.timeSlots[timeSlotindex] = newTimeSlot;
    log(slot);
  }

  List<String> generateTimeSlots(int appointmentIndex, int timeSlotIndex) {
    List<String> timeSlots = [];
    if (filterAppointments(appointmentIndex)['_timeSlots'].isNotEmpty && filterAppointments(appointmentIndex)['_duration'].isNotEmpty) {
      String startTimeText = filterAppointments(appointmentIndex)['_timeSlots'][timeSlotIndex].start?.format(context) ?? '';
      String endTimeText = filterAppointments(appointmentIndex)['_timeSlots'][timeSlotIndex].finish?.format(context) ?? '';
      int interval = int.parse(filterAppointments(appointmentIndex)['_duration']);
      int startHour;
      int startMin;
      int endHour;
      int endMin;
      if (startTimeText.toLowerCase().contains('am')) {
        String time = startTimeText.split(' ')[0];
        startHour = int.parse(time.split(':')[0]);
        startMin = int.parse(time.split(':')[1]);
      } else {
        String time = startTimeText.split(' ')[0];
        startHour = int.parse(time.split(':')[0]);
        startHour = startHour + 12;
        startMin = int.parse(time.split(':')[1]);
      }
      if (endTimeText.toLowerCase().contains('am')) {
        String time = endTimeText.split(' ')[0];
        endHour = int.parse(time.split(':')[0]);
        endMin = int.parse(time.split(':')[1]);
      } else {
        String time = endTimeText.split(' ')[0];
        endHour = int.parse(time.split(':')[0]);
        endHour = endHour + 12;
        endMin = int.parse(time.split(':')[1]);
      }
      DateTime startTime = DateTime(2024, 1, 1, startHour, startMin);
      DateTime endTime = DateTime(2024, 1, 1, endHour, endMin);
      while (startTime.isBefore(endTime)) {
        DateTime nextTime = startTime.add(Duration(minutes: interval));
        timeSlots.add("${DateFormat('h:mm a').format(startTime)} - ${DateFormat('h:mm a').format(nextTime)}");
        startTime = nextTime;
      }
    }
    return timeSlots;
  }
}
