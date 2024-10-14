import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healtether_clinic_app/Screens/AppointmentScreen/widgets/custom_textfield.dart';
import 'package:healtether_clinic_app/Screens/ManageStaff/document_screen.dart';
import 'package:healtether_clinic_app/business_logic/cubits/staff_cubit/staff_cubit.dart';
import 'package:healtether_clinic_app/data_layer/models/staff_model/address_staff_model.dart';
import 'package:healtether_clinic_app/data_layer/models/staff_model/create_staff_model.dart';
import 'package:healtether_clinic_app/business_logic/cubits/patient_records_cubit/patient_records_cubit.dart';
import 'package:healtether_clinic_app/constants/constants.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ContactDetailScreen extends StatefulWidget {
  final CreateStaff createStaff;
  final PageController? pageController;
  final bool isForStaff;

  const ContactDetailScreen({Key? key, this.pageController, required this.createStaff, required this.isForStaff}) : super(key: key);

  @override
  State<ContactDetailScreen> createState() => _ContactDetailScreenState();
}

class _ContactDetailScreenState extends State<ContactDetailScreen> {
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
    bool isComplete = phoneController.text.isNotEmpty && emailController.text.isNotEmpty;
    print("Is form complete: $isComplete");
    return isComplete;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          leadingWidth: 30,
          title: const Text('Add member'),
        ),
        body: BlocBuilder<StaffCubit, StaffState>(builder: (context, state) {
          if (state.errorMessage != null) {
            return Center(child: Text('Error: ${state.errorMessage}'));
          }

          return Column(children: [
            Expanded(
              child: SingleChildScrollView(
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
                                Icon(Icons.add, color: AppColors.blueColor),
                                Text(
                                  AppText.addAnotherNumber,
                                  style: TextStyle(color: AppColors.blueColor),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Container(
                                height: 2,
                                width: screenSize.width * 0.5,
                                color: AppColors.blueColor,
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
                                  color: AppColors.blueColor,
                                ),
                                Text(
                                  AppText.addAnotherEmail,
                                  style: TextStyle(color: AppColors.blueColor),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Container(
                                height: 2,
                                width: screenSize.width * 0.5,
                                color: AppColors.blueColor,
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
                          widget.createStaff.mobile = phoneController.text;
                          widget.createStaff.email = emailController.text;
                          widget.createStaff.address = Address(
                            house: houseController.text,
                            street: areaController.text,
                            landmarks: landmarkController.text,
                            city: cityController.text,
                            pincode: pincodeController.text,
                          );
                          // widget.createStaff.mobile = phoneController.text;
                          // widget.createStaff.email = emailController.text;
                          // widget.createStaff.address = widget.createStaff.address ?? Address();
                          // widget.createStaff.address!.house = houseController.text;
                          // widget.createStaff.address!.pincode = pincodeController.text;
                          // widget.createStaff.address!.street = areaController.text;
                          // widget.createStaff.address!.landmarks =
                          //     landmarkController.text;
                          // widget.createStaff.address!.city = cityController.text;
                          // try {
                          //   final StaffProvider staffProvider =
                          //       Provider.of<StaffProvider>(context, listen: false);
                          //   await staffProvider.createStaff(widget.createStaff);
                          //   if (staffProvider.errorMessage != null) {
                          //     throw Exception(staffProvider.errorMessage);
                          //   }
                          // staffProvider.createStaff(widget.createStaff).then((_) {

                          if (widget.createStaff.mobile!.isNotEmpty && widget.createStaff.email!.isNotEmpty) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                return DocumentScreen(forStaff: true, createStaff: widget.createStaff);
                              }),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Please Fill All Value.')),
                            );
                          }

                          //   }
                          // );
                        }
                      : null,
                  // } catch (e) {
                  //   ScaffoldMessenger.of(context).showSnackBar(
                  //     SnackBar(content: Text('Error: ${e.toString()}')),
                  //   );
                  // }

                  child: Center(
                    child: Text(AppText.save,
                        style: GoogleFonts.montserrat(
                            fontSize: 12, fontWeight: FontWeight.w600, color: _isFormComplete() ? const Color(0xFFFFFFFF) : const Color(0xFF9E9E9E))),
                  )),
            )
          ]);
        }));
  }
}
