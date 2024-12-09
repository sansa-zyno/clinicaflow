// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healtether_clinic_app/Screens/Members/EditScreens/edit_contact_detail_screen.dart';
import 'package:healtether_clinic_app/data_layer/models/patient/patient_model_id.dart';
import 'package:healtether_clinic_app/data_layer/models/staff_model/staff_detail_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:healtether_clinic_app/Screens/AppointmentScreen/widgets/birtdate.dart';
import 'package:healtether_clinic_app/Screens/AppointmentScreen/widgets/custom_textfield.dart';
import 'package:healtether_clinic_app/Screens/AppointmentScreen/widgets/gender_dropdown.dart';
import 'package:healtether_clinic_app/data_layer/models/staff_model/create_staff_model.dart';
import 'package:healtether_clinic_app/constants/constants.dart';

import '../../../data_layer/models/patient_records_model/post/patient_create_model.dart';

class EditPersonalDetailScreen extends StatefulWidget {
  final bool isAdmin;
  final bool forStaff;
  final StaffByIdModel? staffByIdModel;
  final PatientByIdModel? patientByIdModel;
  final PageController? pageController;

  const EditPersonalDetailScreen({
    super.key,
    required this.isAdmin,
    required this.forStaff,
    this.pageController,
    this.staffByIdModel,
    this.patientByIdModel,
  });

  @override
  State<EditPersonalDetailScreen> createState() => _EditPersonalDetailScreenState();
}

class _EditPersonalDetailScreenState extends State<EditPersonalDetailScreen> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController positionController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController reasonController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  DateTime? _selectedDate;
  DateTime? _dob;
  String? genderText;
  String? timeSlotText;
  //String? titleText;
  File? _image;

  bool _isFormComplete() {
    if (widget.forStaff) {
      bool isComplete = _image != null &&
          positionController.text.isNotEmpty &&
          _dob != null &&
          (ageController.text.isNotEmpty && (int.parse(ageController.text) > 10)) &&
          genderText != null &&
          firstNameController.text.isNotEmpty &&
          lastNameController.text.isNotEmpty;
      print("Is form complete: $isComplete");
      return isComplete;
    } else {
      bool isComplete = _dob != null &&
          (ageController.text.isNotEmpty && (int.parse(ageController.text) > 0)) &&
          genderText != null &&
          firstNameController.text.isNotEmpty &&
          lastNameController.text.isNotEmpty;
      print("Is form complete: $isComplete");
      return isComplete;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.forStaff) {
      //_image = null;
      positionController.text = widget.staffByIdModel!.specialization;
      firstNameController.text = widget.staffByIdModel!.firstName;
      lastNameController.text = widget.staffByIdModel!.lastName;
      _dob = widget.staffByIdModel!.birthday;
      ageController.text = widget.staffByIdModel!.age.toString();
      genderText = widget.staffByIdModel!.gender != "" ? widget.staffByIdModel!.gender : null;
      if (<String>['Gender', 'Male', 'Female', 'Others'].contains(genderText)) {
        genderText = genderText;
      } else {
        genderText = null;
      }
    } else {
      firstNameController.text = widget.patientByIdModel!.firstName;
      lastNameController.text = widget.patientByIdModel!.lastName;
      _dob = widget.patientByIdModel!.birthday;
      ageController.text = widget.patientByIdModel!.age.toString();
      genderText = widget.patientByIdModel!.gender != "" ? widget.patientByIdModel!.gender : null;
      if (<String>['Gender', 'Male', 'Female', 'Others'].contains(genderText)) {
        genderText = genderText;
      } else {
        genderText = null;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      AppText.personalDetails,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    widget.forStaff
                        ? Stack(
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 50,
                                    backgroundColor: Colors.grey[300],
                                    backgroundImage: _image != null ? FileImage(_image!) : null,
                                    child: _image == null
                                        ? IconButton(
                                            onPressed: () {
                                              _getImage();
                                            },
                                            icon: const Icon(Icons.camera_alt_outlined),
                                          )
                                        : null,
                                  ),
                                  const SizedBox(width: 10),
                                  const Expanded(
                                    child: Text(
                                      'Click on the Profile photo to change it.',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 16,
                                        height: 18.07 / 13,
                                        letterSpacing: 0.5 / 100 * 13,
                                        color: Color(0xFF8E8E8E),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                        : Container(),
                    const SizedBox(height: 6),
                    widget.forStaff
                        ? CustomTextField(
                            controller: positionController,
                            hintText: AppText.position,
                            height: 52,
                          )
                        : Container(),
                    const SizedBox(height: 6),
                    CustomTextField(
                      controller: firstNameController,
                      hintText: AppText.firstName,
                      height: 52,
                    ),
                    const SizedBox(height: 6),
                    CustomTextField(
                      controller: lastNameController,
                      hintText: AppText.lastName,
                      height: 52,
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Expanded(
                          child: BirthDateContainer(
                            selectedDate: _dob,
                            onTap: _pickDOB,
                            width: 0.45,
                            text: AppText.birthDate,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: CustomTextField(
                            controller: ageController,
                            hintText: AppText.age,
                            height: 52,
                            width: MediaQuery.of(context).size.width * 0.45,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: GenderDropDown(
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
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 80,
          ),
          GestureDetector(
            onTap: _isFormComplete()
                ? () {
                    if (widget.forStaff) {
                      if (firstNameController.text.isNotEmpty && lastNameController.text.isNotEmpty) {
                        CreateStaff createStaff = CreateStaff(
                          profilepic: _image?.path ?? '',
                          firstName: firstNameController.text,
                          lastName: lastNameController.text,
                          specialisation: positionController.text,
                          age: ageController.text,
                          birthday: '${_dob!.year}-${_dob!.month.toString().padLeft(2, "0")}-${_dob!.day.toString().padLeft(2, "0")}',
                          gender: genderText,
                          isDoctor: widget.isAdmin,
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            // return const EditContactDetailScreen();
                            return EditContactDetailScreen(
                              isForStaff: true,
                              createStaff: createStaff,
                              staffByIdModel: widget.staffByIdModel,
                            );
                          }),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Please Fill All Value.')),
                        );
                      }
                    } else {
                      //patient
                      PatientCreate patientCreate = PatientCreate(
                        firstName: firstNameController.text,
                        lastName: lastNameController.text,
                        birthday: '${_dob!.year}-${_dob!.month.toString().padLeft(2, "0")}-${_dob!.day.toString().padLeft(2, "0")}',
                        age: ageController.text,
                        gender: genderText,
                      );
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          // return const EditContactDetailScreen();
                          return EditContactDetailScreen(
                            isForStaff: false,
                            patientCreate: patientCreate,
                            patientByIdModel: widget.patientByIdModel,
                          );
                        }),
                      );
                    }
                  }
                : null,
            child: Container(
              height: 52,
              margin: const EdgeInsets.symmetric(horizontal: 30),
              decoration: BoxDecoration(
                color: _isFormComplete() ? AppColors.greenColor : const Color(0xFFFFFFFF),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  AppText.save,
                  style: GoogleFonts.montserrat(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: _isFormComplete() ? const Color(0xFFFFFFFF) : const Color(0xFF9E9E9E),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }

  void _pickDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xff32856E), // Your chosen color
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
  }

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

  Future<void> _getImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (image != null) {
        _image = File(image.path);
      } else {
        print('No image selected.');
      }
    });
  }
}

class PersonalDetailsStaffModel {
  final String specialisation;
  final String title;
  final String firstName;
  final String lastName;
  final String dob;
  final String age;
  final String gender;
  final String profilePic;

  PersonalDetailsStaffModel(
      {required this.specialisation,
      required this.title,
      required this.firstName,
      required this.lastName,
      required this.dob,
      required this.age,
      required this.gender,
      required this.profilePic});
}
