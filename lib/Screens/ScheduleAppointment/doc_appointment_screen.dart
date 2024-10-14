/*import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healtether_clinic_app/Screens/ScheduleAppointment/schedule_successfully_screen.dart';
import 'package:healtether_clinic_app/constants/constants.dart';
import 'package:healtether_clinic_app/constants/app_text.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class DocAppointmentScreen extends StatefulWidget {
  const DocAppointmentScreen({Key? key}) : super(key: key);

  @override
  State<DocAppointmentScreen> createState() => _DocAppointmentScreenState();
}

class _DocAppointmentScreenState extends State<DocAppointmentScreen> {
  final _formKey = GlobalKey<FormState>();
  int currentPageIndex = 0;
  final PageController pageController = PageController(initialPage: 0);

  final _nameController = TextEditingController();
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() {
        _dateController.text = "${pickedDate.toLocal()}".split(' ')[0];
        _updateButtonColor();
      });
    }
  }

  Future<void> _pickTime() async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      setState(() {
        _timeController.text = pickedTime.format(context);
        _updateButtonColor();
      });
    }
  }

  void _updateButtonColor() {
    setState(() {});
  }

  bool _isFormValid() {
    return _dateController.text.isNotEmpty &&
        _timeController.text.isNotEmpty &&
        _nameController.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppText.addAppointment),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        automaticallyImplyLeading: false,
        actions: [
          if (currentPageIndex > 1)
            TextButton(
              onPressed: () {},
              child: const Text(
                AppText.skip,
                style: TextStyle(color: Color(0XFF4646B5)),
              ),
            ),
          if (currentPageIndex > 1)
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.more_vert),
            ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SmoothPageIndicator(
                  controller: pageController,
                  count: 4,
                  effect: const ExpandingDotsEffect(
                      expansionFactor: 5,
                      dotColor: Color(0XFF5351C7),
                      strokeWidth: 3,
                      dotHeight: 8,
                      dotWidth: 8,
                      paintStyle: PaintingStyle.fill),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                AppText.appointmentDetails,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: _pickDate,
                child: Container(
                  width: 358,
                  height: 52,
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8F7FC),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          _dateController.text.isEmpty
                              ? 'Select date'
                              : _dateController.text,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            height: 1.25,
                            letterSpacing: 0.16,
                            color: Color(0xFF908D9E),
                          ),
                        ),
                      ),
                      const Icon(
                        Icons.keyboard_arrow_down_rounded,
                        size: 28,
                        color: AppColors.blackColor,
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: _pickTime,
                child: Container(
                  width: 358,
                  height: 52,
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8F7FC),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          _timeController.text.isEmpty
                              ? 'Select time slot'
                              : _timeController.text,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            height: 1.25,
                            letterSpacing: 0.16,
                            color: Color(0xFF908D9E),
                          ),
                        ),
                      ),
                      const Icon(
                        Icons.keyboard_arrow_down_rounded,
                        size: 28,
                        color: AppColors.blackColor,
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  width: 358,
                  height: 52,
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8F7FC),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          _timeController.text.isEmpty
                              ? 'Attending doctor'
                              : _timeController.text,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            height: 1.25,
                            letterSpacing: 0.16,
                            color: Color(0xFF908D9E),
                          ),
                        ),
                      ),
                      const Icon(
                        Icons.keyboard_arrow_down_rounded,
                        size: 28,
                        color: AppColors.blackColor,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: 358,
                height: 52,
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8F7FC),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: TextField(
                    controller: _nameController,
                    onChanged: (_) => _updateButtonColor(),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Appointment reason',
                      hintStyle: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        height: 1.25,
                        letterSpacing: 0.16,
                        color: Color(0xFF908D9E),
                      ),
                    ),
                  ),
                ),
              ),
              const Text(
                "This field is optional.",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  height: 1.2,
                  letterSpacing: 0.02,
                  color: Color(0xFF908D9E),
                ),
              ),
              const SizedBox(height: 200),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: GestureDetector(
                  onTap: () {
                    if (_isFormValid()) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const ScheduleSuccessfullyScreen();
                      }));
                    }
                  },
                  child: Container(
                    width: 280,
                    height: 60,
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 16),
                    decoration: BoxDecoration(
                      color: _isFormValid()
                          ? const Color(0xFF32856E)
                          : const Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: Center(
                      child: Text(
                        AppText.scheduleAppointment,
                        style: GoogleFonts.montserrat(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: _isFormValid()
                              ? Colors.white
                              : const Color(0xFFC2C2C2),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}*/
