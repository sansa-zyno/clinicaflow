import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healtether_clinic_app/Screens/AppointmentScreen/widgets/custom_textfield.dart';
import 'package:healtether_clinic_app/Screens/Members/EditScreens/edit_appointment_settings.dart';
import 'package:healtether_clinic_app/Screens/Members/ManageStaff/bankname_dropdown.dart';
import 'package:healtether_clinic_app/data_layer/models/staff_model/create_staff_model.dart';
import 'package:healtether_clinic_app/constants/constants.dart';
import 'package:healtether_clinic_app/data_layer/models/staff_model/staff_detail_model.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class EditPaymentDetailScreen extends StatefulWidget {
  final CreateStaff createStaff;
  final PageController? pageController;
  final StaffByIdModel staffByIdModel;

  const EditPaymentDetailScreen({super.key, this.pageController, required this.createStaff, required this.staffByIdModel});

  @override
  State<EditPaymentDetailScreen> createState() => _EditPaymentDetailScreenState();
}

class _EditPaymentDetailScreenState extends State<EditPaymentDetailScreen> {
  TextEditingController upiIdController = TextEditingController();
  TextEditingController iFSCCodeController = TextEditingController();
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
  void initState() {
    // TODO: implement initState
    super.initState();
    iFSCCodeController.text = widget.staffByIdModel.ifsc;
    upiIdController.text = widget.staffByIdModel.upiId;
    accountNoController.text = '';
    accountHolderNameController.text = widget.staffByIdModel.accountName;
    bankNameText = widget.staffByIdModel.bankName != "" ? widget.staffByIdModel.bankName : null;
    if (<String>['Bank name', 'Indian Bank', 'SBI Bank', 'HDFC Bank', 'PNB Bank', 'Others'].contains(bankNameText)) {
      bankNameText = bankNameText;
    } else {
      bankNameText = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: const Text(AppText.editProfile),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EditAppointmentSettings(
                            createStaff: widget.createStaff,
                            staffByIdModel: widget.staffByIdModel,
                          )),
                );
              },
              child: const Text(
                'Skip',
                style: TextStyle(color: Color(0XFF4646B5), fontSize: 18),
              ),
            ),
            /*IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),*/
          ],
        ),
        body: Column(
          children: [
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
                      if (showUpiID)
                        CustomTextField(
                          controller: additionalUpiIDController,
                          hintText: AppText.additionalUpiID,
                          height: 52,
                        ),
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
                        keyBoardType: TextInputType.number,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        hintText: AppText.accountNo,
                        height: 52,
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        controller: iFSCCodeController,
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
                      if (showAnotherNumber)
                        CustomTextField(
                          controller: additionalAnotherNumberIDController,
                          keyBoardType: TextInputType.number,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          hintText: AppText.additionalAnotherNumber,
                          height: 52,
                        ),
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
                              AppText.addAnotherNumber,
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
            GestureDetector(
              onTap: () {
                widget.createStaff.bankName = bankNameText;
                widget.createStaff.account = accountNoController.text;
                widget.createStaff.accountName = accountHolderNameController.text;
                widget.createStaff.ifsc = iFSCCodeController.text;
                widget.createStaff.upiId = upiIdController.text;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EditAppointmentSettings(
                            createStaff: widget.createStaff,
                            staffByIdModel: widget.staffByIdModel,
                          )),
                );
              },
              child: Container(
                height: 52,
                margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
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
        ));
  }
}
