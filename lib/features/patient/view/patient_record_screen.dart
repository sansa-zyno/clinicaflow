import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:clinica_flow/features/patient/view/add_medical_record_screen.dart';
import 'package:clinica_flow/features/patient/view/add_prescription_screen.dart';
import 'package:clinica_flow/features/patient/view/add_procedure_screen.dart';
import 'package:clinica_flow/features/patient/viewmodel/patient_detail_cubit.dart';
import 'package:clinica_flow/features/patient/state/patient_detail_state.dart';
import 'package:clinica_flow/features/patient/model/patient_model.dart';
import 'package:clinica_flow/features/patient/viewmodel/patient_records_cubit.dart';
import 'package:clinica_flow/shared/ui/member/edit/edit_personal_detail_screen.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text.dart';
import 'package:clinica_flow/core/utils/enums/bloc_enums.dart';
import 'package:clinica_flow/core/utils/snackbar.dart';
import 'package:intl/intl.dart';

class PatientRecordsScreen extends StatefulWidget {
  final PatientModel patient;

  const PatientRecordsScreen({
    super.key,
    required this.patient,
  });

  @override
  State<PatientRecordsScreen> createState() => _PatientRecordsScreenState();
}

class _PatientRecordsScreenState extends State<PatientRecordsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<PatientDetailCubit>().fetchData(widget.patient.id!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFBFC),
      appBar: _buildAppBar(),
      body: BlocBuilder<PatientDetailCubit, PatientDetailState>(
        builder: (context, state) {
          if (state is PatientDetailLoadingState) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.greenColor),
            );
          }

          PatientModel? patientData;
          if (state is PatientDetailLoadedState) {
            patientData = state.data;
          }

          if (patientData == null) {
            return _buildErrorState();
          }

          return _buildContent(patientData);
        },
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      leadingWidth: 30,
      surfaceTintColor: Colors.white,
      backgroundColor: Colors.white,
      title: Text(
        AppText.patientRecords,
        style: GoogleFonts.urbanist(
          fontWeight: FontWeight.w600,
          fontSize: 20,
        ),
      ),
      actions: [
        Container(
          height: 32,
          width: 32,
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFE0E0E0)),
            borderRadius: BorderRadius.circular(8),
          ),
          child: InkWell(
            onTap: () => Navigator.of(context).pop(),
            child: const Icon(Icons.close_rounded, size: 18),
          ),
        ),
        const SizedBox(width: 8),
        IconButton(
          onPressed: () => _showDeleteConfirmationDialog(context),
          icon:
              const Icon(Icons.delete_outline_rounded, color: Colors.redAccent),
        ),
      ],
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.person_off_outlined, size: 48, color: Colors.grey[400]),
          const SizedBox(height: 12),
          Text(
            'Unable to load patient details',
            style: GoogleFonts.urbanist(fontSize: 16, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(PatientModel patientData) {
    final fullName =
        '${patientData.firstName ?? ''} ${patientData.lastName ?? ''}'.trim();

    return SingleChildScrollView(
      child: Column(
        children: [
          _buildProfileHeader(patientData, fullName),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                _buildPersonalDetails(patientData),
                const SizedBox(height: 12),
                _buildContactInformation(patientData),
                const SizedBox(height: 12),
                _buildIdentificationSection(patientData),
                const SizedBox(height: 12),
                _buildPrescriptionRecords(context),
                const SizedBox(height: 12),
                _buildMedicalRecords(context),
                const SizedBox(height: 12),
                _buildProcedureRecords(context),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHeader(PatientModel patientData, String fullName) {
    const badgeColor = Color(0xFF1B7A5A);

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFF1F5F9)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0F172A).withOpacity(0.04),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              _buildProfileAvatar(patientData, badgeColor),
              const SizedBox(width: 16),
              _buildProfileInfo(patientData, fullName, badgeColor),
            ],
          ),
          const SizedBox(height: 16),
          _buildProfileActions(patientData),
        ],
      ),
    );
  }

  Widget _buildProfileAvatar(PatientModel patientData, Color badgeColor) {
    final hasProfilePic = patientData.profilepic?.isNotEmpty == true;
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: badgeColor.withOpacity(0.3), width: 2),
      ),
      child: CircleAvatar(
        radius: 40,
        backgroundColor: badgeColor.withOpacity(0.1),
        backgroundImage:
            hasProfilePic ? NetworkImage(patientData.profilepic!) : null,
        child: !hasProfilePic
            ? Text(
                patientData.initials,
                style: GoogleFonts.urbanist(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: badgeColor,
                ),
              )
            : null,
      ),
    );
  }

  Widget _buildProfileInfo(
      PatientModel patientData, String fullName, Color badgeColor) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            decoration: BoxDecoration(
              color: badgeColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'Patient',
              style: GoogleFonts.urbanist(
                  fontSize: 12, fontWeight: FontWeight.w600, color: badgeColor),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            fullName.isNotEmpty ? fullName : 'Unnamed Patient',
            style: GoogleFonts.urbanist(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF1A1A2E)),
          ),
          const SizedBox(height: 4),
          Text(
            'ID: ${patientData.patientId ?? 'N/A'}',
            style: GoogleFonts.roboto(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileActions(PatientModel patientData) {
    return Row(
      children: [
        Expanded(
          child: _buildProfileAction(
            icon: Icons.edit_rounded,
            label: 'Edit Profile',
            color: AppColors.greenColor,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditPersonalDetailScreen(
                    isAdmin: false,
                    forStaff: false,
                    patient: patientData,
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _buildProfileAction(
            icon: Icons.add_circle_outline_rounded,
            label: 'Add Records',
            color: const Color(0xFF2E86AB),
            onTap: () => showAddRecordsBottomSheet(context),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _buildProfileAction(
            icon: Icons.message_rounded,
            label: 'WhatsApp',
            color: const Color(0xFF25D366),
            onTap: () {},
          ),
        ),
      ],
    );
  }

  Widget _buildProfileAction(
      {required IconData icon,
      required String label,
      required Color color,
      required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: color.withOpacity(0.08),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(icon, size: 20, color: color),
            const SizedBox(height: 4),
            Text(
              label,
              style: GoogleFonts.urbanist(
                  fontSize: 11, fontWeight: FontWeight.w600, color: color),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPersonalDetails(PatientModel patientData) {
    return _buildSectionCard(
      title: 'Personal Details',
      icon: Icons.person_outline_rounded,
      children: [
        _buildDetailRow(
          'Date of Birth',
          patientData.birthday != null
              ? DateFormat('dd MMM, yyyy').format(patientData.birthday!)
              : 'Not provided',
        ),
        _buildDetailRow(
          'Age',
          patientData.age != null ? '${patientData.age} years' : 'Not provided',
        ),
        _buildDetailRow(
          'Gender',
          (patientData.gender?.isNotEmpty == true)
              ? patientData.gender!
              : 'Not provided',
        ),
      ],
    );
  }

  Widget _buildContactInformation(PatientModel patientData) {
    return _buildSectionCard(
      title: 'Contact Information',
      icon: Icons.contact_phone_outlined,
      children: [
        _buildDetailRow(
          'Mobile',
          (patientData.mobile?.isNotEmpty == true)
              ? patientData.mobile!
              : 'Not provided',
        ),
        _buildDetailRow(
          'Email',
          (patientData.email?.isNotEmpty == true)
              ? patientData.email!
              : 'Not provided',
        ),
        _buildDetailRow(
          'Address',
          _formatAddress(patientData),
        ),
      ],
    );
  }

  Widget _buildIdentificationSection(PatientModel patientData) {
    return _buildSectionCard(
      title: 'Identification & Documents',
      icon: Icons.badge_outlined,
      children: [
        _buildDetailRow(
          'ID Type',
          (patientData.documentType?.isNotEmpty == true)
              ? patientData.documentType!
              : 'Not provided',
        ),
        _buildDetailRow(
          'ID Number',
          (patientData.documentNumber?.isNotEmpty == true)
              ? patientData.documentNumber!
              : 'Not provided',
        ),
        if (patientData.documents?.isNotEmpty == true) ...[
          const SizedBox(height: 8),
          _buildDocumentsList(patientData.documents!),
        ],
      ],
    );
  }

  Widget _buildPrescriptionRecords(BuildContext context) {
    return _buildRecordsSection(
      title: 'Prescription Records',
      icon: Icons.description_outlined,
      onViewAll: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const AddPrescriptionScreen()));
      },
      records: [
        _buildRecordItem('1. High_feverConsulation_01jjuly23.pdf'),
      ],
    );
  }

  Widget _buildMedicalRecords(BuildContext context) {
    return _buildRecordsSection(
      title: 'Medical Records',
      icon: Icons.history_edu_outlined,
      onViewAll: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const AddMedicalRecordScreen()));
      },
      records: [
        _buildRecordItem('1. X-ray report_28may23.pdf'),
        _buildRecordItem('2. Blood test report_28may23.pdf'),
      ],
    );
  }

  Widget _buildProcedureRecords(BuildContext context) {
    return _buildRecordsSection(
      title: 'Procedure Records',
      icon: Icons.medication_outlined,
      onViewAll: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const ProcedureScreen()));
      },
      records: [
        _buildRecordItem('1. Consulation_01july23.pdf'),
        _buildRecordItem('2. Minor surgery_28may23.pdf'),
      ],
    );
  }

  Widget _buildSectionCard(
      {required String title,
      required IconData icon,
      required List<Widget> children}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFF0F0F0)),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 8,
              offset: const Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: AppColors.greenColor.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, size: 18, color: AppColors.greenColor),
              ),
              const SizedBox(width: 10),
              Text(
                title,
                style: GoogleFonts.urbanist(
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                    color: const Color(0xFF1A1A2E)),
              ),
            ],
          ),
          const SizedBox(height: 14),
          ...children,
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.28,
            child: Text(
              label,
              style: GoogleFonts.urbanist(
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                  color: const Color(0xFF928F9E)),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: const Color(0xFF1A1A2E)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecordsSection(
      {required String title,
      required IconData icon,
      required VoidCallback onViewAll,
      required List<Widget> records}) {
    return _buildSectionCard(
      title: title,
      icon: icon,
      children: [
        ...records,
        const SizedBox(height: 8),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: onViewAll,
            child: Text(
              'View All',
              style: GoogleFonts.urbanist(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.greenColor),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRecordItem(String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFEEEEEE)),
      ),
      child: Row(
        children: [
          const Icon(Icons.insert_drive_file_outlined,
              size: 18, color: AppColors.greenColor),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              title,
              style: GoogleFonts.urbanist(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF1A1A2E)),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const Icon(Icons.find_in_page_outlined,
              size: 16, color: Color(0xFF928F9E)),
        ],
      ),
    );
  }

  Widget _buildDocumentsList(List documents) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Uploaded Documents',
          style: GoogleFonts.urbanist(
              fontWeight: FontWeight.w600,
              fontSize: 13,
              color: const Color(0xFF1A1A2E)),
        ),
        const SizedBox(height: 8),
        ...documents.map((doc) => _buildRecordItem(doc.fileName ?? 'Document')),
      ],
    );
  }

  String _formatAddress(PatientModel patient) {
    if (patient.address == null) return 'Not provided';
    final parts = [
      patient.address?.house,
      patient.address?.street,
      patient.address?.landmarks,
      patient.address?.city,
      patient.address?.pincode,
    ].where((p) => p?.isNotEmpty == true).toList();
    return parts.isNotEmpty ? parts.join(', ') : 'Not provided';
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text('Delete Patient?',
              style: GoogleFonts.urbanist(fontWeight: FontWeight.w700)),
          content: Text(
            'Are you sure you want to delete this patient? This action cannot be undone.',
            style: GoogleFonts.urbanist(fontSize: 14),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel', style: TextStyle(color: Colors.grey[600])),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _deletePatient(widget.patient);
              },
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  void _deletePatient(PatientModel patient) {
    context
        .read<PatientRecordsCubit>()
        .deletePatient(patient.id!)
        .then((value) {
      if (context.read<PatientRecordsCubit>().state.state ==
          PatientRecordsStates.patientDeleted) {
        showSnackbar("Patient deleted successfully", context);
        context.read<PatientRecordsCubit>().fetchPatients();
        Navigator.pop(context);
      } else {
        showSnackbar("An error occurred", context);
      }
    });
  }

  void showAddRecordsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.only(top: 16, bottom: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2)),
              ),
              const SizedBox(height: 16),
              Text(
                'ADD RECORDS',
                style: GoogleFonts.urbanist(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    letterSpacing: 1.2),
              ),
              const SizedBox(height: 16),
              _buildBottomSheetItem(
                icon: Icons.description_outlined,
                text: 'Prescription',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddPrescriptionScreen()));
                },
              ),
              _buildBottomSheetItem(
                icon: Icons.history_edu_outlined,
                text: 'Medical records',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const AddMedicalRecordScreen()));
                },
              ),
              _buildBottomSheetItem(
                icon: Icons.medication_outlined,
                text: 'Procedure records',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProcedureScreen()));
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBottomSheetItem(
      {required IconData icon,
      required String text,
      required VoidCallback onTap}) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: AppColors.greenColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8)),
        child: Icon(icon, color: AppColors.greenColor, size: 20),
      ),
      title: Text(text,
          style:
              GoogleFonts.urbanist(fontWeight: FontWeight.w600, fontSize: 15)),
      onTap: onTap,
    );
  }
}
