import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:clinica_flow/shared/widgets/custom_textfield.dart';
import 'package:clinica_flow/features/team/viewmodel/staff_cubit.dart';
import 'package:clinica_flow/features/appointment/model/appointment_slot.dart';
import 'package:clinica_flow/features/appointment/model/time_slot.dart';
import 'package:clinica_flow/features/appointment/model/day.dart';
import 'package:clinica_flow/core/constants/app_icons.dart';
import 'package:clinica_flow/core/utils/shared_preferences_service.dart';
import 'package:clinica_flow/core/utils/enums/bloc_enums.dart';
import 'package:clinica_flow/core/utils/enums/route_enums.dart';
import 'package:clinica_flow/core/utils/extensions.dart/string_extensions.dart';
import 'package:clinica_flow/core/utils/extensions.dart/widget_extensions.dart';
import 'package:clinica_flow/core/utils/mixins/app_bar_mixin.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_text.dart';
import 'package:clinica_flow/core/utils/snackbar.dart';
import 'package:clinica_flow/shared/widgets/buttons/my_elevated_button.dart';
import 'package:clinica_flow/shared/widgets/buttons/my_selectable_container.dart';
import 'package:clinica_flow/shared/widgets/buttons/my_text_button.dart';
import 'package:clinica_flow/shared/widgets/components/scrollable_row.dart';
import 'package:clinica_flow/shared/widgets/time_slot_item.dart';
import 'package:intl/intl.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:uuid/uuid.dart';
import '../../../../features/appointment/view/appointment_detail.dart';
import '../../../models/created_model.dart';
import '../../../../features/team/model/staff_model.dart';
import 'package:clinica_flow/core/utils/responsive_layout.dart';

class AppointmentSettings extends StatefulWidget {
  final StaffModel staff;
  const AppointmentSettings({super.key, required this.staff});

  @override
  State<AppointmentSettings> createState() => _AppointmentSettingsState();
}

class _AppointmentSettingsState extends State<AppointmentSettings>
    with AppBarMixin {
  late List<AppointmentSlot> appointmentSlots;
  late List<TextEditingController> _durationControllers;
  int idx = 0;
  final PageController _pageController = PageController(initialPage: 4);
  int timeSlotTitle = 0;
  List<String> timeSlots = [];

  final List<Day> days = [
    Day(dayOfWeek: 7),
    Day(dayOfWeek: 1),
    Day(dayOfWeek: 2),
    Day(dayOfWeek: 3),
    Day(dayOfWeek: 4),
    Day(dayOfWeek: 5),
    Day(dayOfWeek: 6),
  ];

  @override
  void initState() {
    super.initState();
    appointmentSlots = [
      AppointmentSlot(
        id: const Uuid().v4(),
        timeSlots: [TimeSlot(const Uuid().v4())],
        duration: '',
        days: [],
      ),
    ];
    _durationControllers = [TextEditingController()];
  }

  @override
  void dispose() {
    for (var controller in _durationControllers) {
      controller.dispose();
    }
    _pageController.dispose();
    super.dispose();
  }

  List<List<Day>> get daysSet {
    return appointmentSlots.map((slot) => slot.days.toSet().toList()).toList();
  }

  List<Day> get daysSetOneList {
    return appointmentSlots.expand((slot) => slot.days).toSet().toList();
  }

  BoxDecoration get _cardDecoration => BoxDecoration(
        border: Border.all(color: AppColors.lightGrey),
        borderRadius: BorderRadius.circular(12),
      );

  @override
  Widget build(BuildContext context) {
    final mobileView = Scaffold(
      appBar: AppBar(
        leadingWidth: 30,
        title: const Text(AppText.addMember),
      ),
      body: BlocListener<StaffCubit, StaffState>(
        listener: _onStaffStateChanged,
        child: BlocBuilder<StaffCubit, StaffState>(
          builder: (context, state) {
            if (state.errorMessage != null) {
              return Center(child: Text('Error: ${state.errorMessage}'));
            }
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildProgressIndicator(),
                  const SizedBox(height: 10),
                  const Text(
                    'Appointment Settings',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                  const SizedBox(height: 6),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildAppointmentSlotList(),
                          const SizedBox(height: 20),
                          _buildAddOtherDaysButton(),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                  _buildSaveButton(state),
                  const SizedBox(height: 20),
                ],
              ),
            );
          },
        ),
      ),
    );

    return ResponsiveLayout(
      mobile: mobileView,
      desktop: Scaffold(
        backgroundColor: const Color(0xffF5F5F5),
        body: Center(
          child: Container(
            width: 600,
            height: 800,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: MediaQuery(
              data: MediaQuery.of(context).copyWith(
                size: const Size(600, 800),
              ),
              child: mobileView,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return SmoothPageIndicator(
      controller: _pageController,
      count: 5,
      effect: const ExpandingDotsEffect(
        expansionFactor: 5,
        activeDotColor: AppColors.primaryColor,
        dotColor: AppColors.greyColor,
        strokeWidth: 3,
        dotHeight: 8,
        dotWidth: 8,
        paintStyle: PaintingStyle.fill,
      ),
    );
  }

  Widget _buildAppointmentSlotList() {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: appointmentSlots.length,
      itemBuilder: (context, index) => _buildAppointmentSlotItem(index),
    );
  }

  Widget _buildAppointmentSlotItem(int index) {
    final bool isExpanded = idx == index;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (!isExpanded)
          GestureDetector(
            onTap: () => setState(() => idx = index),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.whiteSmoke,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      "For ${daysSet[index].map((e) => e.day.capitalize[0]).join(', ')}"),
                  AppIcons.arrowDropDown,
                ],
              ),
            ),
          )
        else
          Container(
            padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 8),
            decoration: _cardDecoration,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildSlotHeader(index),
                _buildDaySelector(index),
                _buildTimeSlotSection(index),
                _buildDurationSection(index),
                _buildActionButtons(index),
              ],
            ),
          ),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _buildSlotHeader(int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "For",
          style: GoogleFonts.urbanist(
            textStyle: const TextStyle(
              color: AppColors.eerieBlack,
              fontWeight: FontWeight.w500,
              fontSize: 17,
            ),
          ),
        ),
        GestureDetector(
          onTap: () => setState(() => idx = index + 1),
          child: AppIcons.arrowUp,
        ),
      ],
    ).pOnly(bottom: 16);
  }

  Widget _buildDaySelector(int index) {
    return ScrollableRow(
      children: List<Widget>.generate(days.length, (dayIndex) {
        final day = days[dayIndex];
        final bool isSelected = appointmentSlots[index].hasDay(day);
        final bool isTappable = !daysSetOneList.contains(day) || isSelected;

        return SelectableContainer(
          title: Text(
            day.day[0].capitalize,
            style: !isTappable ? const TextStyle(color: AppColors.grey) : null,
          ),
          borderColor: isTappable ? AppColors.eerieBlack : AppColors.whiteSmoke,
          backgroundColor: isTappable ? null : AppColors.whiteSmoke,
          selectedTitle: Text(
            day.day[0].capitalize,
            style: const TextStyle(color: Colors.white),
          ),
          onTap: () {
            if (!isTappable) return;
            setState(() {
              if (isSelected) {
                appointmentSlots[index].removeDay(day);
              } else {
                appointmentSlots[index].addDay(day);
              }
            });
          },
          selected: isSelected,
        ).pSymmetric(horizontal: 2);
      }),
    ).pOnly(bottom: 16);
  }

  Widget _buildTimeSlotSection(int index) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      constraints: BoxConstraints(
        minHeight: 0,
        maxHeight: MediaQuery.of(context).size.height / 2,
      ),
      decoration: _cardDecoration,
      child: SingleChildScrollView(
        child: Column(
          children: [
            ...List<Widget>.generate(appointmentSlots[index].timeSlots.length,
                (slotIndex) {
              final tSlot = appointmentSlots[index].timeSlots[slotIndex];
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Slot ${slotIndex + 1}",
                    style: GoogleFonts.urbanist(
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 17,
                        height: 22.78 / 17,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TimeSlotItem(
                    slot: tSlot,
                    onTap: () {},
                    selected: true,
                    onStartChanged: (newTime) {
                      setState(() {
                        appointmentSlots[index].timeSlots[slotIndex] =
                            tSlot.copyWith(start: newTime);
                      });
                    },
                    onFinishChanged: (newTime) {
                      setState(() {
                        appointmentSlots[index].timeSlots[slotIndex] =
                            tSlot.copyWith(finish: newTime);
                      });
                    },
                    showDelete: appointmentSlots[index].timeSlots.length > 1,
                    onDelete: () {
                      setState(() {
                        appointmentSlots[index].timeSlots.removeAt(slotIndex);
                      });
                    },
                  ).pOnly(bottom: 16),
                ],
              );
            }),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MyTextButton(
                  text: 'Add slot',
                  onTap: () {
                    setState(() {
                      appointmentSlots[index]
                          .timeSlots
                          .add(TimeSlot(const Uuid().v4()));
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDurationSection(int index) {
    return Row(
      children: [
        SectionText2("Appointment duration"),
        const SizedBox(width: 12),
        Expanded(
          child: CustomTextField(
            keyBoardType: TextInputType.number,
            inputFormatters: [
              LengthLimitingTextInputFormatter(2),
              FilteringTextInputFormatter.digitsOnly,
            ],
            controller: _durationControllers[index],
            hintText: '',
            onChanged: (val) => appointmentSlots[index].duration = val,
            height: 54,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          "Minutes",
          style: GoogleFonts.roboto(
            textStyle: const TextStyle(fontSize: 14, height: 17.16 / 14),
          ),
        ),
      ],
    ).pSymmetric(horizontal: 0, vertical: 16);
  }

  Widget _buildActionButtons(int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        MyTextButton(
          text: "Delete",
          textStyle: const TextStyle(
              color: AppColors.eerieBlack, fontWeight: FontWeight.w600),
          onTap: () {
            setState(() {
              if (appointmentSlots.length > 1) {
                appointmentSlots.removeAt(index);
                _durationControllers.removeAt(index);
              }
            });
          },
        ),
        MyElevatedButton(
          text: "Preview",
          backgroundColor: AppColors.whiteSmoke,
          textStyle: const TextStyle(color: AppColors.eerieBlack),
          onPressed: () {
            timeSlots = _generateTimeSlots(index, timeSlotTitle);
            if (timeSlots.isNotEmpty) {
              _showTimeSlotModal(index);
            }
          },
          height: 46,
        ),
      ],
    );
  }

  Widget _buildAddOtherDaysButton() {
    return MyTextButton(
      text: 'Schedule for the other days',
      onTap: () {
        if (daysSetOneList.length < 7) {
          setState(() {
            appointmentSlots.add(
              AppointmentSlot(
                id: const Uuid().v4(),
                timeSlots: [TimeSlot(const Uuid().v4())],
                duration: '',
                days: [],
              ),
            );
            _durationControllers.add(TextEditingController());
            idx = appointmentSlots.length - 1;
          });
        }
      },
    );
  }

  Widget _buildSaveButton(StaffState state) {
    if (state.state == StaffStates.creatingStaff) {
      return const Center(child: CircularProgressIndicator());
    }
    return GestureDetector(
      onTap: _onSave,
      child: Container(
        height: 52,
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
    );
  }

  void _onStaffStateChanged(BuildContext context, StaffState state) {
    if (state.state == StaffStates.staffCreated) {
      for (int i = 0; i < 6; i++) Navigator.pop(context);
      showSnackbar("Staff created successfully", context);
      context.pushNamed(AppRoutes.manageStaff.name);
    }
  }

  void _onSave() async {
    final String clinicId = await SharedPrefService.getClinicId() ?? '';
    widget.staff.availableTimeSlot = appointmentSlots;
    widget.staff.clientId = clinicId;
    widget.staff.createdOn =
        Created(by: By(id: '', name: ''), on: DateTime.now());
    widget.staff.modifiedOn =
        Created(by: By(id: '', name: ''), on: DateTime.now());

    if (clinicId.isNotEmpty) {
      context.read<StaffCubit>().createStaff(widget.staff, context);
    }
  }

  void _showTimeSlotModal(int appointmentIndex) {
    showModalBottomSheet(
      context: context,
      builder: (context) => StatefulBuilder(builder: (context, setModalState) {
        return Container(
          padding: const EdgeInsets.all(16),
          width: MediaQuery.of(context).size.width,
          constraints:
              BoxConstraints(minHeight: MediaQuery.of(context).size.height / 2),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16), topRight: Radius.circular(16)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildModalHeader(appointmentIndex, setModalState),
              const SizedBox(height: 8),
              _buildModalGrid(),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildModalHeader(int appointmentIndex, StateSetter setModalState) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 20),
          onPressed: () {
            if (timeSlotTitle > 0) {
              setModalState(() {
                timeSlotTitle--;
                timeSlots = _generateTimeSlots(appointmentIndex, timeSlotTitle);
              });
            }
          },
        ),
        Text('Slot ${timeSlotTitle + 1}'),
        IconButton(
          icon: const Icon(Icons.arrow_forward_ios, size: 20),
          onPressed: () {
            final availableSlots = _getFilteredSlots(appointmentIndex);
            if (timeSlotTitle < availableSlots.length - 1) {
              setModalState(() {
                timeSlotTitle++;
                timeSlots = _generateTimeSlots(appointmentIndex, timeSlotTitle);
              });
            }
          },
        ),
      ],
    );
  }

  Widget _buildModalGrid() {
    return Expanded(
      child: GridView.builder(
        itemCount: timeSlots.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 5.0,
          crossAxisSpacing: 15,
          mainAxisSpacing: 12,
        ),
        itemBuilder: (context, index) => Container(
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xffE1E1E1)),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              timeSlots[index],
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
          ),
        ),
      ),
    );
  }

  List<TimeSlot> _getFilteredSlots(int index) {
    return appointmentSlots[index]
        .timeSlots
        .where((s) => s.start != null && s.finish != null)
        .toList();
  }

  List<String> _generateTimeSlots(int appointmentIndex, int timeSlotIndex) {
    final filtered = _getFilteredSlots(appointmentIndex);
    final duration = appointmentSlots[appointmentIndex].duration;

    if (filtered.isEmpty || duration.isEmpty) return [];

    final slot = filtered[timeSlotIndex];
    final interval = int.tryParse(duration) ?? 0;
    if (interval <= 0) return [];

    final startTimeText = slot.start?.format(context) ?? '';
    final endTimeText = slot.finish?.format(context) ?? '';

    DateTime parseTime(String text) {
      final time = text.split(' ')[0];
      int hour = int.parse(time.split(':')[0]);
      final min = int.parse(time.split(':')[1]);
      final isAm = text.toLowerCase().contains('am');

      if (isAm && hour == 12) hour = 0;
      if (!isAm && hour != 12) hour += 12;

      return DateTime(2024, 1, 1, hour, min);
    }

    DateTime current = parseTime(startTimeText);
    final end = parseTime(endTimeText);
    final List<String> result = [];

    while (current.isBefore(end)) {
      final next = current.add(Duration(minutes: interval));
      result.add(
          "${DateFormat('h:mm a').format(current)} - ${DateFormat('h:mm a').format(next)}");
      current = next;
    }
    return result;
  }
}
