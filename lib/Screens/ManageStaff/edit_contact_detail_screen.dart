import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healtether_clinic_app/Screens/AppointmentScreen/widgets/custom_textfield.dart';
import 'package:healtether_clinic_app/constants/constants.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'edit_document_screen.dart';

class EditContactDetailScreen extends StatefulWidget {
  final PageController? pageController;

  const EditContactDetailScreen({Key? key, this.pageController}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 30,
        title: const Text(AppText.editProfile),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
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
                          paintStyle: PaintingStyle.fill,
                        ),
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
                      height: 45,
                    ),
                    const SizedBox(height: 10),
                    if (showAdditionalPhone) ...[
                      CustomTextField(
                        controller: additionalPhoneController,
                        hintText: AppText.additionalPhone,
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
                      hintText: AppText.pincode,
                      height: 45,
                    ),
                    const SizedBox(height: 20),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 36, right: 36, bottom: 8, top: 5),
            child: Container(
              height: 60,
              width: 280,
              decoration: BoxDecoration(
                color: AppColors.greenColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const EditDocumentScreen();
                  }));
                },
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
    );
  }
}
