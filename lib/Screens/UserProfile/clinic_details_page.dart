import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healtether_clinic_app/constants/constants.dart';
import 'package:healtether_clinic_app/data_layer/models/user_model/user_model.dart';
import 'package:healtether_clinic_app/utils/mixins/app_bar_mixin.dart';
import 'package:image_picker/image_picker.dart';

class ClinicDetails extends StatefulWidget {
  final Map? selectedClinic;
  const ClinicDetails({super.key, this.selectedClinic});

  @override
  State<ClinicDetails> createState() => _ClinicDetailsState();
}

class _ClinicDetailsState extends State<ClinicDetails> with AppBarMixin {
  TextEditingController text1 = TextEditingController();

  TextEditingController text2 = TextEditingController();

  TextEditingController text3 = TextEditingController();

  TextEditingController text4 = TextEditingController();
  File? _image;
  UserModel? userModel;
  void getCurrentUser() async {
    var data = await UserModel.getCurrentUser();
    userModel = data;
    text2 = TextEditingController(text: '${userModel?.firstName ?? ''} ${userModel?.lastName ?? ''}');
    text3 = TextEditingController(text: '');
    text4 = TextEditingController(text: userModel?.email ?? '');
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
    if (widget.selectedClinic != null) {
      text1 = TextEditingController(text: widget.selectedClinic!['clinicName']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, title: "Clinic Settings", automaticallyImplyLeading: true, showDefaultActions: false),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Text(
                    'ADD NEW CLINIC',
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                      right: 83.0,
                    ),
                    child: SizedBox(
                      height: 5,
                      width: 54,
                      child: Divider(
                        thickness: 2,
                        color: Color(0xff52CFAC),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      //Describe the logic for image picker
                    },
                    child: CircleAvatar(
                      radius: 56,
                      backgroundColor: const Color(0xffF1E7F9),
                      backgroundImage: _image != null ? FileImage(_image!) : null,
                      child: _image == null
                          ? IconButton(
                              onPressed: () {
                                _getImage();
                              },
                              icon: const Icon(Icons.camera_alt, size: 30),
                            )
                          : null,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Clinic logo',
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        'Click on the camera to add',
                        style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, fontSize: 13, color: Colors.grey),
                      ),
                      Text(
                        'Clinic logo',
                        style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, fontSize: 13, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Clinic name*',
                style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.lightGrey8),
              ),
              const SizedBox(height: 6),
              Container(
                height: 52,
                decoration: BoxDecoration(
                  color: const Color(0xffEEEEEE),
                  borderRadius: BorderRadius.circular(3),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 5.0, left: 10),
                  child: TextField(
                    controller: text1,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Clinic name',
                      hintStyle: GoogleFonts.poppins(fontWeight: FontWeight.w400, fontSize: 15, color: Colors.grey),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                'Admin name*',
                style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.lightGrey8),
              ),
              const SizedBox(height: 6),
              Container(
                height: 52,
                decoration: BoxDecoration(
                  color: const Color(0xffEEEEEE),
                  borderRadius: BorderRadius.circular(3),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 5.0, left: 10),
                  child: TextField(
                    controller: text2,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Admin name',
                      hintStyle: GoogleFonts.poppins(fontWeight: FontWeight.w400, fontSize: 15, color: Colors.grey),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                'Mobile no.*',
                style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.lightGrey8),
              ),
              const SizedBox(height: 6),
              Container(
                height: 52,
                decoration: BoxDecoration(
                  color: const Color(0xffEEEEEE),
                  borderRadius: BorderRadius.circular(3),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 5.0, left: 10),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: text3,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Mobile no',
                      hintStyle: GoogleFonts.poppins(fontWeight: FontWeight.w400, fontSize: 15, color: Colors.grey),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                'Clinic\'s email*',
                style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.lightGrey8),
              ),
              const SizedBox(height: 6),
              Container(
                height: 52,
                decoration: BoxDecoration(
                  color: const Color(0xffEEEEEE),
                  borderRadius: BorderRadius.circular(3),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 5.0, left: 10),
                  child: TextField(
                    controller: text4,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Clinic's Email",
                      hintStyle: GoogleFonts.poppins(fontWeight: FontWeight.w400, fontSize: 15, color: Colors.grey),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                'Patient ID Text*',
                style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.lightGrey8),
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 52,
                      decoration: const BoxDecoration(
                        color: Color(0xffEEEEEE),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 15, bottom: 10, left: 14, right: 30),
                        child: TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Prefix',
                            hintStyle: GoogleFonts.montserrat(
                              color: Colors.grey,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  const Text(
                    '-',
                    style: TextStyle(
                      fontSize: 34,
                    ),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Expanded(
                    child: Container(
                      height: 52,
                      decoration: const BoxDecoration(
                        color: Color(0xffEEEEEE),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 15, bottom: 10, left: 14, right: 30),
                        child: TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Suffix',
                            hintStyle: GoogleFonts.montserrat(
                              color: Colors.grey,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 70,
              ),
              GestureDetector(
                onTap: () {
                  if (text1.text.isEmpty && text2.text.isEmpty && text3.text.isEmpty && text4.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please fill in all the details')),
                    );
                  }
                },
                child: Center(
                  child: Container(
                    height: 52,
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: text1.text.isEmpty && text2.text.isEmpty && text3.text.isEmpty && text4.text.isEmpty
                          ? const Color(0xffF8F7FC)
                          : const Color(0xff32856E),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Center(
                      child: Text(
                        'Save',
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w500,
                          color: text1.text.isEmpty && text2.text.isEmpty && text3.text.isEmpty && text4.text.isEmpty ? Colors.grey : Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _getImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (image != null) {
        _image = File(image.path);
      } else {
        print('No image selected.');
      }
    });
  }
}
