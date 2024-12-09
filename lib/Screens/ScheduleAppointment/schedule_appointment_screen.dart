import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healtether_clinic_app/Screens/AppointmentScreen/widgets/birtdate.dart';
import 'package:healtether_clinic_app/Screens/AppointmentScreen/widgets/custom_textfield.dart';
import 'package:healtether_clinic_app/Screens/AppointmentScreen/widgets/gender_dropdown.dart';
import 'package:healtether_clinic_app/Screens/ScheduleAppointment/timeslot_gridview.dart';
import 'package:healtether_clinic_app/constants/constants.dart';
import 'package:healtether_clinic_app/data_layer/models/patient/patient_model_id.dart';
import 'package:healtether_clinic_app/data_layer/models/patient_records_model/patient_model.dart';
import 'package:healtether_clinic_app/data_layer/services/patients_service/patient_service.dart';
import 'package:healtether_clinic_app/utils/enums/bloc_enums.dart';
import 'package:healtether_clinic_app/utils/enums/route_enums.dart';
import 'package:healtether_clinic_app/utils/snackbar.dart';
import '../../business_logic/cubits/appointment_cubit/appointment_cubit.dart';
import '../../data_layer/models/appointment_models/appointment_model.dart';
import '../../data_layer/services/appointment_service/appointment_service.dart';
import 'doctor_dropDown.dart';
import 'package:flutter/services.dart';

class ScheduleAppointmentScreen extends StatefulWidget {
  const ScheduleAppointmentScreen({super.key});

  @override
  State<ScheduleAppointmentScreen> createState() => _ScheduleAppointmentScreenState();
}

class _ScheduleAppointmentScreenState extends State<ScheduleAppointmentScreen> {
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController appointmentBriefController = TextEditingController();
  DateTime? _appointmentDate;
  DateTime? _dob;
  String? genderText;
  List<PatientOverviewModel> allPatients = [];
  List<PatientOverviewModel> duplicatePatients = [];
  PatientOverviewModel? selectedPatientOption;
  List<Map<String, dynamic>>? doctors;
  Map? selectedDoctor;
  String? _selectedTimeSlot;
  bool showDuplicateNumberMessage = false;
  //bool showInvalidNumberMessage = false;
  bool isVirtual = false;

  //List<String> existingNumbers = [];
  // List<String> patientNames = ["Patient A", "Jane Doe", "Add New Patient"];

  fetchDoctorsWithTimeSlots() async {
    doctors = await AppointmentServices().fetchDoctorsWithTimeSlots();
    setState(() {});
  }

  fetchPatients() async {
    final result = await PatientService().fetchPatients();
    allPatients = result.data!;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    // _timeSlots = generateTimeSlots();
    // mobileNumberController.addListener(_handleMobileNumberChange);
    //firstNameController.addListener(_updateButtonColors);
    //mobileNumberController.addListener(_updateButtonColors);
    //ageController.addListener(_updateButtonColors);
    //appointmentBriefController.addListener(_updateButtonColors);
    //fetchExistingNumbers();
    fetchDoctorsWithTimeSlots();
    fetchPatients();
  }

  @override
  void dispose() {
    //mobileNumberController.removeListener(_handleMobileNumberChange);
    // mobileNumberController.removeListener(_updateButtonColors);
    //firstNameController.removeListener(_updateButtonColors);
    //ageController.removeListener(_updateButtonColors);
    //appointmentBriefController.removeListener(_updateButtonColors);
    mobileNumberController.dispose();
    firstNameController.dispose();
    ageController.dispose();
    appointmentBriefController.dispose();
    super.dispose();
  }

  /*Future<void> saveMobileNumber(String number) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> numbers = prefs.getStringList('mobileNumbers') ?? [];
    if (!numbers.contains(number)) {
      numbers.add(number);
      await prefs.setStringList('mobileNumbers', numbers);
    } else {
      print("Number already exists: $number");
    }
  }*/

  /*Future<List<String>> getMobileNumbers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('mobileNumbers') ?? [];
  }*/

  /*void fetchExistingNumbers() async {
    List<String> numbers = await getMobileNumbers();
    setState(() {
      existingNumbers = numbers;
    });
  }*/

  /*void _handleMobileNumberChange() {
    if (mobileNumberController.text.length > 10) {
      mobileNumberController.text =
          mobileNumberController.text.substring(0, 10);
    }
  }*/

  /* List<String> generateTimeSlots() {
    List<String> timeSlots = ['Select Time Slot'];
    DateTime startTime = DateTime(2021, 1, 1, 9, 0); // Example start time
    DateTime endTime = DateTime(2021, 1, 1, 18, 0); // Example end time

    while (startTime.isBefore(endTime)) {
      DateTime nextTime = startTime.add(const Duration(minutes: 15));
      timeSlots.add(
          "${DateFormat('h:mm a').format(startTime)} - ${DateFormat('h:mm a').format(nextTime)}");
      startTime = nextTime;
    }
    return timeSlots;
  }*/

  int calculateAge(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    if (currentDate.month < birthDate.month || (currentDate.month == birthDate.month && currentDate.day < birthDate.day)) {
      age--;
    }
    return age;
  }

  void _pickDOB() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null && pickedDate != _dob) {
      setState(() {
        _dob = pickedDate;
        int age = calculateAge(pickedDate);
        ageController.text = age.toString();
      });
    }
  }

  void _pickAppointmentDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year, 12, 31),
    );

    if (pickedDate != null && pickedDate != _appointmentDate) {
      setState(() {
        _appointmentDate = pickedDate;
      });
    }
  }

  bool _isDuplicateNumber(String number) {
    //return existingNumbers.contains(number);
    return allPatients.any((element) => element.mobile == number);
  }

  void _checkDuplicateNumber() {
    String number = mobileNumberController.text;
    if (number.isNotEmpty) {
      if (_isDuplicateNumber(number)) {
        setState(() {
          duplicatePatients = allPatients.where((element) => element.mobile == number).toList();
          showDuplicateNumberMessage = true;
          // showInvalidNumberMessage = false;
        });
      } else {
        setState(() {
          selectedPatientOption = null;
          firstNameController.text = '';
          ageController.text = '';
          _dob = null;
          genderText = null;
          showDuplicateNumberMessage = false;
          //showInvalidNumberMessage = false;
        });
      }
    }
  }

  bool _isFormComplete() {
    bool isComplete = mobileNumberController.text.isNotEmpty &&
        firstNameController.text.isNotEmpty &&
        ageController.text.isNotEmpty &&
        genderText != null &&
        _dob != null &&
        mobileNumberController.text.length == 10 &&
        selectedDoctor != null &&
        _appointmentDate != null &&
        (_selectedTimeSlot != null && _selectedTimeSlot!.isNotEmpty);
    print("Is form complete: $isComplete");
    return isComplete;
  }

  /* void _updateButtonColors() {
    setState(() {});
  }*/

  void _submitForm() async {
    if (_isFormComplete()) {
      String? patientId = selectedPatientOption?.id;
      Map map = {
        'mobile': mobileNumberController.text,
        'name': firstNameController.text,
        'gender': genderText,
        'age': ageController.text,
        'birthDate':
            '${_dob!.year}-${_dob!.month.toString().length < 2 ? '0${_dob!.month}' : _dob!.month}-${_dob!.day.toString().length < 2 ? '0${_dob!.day}' : _dob!.day}',
        'appointmentDate':
            '${_appointmentDate!.year}-${_appointmentDate!.month.toString().length < 2 ? '0${_appointmentDate!.month}' : _appointmentDate!.month}-${_appointmentDate!.day.toString().length < 2 ? '0${_appointmentDate!.day}' : _appointmentDate!.day}',
        'timeSlot': _selectedTimeSlot,
        'reason': appointmentBriefController.text,
        'virtualConsultation': '$isVirtual',
        'patientId': (patientId == null || patientId == '-1') //New patient with new number or New patient on Existing number
            ? ''
            : selectedPatientOption?.id, //Existing patient with Existing number
        'doctorId': selectedDoctor!['_id'],
        'doctorName': '${selectedDoctor!['firstName']} ${selectedDoctor!['lastName']}',
        'clinicPatientId': (patientId == null || patientId == '-1') //New patient with new number or New patient on Existing number
            ? ''
            : selectedPatientOption?.patientId //Existing patient with Existing number
      };
      AppointmentCubit appointmentCubit = BlocProvider.of<AppointmentCubit>(context);

      await appointmentCubit.createAppointment(map);
      if (appointmentCubit.state.state == AppointmentStates.appointmentsCreated) {
        String appointmentId = appointmentCubit.state.id!;
        await appointmentCubit.getAppointmentById(id: appointmentId);
        if (appointmentCubit.state.state == AppointmentStates.appointmentByIdFetched) {
          Appointment appointmentDetails = appointmentCubit.state.appointmentDetails!;
          mobileNumberController.text = '';
          firstNameController.text = '';
          ageController.text = '';
          appointmentBriefController.text = '';
          genderText = null;
          _dob = null;
          _appointmentDate = null;
          selectedDoctor = null;
          _selectedTimeSlot = null;
          isVirtual = false;
          appointmentCubit.fetchAppointments(status: 'Upcoming');
          context.pushNamed(AppRoutes.appointmentSuccess.name, extra: appointmentDetails);
        } else if (appointmentCubit.state.state == AppointmentStates.fetchingAppointmentByIdFailed) {
          showSnackbar('An error occured while scheduling appointment', context);
        }
      } else if (appointmentCubit.state.state == AppointmentStates.creatingAppointmentsFailed) {
        showSnackbar('Error scheduling appointment', context);
      }
    }
  }

  /*String formatDate(DateTime? date) {
    if (date == null) return 'Birthdate';
    return DateFormat('yyyy-MM-dd').format(date);
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 30,
        title: const Text(
          AppText.addAppointment,
          style: TextStyle(fontSize: 20),
        ),
        leading: IconButton(
          onPressed: context.pop,
          icon: const Icon(Icons.arrow_back),
        ),
        automaticallyImplyLeading: false,
        /*actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.calendar_today_outlined),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications),
          )
        ],*/
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomTextField(
                height: 52,
                controller: mobileNumberController,
                hintText: AppText.mobileNo,
                keyBoardType: TextInputType.phone,
                inputFormatters: [LengthLimitingTextInputFormatter(10), FilteringTextInputFormatter.digitsOnly],
                onChanged: (value) {
                  _checkDuplicateNumber();
                },
              ),
              if (showDuplicateNumberMessage)
                Container(
                  height: 150,
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  padding: const EdgeInsets.only(bottom: 2),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: const Offset(0, 1),
                        ),
                      ],
                      borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8))),
                  child: ListView.builder(
                    itemCount: duplicatePatients.length + 1,
                    itemBuilder: (context, index) {
                      PatientOverviewModel item = PatientOverviewModel();
                      if (index < duplicatePatients.length) {
                        item = duplicatePatients[index];
                      } else {
                        item = PatientOverviewModel(id: '-1', firstName: 'Add New Patient', lastName: '');
                      }
                      return GestureDetector(
                        onTap: () async {
                          if (index < duplicatePatients.length) {
                            selectedPatientOption = duplicatePatients[index];
                            PatientByIdModel patientDetails = await PatientService().getPatientById(selectedPatientOption!.id!);
                            firstNameController.text = '${patientDetails.firstName} ${patientDetails.lastName}';
                            ageController.text = '${patientDetails.age}';
                            _dob = patientDetails.birthday;
                            genderText = patientDetails.gender;
                            showDuplicateNumberMessage = false;
                            setState(() {});
                          } else {
                            setState(() {
                              selectedPatientOption = PatientOverviewModel(id: '-1', firstName: 'Add New Patient', lastName: '');
                              showDuplicateNumberMessage = false;
                            });
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: (selectedPatientOption?.id ?? '0') == item.id ? Colors.grey.withOpacity(0.2) : Colors.white,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${item.firstName} ${item.lastName}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                ),
                              ),
                              if ((selectedPatientOption?.id ?? '0') == item.id)
                                const Icon(
                                  Icons.check,
                                  color: Colors.green,
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              const SizedBox(height: 12),
              Text(
                AppText.personalDetails,
                style: GoogleFonts.urbanist(
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    color: Color(0xff605C72),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              CustomTextField(
                height: 52,
                controller: firstNameController,
                hintText: AppText.name,
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: BirthDate(
                      selectedDate: _dob,
                      onTap: _pickDOB,
                      width: 0.45,
                      text: AppText.birthDate,
                      showIcon: true,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: CustomTextField(
                    height: 52,
                    controller: ageController,
                    hintText: AppText.age,
                    readOnly: true,
                    width: MediaQuery.of(context).size.width * 0.45,
                  )),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: GenderContainer(
                      value: genderText,
                      onChanged: (String? newValue) {
                        setState(() {
                          genderText = newValue;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Checkbox.adaptive(
                      value: isVirtual,
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            isVirtual = value;
                          });
                        }
                      }),
                  // const SizedBox(width: 18),
                  Text(
                    'Virtual Consultation',
                    style: GoogleFonts.roboto(
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              Text(
                'Appointment Details',
                style: GoogleFonts.urbanist(
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    color: Color(0xff605C72),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: DoctorDropDown(
                      doctors: doctors,
                      value: selectedDoctor,
                      onChanged: (Map? newValue) {
                        setState(() {
                          selectedDoctor = newValue;
                          log(selectedDoctor.toString());
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              //Appointment date
              BirthDate(
                selectedDate: _appointmentDate,
                onTap: _pickAppointmentDate,
                width: 2.45,
                text: 'Select date',
                showIcon: false,
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: /*selectedDoctor == null || _appointmentDate == null
                        ? TimeSlotDropDown(
                            value: _selectedTimeSlot,
                            appointmentDate: _appointmentDate,
                            availableTimeSlots: selectedDoctor != null
                                ? List<Map<String, dynamic>>.from(
                                    selectedDoctor!['availableTimeSlot'])
                                : null,
                            onChanged: (String? newValue) {
                              setState(() {
                          _selectedTimeSlot = newValue;
                        });
                            },
                          )
                        :*/
                        InkWell(
                            onTap: () async {
                              if (selectedDoctor != null && _appointmentDate != null) {
                                await showModalBottomSheet(
                                    context: context,
                                    builder: (ctx) => TimeSlotGridView(
                                        availableTimeSlots: List<Map<String, dynamic>>.from(selectedDoctor!['availableTimeSlot']),
                                        appointmentDate: _appointmentDate,
                                        onSelected: (timeSlot) {
                                          setState(() {
                                            _selectedTimeSlot = timeSlot;
                                            log(_selectedTimeSlot!);
                                          });
                                        }));
                              }
                            },
                            child: Container(
                              height: 52,
                              color: const Color(0xffF5F5F5),
                              width: double.infinity,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      _selectedTimeSlot ?? "Select Time Slot",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: _selectedTimeSlot == null ? Colors.grey : Colors.black,
                                      ),
                                    ),
                                    const Icon(Icons.keyboard_arrow_down_outlined)
                                  ],
                                ),
                              ),
                            )),
                  ),
                ],
              ),

              const SizedBox(height: 10),
              CustomTextField(
                height: 52,
                controller: appointmentBriefController,
                hintText: 'Appointment Brief',
              ),
              const Text(
                'This field is optional.',
                style: TextStyle(fontSize: 11, color: Colors.grey),
              ),
              const SizedBox(height: 16),
              BlocBuilder<AppointmentCubit, AppointmentState>(builder: (context, data) {
                return data.state == AppointmentStates.creatingAppointments || data.state == AppointmentStates.fetchingAppointmentById
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Color(0xff03BF9C),
                        ),
                      )
                    : Container(
                        height: 58,
                        margin: const EdgeInsets.only(left: 24, right: 24),
                        decoration: BoxDecoration(
                          color: _isFormComplete() ? const Color(0xFF32856E) : const Color(0xFFF7F7F7),
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: Center(
                          child: TextButton(
                            onPressed: _isFormComplete() ? _submitForm : null,
                            child: Text(
                              'Schedule Appointment',
                              style: TextStyle(
                                color: _isFormComplete() ? const Color(0xFFFFFFFF) : const Color(0xFF9E9E9E),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      );
              }),

              // Container(
              //   width: 335,
              //   height: 62,
              //   padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              //   decoration: BoxDecoration(
              //     color: _isFormComplete() ? const Color(0xFF32856E) : const Color(0xFFF5F5F5),
              //     borderRadius: BorderRadius.circular(7),
              //   ),
              //   child: Center(
              //     child: TextButton(
              //       onPressed: _isFormComplete()
              //           ? () {
              //         Navigator.push(context, MaterialPageRoute(builder: (context) {
              //           return const ScheduleSuccessfullyScreen();
              //         }));
              //       }
              //           : null,
              //       child: Text(
              //         AppText.scheduleNow,
              //         style: GoogleFonts.montserrat(
              //           fontSize: 12,
              //           fontWeight: FontWeight.w600,
              //           color: _isFormComplete() ? Colors.white : const Color(0xFFC2C2C2),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),

              // const SizedBox(height: 16),
              // GestureDetector(
              //   onTap: _isFormComplete()
              //       ? () {
              //     Navigator.push(context, MaterialPageRoute(builder: (context) {
              //       return const DocAppointmentScreen();
              //     }));
              //   }
              //       : null,
              //   child: Container(
              //     width: 335,
              //     height: 62,
              //     padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              //     decoration: BoxDecoration(
              //       color: const Color(0xFFF5F5F5),
              //       borderRadius: BorderRadius.circular(7),
              //     ),
              //     child: Center(
              //       child: Text(
              //         AppText.scheduleForLater,
              //         style: GoogleFonts.montserrat(
              //           fontSize: 12,
              //           fontWeight: FontWeight.w600,
              //           color: _isFormComplete() ? Colors.black : const Color(0xFFC2C2C2),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
