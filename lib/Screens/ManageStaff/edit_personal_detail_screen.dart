import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healtether_clinic_app/Screens/AppointmentScreen/widgets/birtdate.dart';
import 'package:healtether_clinic_app/Screens/AppointmentScreen/widgets/custom_textfield.dart';
import 'package:healtether_clinic_app/Screens/AppointmentScreen/widgets/gender_dropdown.dart';
import 'package:healtether_clinic_app/Screens/ManageStaff/title_dropdown.dart';
import 'package:healtether_clinic_app/constants/constants.dart';
import 'package:image_picker/image_picker.dart';

import 'edit_contact_detail_screen.dart';

class EditPersonalDetailScreen extends StatefulWidget {
  final PageController? pageController;

  const EditPersonalDetailScreen({super.key, this.pageController});

  @override
  State<EditPersonalDetailScreen> createState() =>
      _EditPersonalDetailScreenState();
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
  String? titleText;
  File? _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
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
                    Stack(
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.grey[300],
                              backgroundImage:
                                  _image != null ? FileImage(_image!) : null,
                              child: _image == null
                                  ? IconButton(
                                      onPressed: () {
                                        _getImage();
                                      },
                                      icon:
                                          const Icon(Icons.camera_alt_outlined),
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
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      controller: positionController,
                      hintText: AppText.position,
                      height: 52,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: TitleDropDown(
                            value: titleText,
                            onChanged: (String? newValue) {
                              setState(() {
                                titleText = newValue;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      controller: firstNameController,
                      hintText: AppText.firstName,
                      height: 52,
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      controller: lastNameController,
                      hintText: AppText.lastName,
                      height: 52,
                    ),
                    const SizedBox(height: 10),
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
                        CustomTextField(
                          controller: ageController,
                          hintText: AppText.age,
                          height: 52,
                          width: MediaQuery.of(context).size.width * 0.45,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
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
                    const SizedBox(height: 70),
                  ],
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const EditContactDetailScreen();
              }));
            },
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 36, right: 36, bottom: 8, top: 5),
              child: Container(
                height: 60,
                width: 326,
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
          ),
        ],
      ),
    );
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
              primary: Color(0xff32856E),
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
    if (currentDate.month < birthDate.month ||
        (currentDate.month == birthDate.month &&
            currentDate.day < birthDate.day)) {
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
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (image != null) {
        _image = File(image.path);
      } else {
        if (kDebugMode) {
          print('No image selected.');
        }
      }
    });
  }
}
