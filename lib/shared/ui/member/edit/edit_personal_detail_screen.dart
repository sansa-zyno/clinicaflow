// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:clinica_flow/shared/ui/member/edit/edit_contact_detail_screen.dart';
import 'package:clinica_flow/features/team/model/staff_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:clinica_flow/shared/widgets/birtdate.dart';
import 'package:clinica_flow/shared/widgets/custom_textfield.dart';
import 'package:clinica_flow/shared/widgets/gender_dropdown.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text.dart';
import '../../../../features/patient/model/patient_model.dart';
import 'package:clinica_flow/core/utils/responsive_layout.dart';

class EditPersonalDetailScreen extends StatefulWidget {
  final bool isAdmin;
  final bool forStaff;
  final StaffModel? staff;
  final PatientModel? patient;
  final PageController? pageController;

  const EditPersonalDetailScreen({
    super.key,
    required this.isAdmin,
    required this.forStaff,
    this.pageController,
    this.staff,
    this.patient,
  });

  @override
  State<EditPersonalDetailScreen> createState() =>
      _EditPersonalDetailScreenState();
}

class _EditPersonalDetailScreenState extends State<EditPersonalDetailScreen> {
  late final PageController _pageController;
  late final TextEditingController _firstNameController;
  late final TextEditingController _positionController;
  late final TextEditingController _ageController;
  late final TextEditingController _lastNameController;

  DateTime? _dob;
  String? _genderText;
  File? _image;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _firstNameController = TextEditingController();
    _positionController = TextEditingController();
    _ageController = TextEditingController();
    _lastNameController = TextEditingController();

    _initializeData();
  }

  void _initializeData() {
    if (widget.forStaff && widget.staff != null) {
      _positionController.text = widget.staff!.specialization ?? '';
      _firstNameController.text = widget.staff!.firstName ?? '';
      _lastNameController.text = widget.staff!.lastName ?? '';
      _dob = widget.staff!.birthday;
      _ageController.text = widget.staff!.age?.toString() ?? '';
      _genderText = _sanitizeGender(widget.staff!.gender);
    } else if (!widget.forStaff && widget.patient != null) {
      _firstNameController.text = widget.patient!.firstName ?? '';
      _lastNameController.text = widget.patient!.lastName ?? '';
      _dob = widget.patient!.birthday;
      _ageController.text = widget.patient!.age?.toString() ?? '';
      _genderText = _sanitizeGender(widget.patient!.gender);
    }
  }

  String? _sanitizeGender(String? gender) {
    if (gender == null || gender.isEmpty) return null;
    const validGenders = ['Male', 'Female', 'Others'];
    return validGenders.contains(gender) ? gender : null;
  }

  @override
  void dispose() {
    _pageController.dispose();
    _firstNameController.dispose();
    _positionController.dispose();
    _ageController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  bool get _isFormComplete {
    final bool hasName = _firstNameController.text.isNotEmpty &&
        _lastNameController.text.isNotEmpty;
    final bool hasGender = _genderText != null;
    final bool hasDob = _dob != null;
    final bool hasAge = _ageController.text.isNotEmpty;

    if (widget.forStaff) {
      final bool hasPosition = _positionController.text.isNotEmpty;
      final bool ageValid = (int.tryParse(_ageController.text) ?? 0) > 10;
      return hasName &&
          hasGender &&
          hasDob &&
          hasAge &&
          hasPosition &&
          ageValid;
    } else {
      final bool ageValid = (int.tryParse(_ageController.text) ?? 0) > 0;
      return hasName && hasGender && hasDob && hasAge && ageValid;
    }
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
              AppText.personalDetails,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 12),
            Flexible(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildProfileSection(),
                    _buildFormFields(),
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
      count: widget.forStaff ? 5 : 3,
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

  Widget _buildProfileSection() {
    if (!widget.forStaff) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: _getImage,
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey[300],
                backgroundImage: _image != null ? FileImage(_image!) : null,
                child: _image == null
                    ? const Icon(Icons.camera_alt_outlined,
                        color: AppColors.primaryColor, size: 30)
                    : null,
              ),
            ),
            const SizedBox(width: 10),
            const Expanded(
              child: Text(
                'Tap to change photo',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  height: 1.4,
                  color: Color(0xFF8E8E8E),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildFormFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.forStaff) ...[
          CustomTextField(
            controller: _positionController,
            hintText: AppText.position,
            height: 52,
          ),
          const SizedBox(height: 6),
        ],
        CustomTextField(
          controller: _firstNameController,
          hintText: AppText.firstName,
          height: 52,
        ),
        const SizedBox(height: 6),
        CustomTextField(
          controller: _lastNameController,
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
            const SizedBox(width: 10),
            Expanded(
              child: CustomTextField(
                controller: _ageController,
                hintText: AppText.age,
                height: 52,
                keyBoardType: TextInputType.number,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            Expanded(
              child: GenderDropDown(
                value: _genderText,
                onChanged: (String? newValue) {
                  setState(() => _genderText = newValue);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSaveButton() {
    final bool isEnabled = _isFormComplete;
    return GestureDetector(
      onTap: isEnabled ? _onSave : null,
      child: Container(
        height: 52,
        decoration: BoxDecoration(
          color: isEnabled ? AppColors.greenColor : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: isEnabled ? null : Border.all(color: const Color(0xFFE0E0E0)),
        ),
        child: Center(
          child: Text(
            AppText.save,
            style: GoogleFonts.montserrat(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isEnabled ? Colors.white : const Color(0xFF9E9E9E),
            ),
          ),
        ),
      ),
    );
  }

  void _onSave() {
    if (widget.forStaff) {
      //widget.staff!.profilepic = _image?.path ?? (widget.staff?.profilepic ?? '');
      widget.staff!.firstName = _firstNameController.text;
      widget.staff!.lastName = _lastNameController.text;
      widget.staff!.specialization = _positionController.text;
      widget.staff!.birthday = _dob;
      widget.staff!.age = int.tryParse(_ageController.text);
      widget.staff!.gender = _genderText;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EditContactDetailScreen(
            isForStaff: true,
            staff: widget.staff,
          ),
        ),
      );
    } else {
      widget.patient?.firstName = _firstNameController.text;
      widget.patient?.lastName = _lastNameController.text;
      widget.patient?.birthday = _dob;
      widget.patient?.age = int.tryParse(_ageController.text);
      widget.patient?.gender = _genderText;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EditContactDetailScreen(
            isForStaff: false,
            patient: widget.patient,
          ),
        ),
      );
    }
  }

  int _calculateAge(DateTime birthDate) {
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
      initialDate: _dob ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null && pickedDate != _dob) {
      setState(() {
        _dob = pickedDate;
        _ageController.text = _calculateAge(pickedDate).toString();
      });
    }
  }

  Future<void> _getImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }
}
