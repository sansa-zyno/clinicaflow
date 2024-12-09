import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healtether_clinic_app/Screens/AppointmentScreen/widgets/custom_textfield.dart';
import 'package:healtether_clinic_app/Screens/Members/EditScreens/edit_document_screen.dart';
import 'package:healtether_clinic_app/data_layer/models/patient/patient_model_id.dart' hide Address;
import 'package:healtether_clinic_app/data_layer/models/patient_records_model/post/patient_create_model.dart';
import 'package:healtether_clinic_app/data_layer/models/staff_model/address_staff_model.dart';
import 'package:healtether_clinic_app/data_layer/models/staff_model/create_staff_model.dart';
import 'package:healtether_clinic_app/constants/constants.dart';
import 'package:healtether_clinic_app/data_layer/models/staff_model/staff_detail_model.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../data_layer/models/patient_records_model/post/address_patient_model.dart';

class EditContactDetailScreen extends StatefulWidget {
  final CreateStaff? createStaff;
  final PatientCreate? patientCreate;
  final PageController? pageController;
  final bool isForStaff;
  final StaffByIdModel? staffByIdModel;
  final PatientByIdModel? patientByIdModel;

  const EditContactDetailScreen({
    Key? key,
    required this.isForStaff,
    this.pageController,
    this.createStaff,
    this.patientCreate,
    this.staffByIdModel,
    this.patientByIdModel,
  }) : super(key: key);

  @override
  State<EditContactDetailScreen> createState() => _EditContactDetailScreenState();
}

class _EditContactDetailScreenState extends State<EditContactDetailScreen> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController houseController = TextEditingController();
  TextEditingController landmarkController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController additionalPhoneController = TextEditingController();
  TextEditingController additionalEmailController = TextEditingController();
  bool showAdditionalPhone = false;
  bool showAdditionalEmail = false;
  final PageController pageController = PageController(initialPage: 1);

  bool _isFormComplete() {
    if (widget.isForStaff) {
      bool isComplete = phoneController.text.isNotEmpty && emailController.text.isNotEmpty;
      print("Is form complete: $isComplete");
      return isComplete;
    } else {
      bool isComplete = phoneController.text.isNotEmpty && emailController.text.isNotEmpty;
      print("Is form complete: $isComplete");
      return isComplete;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.isForStaff) {
      phoneController.text = widget.staffByIdModel!.mobile;
      emailController.text = widget.staffByIdModel!.email;
      areaController.text = widget.staffByIdModel!.address?.street ?? '';
      pincodeController.text = widget.staffByIdModel!.address?.pincode ?? '';
      houseController.text = widget.staffByIdModel!.address?.house ?? '';
      landmarkController.text = widget.staffByIdModel!.address?.landmarks ?? '';
      cityController.text = widget.staffByIdModel!.address?.city ?? '';
    } else {
      phoneController.text = widget.patientByIdModel!.mobile;
      emailController.text = widget.patientByIdModel!.email;
      areaController.text = widget.patientByIdModel!.address?.street ?? '';
      pincodeController.text = widget.patientByIdModel!.address?.pincode ?? '';
      houseController.text = widget.patientByIdModel!.address?.house ?? '';
      landmarkController.text = widget.patientByIdModel!.address?.landmarks ?? '';
      cityController.text = widget.patientByIdModel!.address?.city ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          leadingWidth: 30,
          title: const Text(AppText.editProfile),
        ),
        body: Column(children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SmoothPageIndicator(
                      controller: pageController,
                      count: widget.isForStaff ? 5 : 3,
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
                      AppText.contactDetails,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      controller: phoneController,
                      hintText: AppText.phone,
                      keyBoardType: TextInputType.phone,
                      inputFormatters: [LengthLimitingTextInputFormatter(10), FilteringTextInputFormatter.digitsOnly],
                      height: 45,
                    ),
                    const SizedBox(height: 10),
                    if (showAdditionalPhone) ...[
                      CustomTextField(
                        controller: additionalPhoneController,
                        hintText: AppText.additionalPhone,
                        keyBoardType: TextInputType.phone,
                        inputFormatters: [LengthLimitingTextInputFormatter(10), FilteringTextInputFormatter.digitsOnly],
                        height: 45,
                      ),
                    ],
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          showAdditionalPhone = true;
                        });
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Icon(Icons.add, color: AppColors.blueViolet),
                              Text(
                                AppText.addAnotherNumber,
                                style: TextStyle(color: AppColors.blueViolet),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Container(
                              height: 2,
                              width: screenSize.width * 0.5,
                              color: AppColors.blueViolet,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      controller: emailController,
                      hintText: AppText.email,
                      height: 45,
                    ),
                    const SizedBox(height: 7),
                    if (showAdditionalEmail) ...[
                      CustomTextField(
                        controller: additionalEmailController,
                        hintText: AppText.additionalEmail,
                        height: 45,
                      ),
                    ],
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          showAdditionalEmail = true;
                        });
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Icon(
                                Icons.add,
                                color: AppColors.blueViolet,
                              ),
                              Text(
                                AppText.addAnotherEmail,
                                style: TextStyle(color: AppColors.blueViolet),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Container(
                              height: 2,
                              width: screenSize.width * 0.5,
                              color: AppColors.blueViolet,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      AppText.address,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    CustomTextField(
                      controller: houseController,
                      hintText: AppText.houseNo,
                      height: 45,
                    ),
                    const SizedBox(height: 5),
                    CustomTextField(
                      controller: areaController,
                      hintText: AppText.area,
                      height: 45,
                    ),
                    const SizedBox(height: 5),
                    CustomTextField(
                      controller: landmarkController,
                      hintText: AppText.landmarks,
                      height: 45,
                    ),
                    const SizedBox(height: 5),
                    CustomTextField(
                      controller: cityController,
                      hintText: AppText.city,
                      height: 45,
                    ),
                    const SizedBox(height: 5),
                    CustomTextField(
                      controller: pincodeController,
                      keyBoardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(6)],
                      hintText: AppText.pincode,
                      height: 45,
                    ),
                    const SizedBox(height: 20),
                    //const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: 52,
            margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
            decoration: BoxDecoration(
              color: _isFormComplete() ? AppColors.greenColor : const Color(0xFFFFFFFF),
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextButton(
                onPressed: _isFormComplete()
                    ? () async {
                        if (widget.isForStaff) {
                          widget.createStaff!.mobile = phoneController.text;
                          widget.createStaff!.email = emailController.text;
                          widget.createStaff!.address = Address(
                            house: houseController.text,
                            street: areaController.text,
                            landmarks: landmarkController.text,
                            city: cityController.text,
                            pincode: pincodeController.text,
                          );
                          if (widget.createStaff!.mobile!.isNotEmpty && widget.createStaff!.email!.isNotEmpty) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                return EditDocumentScreen(
                                  forStaff: true,
                                  createStaff: widget.createStaff,
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
                          widget.patientCreate!.mobile = phoneController.text;
                          widget.patientCreate!.email = emailController.text;
                          widget.patientCreate!.address = AddressPatient(
                            house: houseController.text,
                            street: areaController.text,
                            landmarks: landmarkController.text,
                            city: cityController.text,
                            pincode: pincodeController.text,
                          );
                          if (widget.patientCreate!.mobile!.isNotEmpty && widget.patientCreate!.email!.isNotEmpty) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                return EditDocumentScreen(
                                  forStaff: false,
                                  patientCreate: widget.patientCreate,
                                  patientByIdModel: widget.patientByIdModel,
                                );
                              }),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Please Fill All Value.')),
                            );
                          }
                        }
                      }
                    : null,
                child: Center(
                  child: Text(AppText.save,
                      style: GoogleFonts.montserrat(
                          fontSize: 12, fontWeight: FontWeight.w600, color: _isFormComplete() ? const Color(0xFFFFFFFF) : const Color(0xFF9E9E9E))),
                )),
          ),
          const SizedBox(
            height: 15,
          )
        ]));
  }
}
