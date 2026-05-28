import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:clinica_flow/features/patient/model/patient_model.dart';
import 'package:clinica_flow/features/team/model/staff_model.dart';
import 'package:clinica_flow/shared/widgets/custom_textfield.dart';
import 'package:clinica_flow/shared/ui/member/edit/edit_document_screen.dart';
import 'package:clinica_flow/shared/models/address_model.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text.dart';
import 'package:clinica_flow/core/utils/responsive_layout.dart';

class EditContactDetailScreen extends StatefulWidget {
  final StaffModel? staff;
  final PatientModel? patient;
  final PageController? pageController;
  final bool isForStaff;

  const EditContactDetailScreen({
    super.key,
    required this.isForStaff,
    this.pageController,
    this.staff,
    this.patient,
  });

  @override
  State<EditContactDetailScreen> createState() =>
      _EditContactDetailScreenState();
}

class _EditContactDetailScreenState extends State<EditContactDetailScreen> {
  late final TextEditingController _phoneController;
  late final TextEditingController _emailController;
  late final TextEditingController _areaController;
  late final TextEditingController _pincodeController;
  late final TextEditingController _houseController;
  late final TextEditingController _landmarkController;
  late final TextEditingController _cityController;
  late final TextEditingController _additionalPhoneController;
  late final TextEditingController _additionalEmailController;

  bool _showAdditionalPhone = false;
  bool _showAdditionalEmail = false;
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 1);
    _phoneController = TextEditingController();
    _emailController = TextEditingController();
    _areaController = TextEditingController();
    _pincodeController = TextEditingController();
    _houseController = TextEditingController();
    _landmarkController = TextEditingController();
    _cityController = TextEditingController();
    _additionalPhoneController = TextEditingController();
    _additionalEmailController = TextEditingController();

    _initializeData();
    _phoneController.addListener(_updateState);
    _emailController.addListener(_updateState);
  }

  void _initializeData() {
    if (widget.isForStaff && widget.staff != null) {
      _phoneController.text = widget.staff!.mobile ?? '';
      _emailController.text = widget.staff!.email ?? '';
      _areaController.text = widget.staff!.address?.street ?? '';
      _pincodeController.text = widget.staff!.address?.pincode ?? '';
      _houseController.text = widget.staff!.address?.house ?? '';
      _landmarkController.text = widget.staff!.address?.landmarks ?? '';
      _cityController.text = widget.staff!.address?.city ?? '';
    } else if (!widget.isForStaff && widget.patient != null) {
      _phoneController.text = widget.patient!.mobile ?? '';
      _emailController.text = widget.patient!.email ?? '';
      _areaController.text = widget.patient!.address?.street ?? '';
      _pincodeController.text = widget.patient!.address?.pincode ?? '';
      _houseController.text = widget.patient!.address?.house ?? '';
      _landmarkController.text = widget.patient!.address?.landmarks ?? '';
      _cityController.text = widget.patient!.address?.city ?? '';
    }
  }

  void _updateState() => setState(() {});

  @override
  void dispose() {
    _phoneController.removeListener(_updateState);
    _emailController.removeListener(_updateState);
    _phoneController.dispose();
    _emailController.dispose();
    _pincodeController.dispose();
    _houseController.dispose();
    _landmarkController.dispose();
    _cityController.dispose();
    _additionalPhoneController.dispose();
    _additionalEmailController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  bool get _isFormComplete {
    return _phoneController.text.isNotEmpty && _emailController.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    final mobileView = Scaffold(
      appBar: AppBar(
        leadingWidth: 30,
        title: const Text(AppText.editProfile),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProgressIndicator(),
            const SizedBox(height: 10),
            const Text(
              AppText.contactDetails,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
            const SizedBox(height: 10),
            Flexible(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildContactSection(),
                    const SizedBox(height: 10),
                    _buildAddressSection(),
                  ],
                ),
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
      count: widget.isForStaff ? 5 : 3,
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

  Widget _buildContactSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextField(
          controller: _phoneController,
          hintText: AppText.phone,
          keyBoardType: TextInputType.phone,
          inputFormatters: [
            LengthLimitingTextInputFormatter(11),
            FilteringTextInputFormatter.digitsOnly
          ],
          height: 45,
        ),
        const SizedBox(height: 10),
        if (_showAdditionalPhone) ...[
          CustomTextField(
            controller: _additionalPhoneController,
            hintText: AppText.additionalPhone,
            keyBoardType: TextInputType.phone,
            inputFormatters: [
              LengthLimitingTextInputFormatter(11),
              FilteringTextInputFormatter.digitsOnly
            ],
            height: 45,
          ),
          const SizedBox(height: 10),
        ],
        _buildAddAction(
          AppText.addAnotherNumber,
          () => setState(() => _showAdditionalPhone = true),
        ),
        const SizedBox(height: 10),
        CustomTextField(
          controller: _emailController,
          hintText: AppText.email,
          height: 45,
        ),
        const SizedBox(height: 7),
        if (_showAdditionalEmail) ...[
          CustomTextField(
            controller: _additionalEmailController,
            hintText: AppText.additionalEmail,
            height: 45,
          ),
          const SizedBox(height: 10),
        ],
        _buildAddAction(
          AppText.addAnotherEmail,
          () => setState(() => _showAdditionalEmail = true),
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
            padding: const EdgeInsets.all(4.0),
            child: Container(
              height: 2,
              width: MediaQuery.of(context).size.width * 0.5,
              color: AppColors.primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddressSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          AppText.address,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        CustomTextField(
          controller: _houseController,
          hintText: AppText.houseNo,
          height: 45,
        ),
        const SizedBox(height: 5),
        CustomTextField(
          controller: _areaController,
          hintText: AppText.area,
          height: 45,
        ),
        const SizedBox(height: 5),
        CustomTextField(
          controller: _landmarkController,
          hintText: AppText.landmarks,
          height: 45,
        ),
        const SizedBox(height: 5),
        CustomTextField(
          controller: _cityController,
          hintText: AppText.city,
          height: 45,
        ),
        const SizedBox(height: 5),
        CustomTextField(
          controller: _pincodeController,
          keyBoardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(6)
          ],
          hintText: AppText.pincode,
          height: 45,
        ),
      ],
    );
  }

  Widget _buildSaveButton() {
    final bool isEnabled = _isFormComplete;
    return Container(
      height: 52,
      decoration: BoxDecoration(
        color: isEnabled ? AppColors.greenColor : Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: isEnabled ? null : Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: TextButton(
        onPressed: isEnabled ? _onSave : null,
        child: Center(
          child: Text(
            AppText.save,
            style: GoogleFonts.montserrat(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: isEnabled ? Colors.white : const Color(0xFF9E9E9E),
            ),
          ),
        ),
      ),
    );
  }

  void _onSave() {
    final address = Address(
      house: _houseController.text,
      street: _areaController.text,
      landmarks: _landmarkController.text,
      city: _cityController.text,
      pincode: _pincodeController.text,
    );

    if (widget.isForStaff) {
      widget.staff!.mobile = _phoneController.text;
      widget.staff!.email = _emailController.text;
      widget.staff!.address = address;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EditDocumentScreen(
            forStaff: true,
            staff: widget.staff,
          ),
        ),
      );
    } else {
      widget.patient!.mobile = _phoneController.text;
      widget.patient!.email = _emailController.text;
      widget.patient!.address = address;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EditDocumentScreen(
            forStaff: false,
            patient: widget.patient,
          ),
        ),
      );
    }
  }
}
