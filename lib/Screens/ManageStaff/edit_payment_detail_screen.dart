import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healtether_clinic_app/Screens/AppointmentScreen/widgets/custom_textfield.dart';
import 'package:healtether_clinic_app/Screens/ManageStaff/bankname_dropdown.dart';
import 'package:healtether_clinic_app/constants/constants.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class EditPaymentDetailScreen extends StatefulWidget {
  final PageController? pageController;

  const EditPaymentDetailScreen({super.key, this.pageController});

  @override
  State<EditPaymentDetailScreen> createState() => _EditPaymentDetailScreenState();
}

class _EditPaymentDetailScreenState extends State<EditPaymentDetailScreen> {
  TextEditingController upiIdController = TextEditingController();
  TextEditingController IFSCCodeController = TextEditingController();
  TextEditingController accountNoController = TextEditingController();
  TextEditingController accountHolderNameController = TextEditingController();
  TextEditingController additionalUpiIDController = TextEditingController();
  TextEditingController additionalAnotherNumberIDController = TextEditingController();
  bool showUpiID = false;
  bool showAnotherNumber = false;
  String? bankNameText;
  int currentPageIndex = 3;
  final PageController pageController = PageController(initialPage: 3);

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
              // physics: NeverScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisSize: MainAxisSize.min,
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
                      AppText.paymentDetails,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      AppText.upiID,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      controller: upiIdController,
                      hintText: AppText.addUpiID,
                      height: 52,
                    ),
                    const SizedBox(height: 10),
                    if (showUpiID) ...[
                      CustomTextField(
                        controller: additionalUpiIDController,
                        hintText: AppText.additionalUpiID,
                        height: 52,
                      ),
                    ],
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          showUpiID = true;
                        });
                      },
                      child: const Row(
                        children: [
                          Icon(Icons.add, color: AppColors.blueViolet),
                          Text(
                            AppText.addAnotherUPIID,
                            style: TextStyle(color: AppColors.blueViolet),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 2,
                        width: screenSize.width * 0.6,
                        color: AppColors.blueViolet,
                      ),
                    ),
                    const Text(
                      AppText.bankDetails,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: BankNameDropDown(
                            value: bankNameText,
                            onChanged: (String? newValue) {
                              setState(() {
                                bankNameText = newValue;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      controller: accountNoController,
                      hintText: AppText.accountNo,
                      height: 52,
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      controller: IFSCCodeController,
                      hintText: AppText.iFSCCode,
                      height: 52,
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      controller: accountHolderNameController,
                      hintText: AppText.accountHolderName,
                      height: 52,
                    ),
                    const SizedBox(height: 10),
                    if (showAnotherNumber) ...[
                      CustomTextField(
                        controller: additionalAnotherNumberIDController,
                        hintText: AppText.additionalAnotherNumber,
                        height: 52,
                      ),
                    ],
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          showAnotherNumber = true;
                        });
                      },
                      child: const Row(
                        children: [
                          Icon(Icons.add, color: AppColors.blueViolet),
                          Text(
                            AppText.addAnotherBank,
                            style: TextStyle(color: AppColors.blueViolet),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 2,
                        width: screenSize.width * 0.6,
                        color: AppColors.blueViolet,
                      ),
                    ),
                    const SizedBox(height: 40),
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
    );
  }
}
