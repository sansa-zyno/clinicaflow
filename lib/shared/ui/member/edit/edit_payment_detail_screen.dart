import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:clinica_flow/shared/widgets/custom_textfield.dart';
import 'package:clinica_flow/shared/ui/member/edit/edit_appointment_settings.dart';
import 'package:clinica_flow/shared/widgets/bankname_dropdown.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text.dart';
import '../../../../features/team/model/staff_model.dart';
import 'package:clinica_flow/core/utils/responsive_layout.dart';

class EditPaymentDetailScreen extends StatefulWidget {
  final StaffModel staff;
  final PageController? pageController;

  const EditPaymentDetailScreen({
    super.key,
    this.pageController,
    required this.staff,
  });

  @override
  State<EditPaymentDetailScreen> createState() =>
      _EditPaymentDetailScreenState();
}

class _EditPaymentDetailScreenState extends State<EditPaymentDetailScreen> {
  final TextEditingController _accountNoController = TextEditingController();
  final TextEditingController _accountHolderNameController =
      TextEditingController();
  final TextEditingController _additionalAnotherNumberIDController =
      TextEditingController();

  bool _showAnotherNumber = false;
  String? _bankNameText;
  final PageController _pageController = PageController(initialPage: 3);

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  void _initializeData() {
    _accountNoController.text = widget.staff.accountNo ?? '';
    _accountHolderNameController.text = widget.staff.accountName ?? '';
    _bankNameText = _sanitizeBankName(widget.staff.bankName);
  }

  String? _sanitizeBankName(String? bankName) {
    if (bankName == null || bankName.isEmpty) return null;
    const validBanks = [
      'GT Bank',
      'Union Bank',
      'Wema Bank',
      'Zenith Bank',
      'First Bank',
      'Fcmb Bank',
      'Others'
    ];
    return validBanks.contains(bankName) ? bankName : null;
  }

  @override
  void dispose() {
    _accountNoController.dispose();
    _accountHolderNameController.dispose();
    _additionalAnotherNumberIDController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mobileView = Scaffold(
      appBar: AppBar(
        leadingWidth: 30,
        title: const Text(AppText.editProfile),
        actions: [
          TextButton(
            onPressed: _onSkip,
            child: const Text(
              'Skip',
              style: TextStyle(color: AppColors.primaryColor, fontSize: 18),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProgressIndicator(),
            const SizedBox(height: 10),
            _buildPaymentHeader(),
            const SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                child: _buildBankDetailsSection(),
              ),
            ),
            const SizedBox(height: 50),
            _buildSaveButton(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );

    return ResponsiveLayout(
      mobile: mobileView,
      desktop: Scaffold(
        backgroundColor: const Color(0xffF5F5F5),
        body: Center(
          child: Container(
            width: 600,
            height: 800,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: MediaQuery(
              data: MediaQuery.of(context).copyWith(
                size: const Size(600, 800),
              ),
              child: mobileView,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return SmoothPageIndicator(
      controller: _pageController,
      count: 5,
      effect: const ExpandingDotsEffect(
        expansionFactor: 5,
        activeDotColor: AppColors.primaryColor,
        dotColor: AppColors.greyColor,
        strokeWidth: 3,
        dotHeight: 8,
        dotWidth: 8,
        paintStyle: PaintingStyle.fill,
      ),
    );
  }

  Widget _buildPaymentHeader() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppText.paymentDetails,
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        ),
      ],
    );
  }

  Widget _buildBankDetailsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          AppText.bankDetails,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        BankNameDropDown(
          value: _bankNameText,
          onChanged: (newValue) => setState(() => _bankNameText = newValue),
        ),
        const SizedBox(height: 10),
        CustomTextField(
          controller: _accountNoController,
          keyBoardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          hintText: AppText.accountNo,
          height: 52,
        ),
        const SizedBox(height: 10),
        CustomTextField(
          controller: _accountHolderNameController,
          hintText: AppText.accountHolderName,
          height: 52,
        ),
        const SizedBox(height: 10),
        if (_showAnotherNumber) ...[
          CustomTextField(
            controller: _additionalAnotherNumberIDController,
            keyBoardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            hintText: AppText.additionalAnotherNumber,
            height: 52,
          ),
          const SizedBox(height: 10),
        ],
        _buildAddAction(
          AppText.addAnotherNumber,
          () => setState(() => _showAnotherNumber = true),
        ),
      ],
    );
  }

  Widget _buildAddAction(String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.add, color: AppColors.primaryColor),
              Text(
                label,
                style: const TextStyle(color: AppColors.primaryColor),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Container(
              height: 2,
              width: MediaQuery.of(context).size.width * 0.6,
              color: AppColors.primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSaveButton() {
    return GestureDetector(
      onTap: _onSave,
      child: Container(
        height: 52,
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
    );
  }

  void _onSkip() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditAppointmentSettings(staff: widget.staff),
      ),
    );
  }

  void _onSave() {
    widget.staff.bankName = _bankNameText;
    widget.staff.accountNo = _accountNoController.text;
    widget.staff.accountName = _accountHolderNameController.text;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditAppointmentSettings(staff: widget.staff),
      ),
    );
  }
}
