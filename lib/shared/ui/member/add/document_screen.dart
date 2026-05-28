import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:clinica_flow/shared/widgets/custom_textfield.dart';
import 'package:clinica_flow/shared/widgets/id_proof_dropdown.dart';
import 'package:clinica_flow/shared/ui/member/add/payment_detail_screen.dart';
import 'package:clinica_flow/features/patient/view/patients_records.dart';
import 'package:clinica_flow/features/patient/viewmodel/patient_records_cubit.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_text.dart';
import 'package:clinica_flow/core/utils/shared_preferences_service.dart';
import 'package:clinica_flow/core/utils/enums/bloc_enums.dart';
import 'package:clinica_flow/core/utils/snackbar.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:file_picker/file_picker.dart';
import '../../../models/created_model.dart';
import '../../../models/document_model.dart';
import '../../../../features/patient/model/patient_model.dart';
import '../../../../features/team/model/staff_model.dart';
import 'package:clinica_flow/core/utils/responsive_layout.dart';

class DocumentScreen extends StatefulWidget {
  final PageController? pageController;
  final PatientModel? patient;
  final StaffModel? staff;
  final bool forStaff;

  const DocumentScreen({
    super.key,
    required this.forStaff,
    this.pageController,
    this.patient,
    this.staff,
  });

  @override
  State<DocumentScreen> createState() => _DocumentScreenState();
}

class _DocumentScreenState extends State<DocumentScreen> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _additionalIDController = TextEditingController();
  final List<String> _docs = [];
  final List<Documents> _patDocs = [];
  final List<Documents> _staffDocs = [];
  String? _idProofText;
  bool _showID = false;
  final PageController _pageController = PageController(initialPage: 2);

  @override
  void dispose() {
    _idController.dispose();
    _additionalIDController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mobileView = Scaffold(
      appBar: AppBar(
        leadingWidth: 30,
        title: const Text(
          AppText.addMember,
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        actions: [
          if (widget.forStaff)
            TextButton(
              onPressed: _onSkip,
              child: const Text(
                'Skip',
                style: TextStyle(color: AppColors.primaryColor, fontSize: 18),
              ),
            ),
        ],
      ),
      body: BlocListener<PatientRecordsCubit, PatientRecordsState>(
        listener: _onPatientRecordsStateChanged,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProgressIndicator(),
              const SizedBox(height: 10),
              const Text(
                AppText.documents,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildIdProofSection(),
                      const SizedBox(height: 10),
                      const Divider(),
                      _buildFileUploadSection(),
                      const Divider(),
                      _buildDocumentList(),
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

  Widget _buildIdProofSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IdProofDropDown(
          value: _idProofText,
          onChanged: (newValue) => setState(() => _idProofText = newValue),
        ),
        const SizedBox(height: 10),
        CustomTextField(
          controller: _idController,
          keyBoardType: TextInputType.number,
          hintText: AppText.iDNo,
          height: 52,
        ),
        const SizedBox(height: 10),
        if (_showID) ...[
          CustomTextField(
            controller: _additionalIDController,
            keyBoardType: TextInputType.number,
            hintText: AppText.additionalID,
            height: 52,
          ),
          const SizedBox(height: 10),
        ],
        _buildAddAction(
          AppText.addAnotherID,
          () => setState(() => _showID = true),
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

  Widget _buildFileUploadSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          AppText.addDocuments,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        const Text(
          AppText.uploadImage,
          style: TextStyle(fontSize: 10),
        ),
        const SizedBox(height: 5),
        GestureDetector(
          onTap: _pickFiles,
          child: Container(
            height: 35,
            decoration: BoxDecoration(
              color: AppColors.greyColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  Text(
                    'Browse to upload documents',
                    style: TextStyle(fontSize: 12, color: AppColors.whiteColor),
                  ),
                  Spacer(),
                  Icon(Icons.cloud_upload_outlined,
                      color: AppColors.whiteColor),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDocumentList() {
    if (_docs.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          AppText.list,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        ..._docs.map((e) => Row(
              children: [
                Text(
                  e.split('_').last,
                  style:
                      const TextStyle(color: Color(0xff6D6D6D), fontSize: 12),
                ),
                const Spacer(),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.find_in_page_rounded)),
                IconButton(
                  onPressed: () => setState(() => _docs.remove(e)),
                  icon: const Icon(Icons.delete),
                ),
              ],
            )),
      ],
    );
  }

  Widget _buildSaveButton() {
    return BlocBuilder<PatientRecordsCubit, PatientRecordsState>(
      builder: (context, state) {
        if (state.state == PatientRecordsStates.postingPatient) {
          return const Padding(
            padding: EdgeInsets.only(bottom: 50),
            child: Center(child: CircularProgressIndicator()),
          );
        }
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
      },
    );
  }

  void _onSkip() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => PaymentDetailScreen(staff: widget.staff!)),
    );
  }

  void _onPatientRecordsStateChanged(
      BuildContext context, PatientRecordsState state) {
    if (state.state == PatientRecordsStates.patientPosted) {
      for (int i = 0; i < 4; i++) Navigator.pop(context);
      showSnackbar("Patient created successfully", context);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const PatientRecords()),
      );
    }
  }

  Future<void> _pickFiles() async {
    FilePickerResult? result = await FilePicker.pickFiles();
    if (result != null) {
      PlatformFile file = result.files.first;
      setState(() {
        if (!_docs.contains(file.name)) {
          _docs.add(file.name);
          final doc = Documents(fileName: file.path, blobName: file.path);
          if (widget.forStaff) {
            _staffDocs.add(doc);
          } else {
            _patDocs.add(doc);
          }
        }
      });
    }
  }

  void _onSave() async {
    if (widget.forStaff) {
      widget.staff?.documentType = _idProofText;
      widget.staff?.documentNumber = _idController.text;
      widget.staff?.documents = _staffDocs;
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PaymentDetailScreen(staff: widget.staff!)),
      );
    } else {
      String clinicId = await SharedPrefService.getClinicId() ?? '';
      widget.patient?.documentType = _idProofText;
      widget.patient?.documentNumber = _idController.text;
      widget.patient?.documents = _patDocs;
      widget.patient?.createdOn =
          Created(by: By(id: '', name: ''), on: DateTime.now());
      widget.patient?.modifiedOn =
          Created(by: By(id: '', name: ''), on: DateTime.now());
      widget.patient?.clientId = clinicId;

      if (clinicId.isNotEmpty) {
        await context.read<PatientRecordsCubit>().postPatient(widget.patient!);
      }
    }
  }
}
