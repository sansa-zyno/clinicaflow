import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:clinica_flow/features/team/viewmodel/staff_detail_cubit.dart';
import 'package:clinica_flow/features/team/state/staff_detail_state.dart';
import 'package:clinica_flow/features/team/model/staff_model.dart';
import '../../../core/constants/app_colors.dart';
import 'package:intl/intl.dart';
import '../../../shared/ui/member/edit/edit_personal_detail_screen.dart';

class TeamRecordsScreen extends StatefulWidget {
  final StaffModel data;
  const TeamRecordsScreen({super.key, required this.data});

  @override
  State<TeamRecordsScreen> createState() => _TeamRecordsScreenState();
}

class _TeamRecordsScreenState extends State<TeamRecordsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<StaffDetailCubit>().fetchData(widget.data.id!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFBFC),
      appBar: _buildAppBar(),
      body: BlocBuilder<StaffDetailCubit, StaffDetailState>(
        builder: (context, state) {
          if (state is StaffDetailLoadingState) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.greenColor),
            );
          }

          StaffModel? staffData;
          if (state is StaffDetailLoadedState) {
            staffData = state.data;
          }

          if (staffData == null) {
            return _buildErrorState();
          }

          return _buildContent(staffData);
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
        'Team Records',
        style: GoogleFonts.urbanist(fontWeight: FontWeight.w600, fontSize: 20),
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
          onPressed: () {},
          icon: const Icon(Icons.more_vert_rounded),
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
            'Unable to load staff details',
            style: GoogleFonts.urbanist(fontSize: 16, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(StaffModel staffData) {
    final role = _getStaffRole(staffData);
    final badgeColor = _getRoleBadgeColor(role);
    final fullName =
        '${staffData.firstName ?? ''} ${staffData.lastName ?? ''}'.trim();

    return SingleChildScrollView(
      child: Column(
        children: [
          _buildProfileHeader(staffData, role, badgeColor, fullName),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                _buildPersonalDetails(staffData),
                const SizedBox(height: 12),
                _buildContactInformation(staffData),
                const SizedBox(height: 12),
                _buildBankDetails(staffData),
                const SizedBox(height: 12),
                _buildIdentificationSection(staffData),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHeader(
      StaffModel staffData, String role, Color badgeColor, String fullName) {
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
              _buildProfileAvatar(staffData, badgeColor, fullName),
              const SizedBox(width: 16),
              _buildProfileInfo(staffData, role, badgeColor, fullName),
            ],
          ),
          const SizedBox(height: 16),
          _buildProfileActions(staffData),
        ],
      ),
    );
  }

  Widget _buildProfileAvatar(
      StaffModel staffData, Color badgeColor, String fullName) {
    final hasProfilePic = staffData.profilepic?.isNotEmpty == true;
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: badgeColor.withOpacity(0.3), width: 2),
      ),
      child: CircleAvatar(
        radius: 40,
        backgroundColor: badgeColor.withOpacity(0.1),
        backgroundImage:
            hasProfilePic ? NetworkImage(staffData.profilepic!) : null,
        child: !hasProfilePic
            ? Text(
                _getInitials(fullName),
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
      StaffModel staffData, String role, Color badgeColor, String fullName) {
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
              role,
              style: GoogleFonts.urbanist(
                  fontSize: 12, fontWeight: FontWeight.w600, color: badgeColor),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            fullName.isNotEmpty ? fullName : 'Unnamed Staff',
            style: GoogleFonts.urbanist(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF1A1A2E)),
          ),
          if (staffData.specialization?.isNotEmpty == true) ...[
            const SizedBox(height: 4),
            _buildSpecializationRow(staffData.specialization!, badgeColor),
          ],
        ],
      ),
    );
  }

  Widget _buildSpecializationRow(String specialization, Color badgeColor) {
    return Row(
      children: [
        Icon(Icons.medical_services_outlined,
            size: 14, color: badgeColor.withOpacity(0.7)),
        const SizedBox(width: 4),
        Flexible(
          child: Text(
            specialization,
            style: GoogleFonts.urbanist(
                fontSize: 13, fontWeight: FontWeight.w500, color: badgeColor),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildProfileActions(StaffModel staffData) {
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
                    isAdmin: staffData.isDoctor ?? false,
                    forStaff: true,
                    staff: staffData,
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _buildProfileAction(
            icon: Icons.phone_rounded,
            label: 'Call',
            color: const Color(0xFF2E86AB),
            onTap: () {},
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _buildProfileAction(
            icon: Icons.mail_rounded,
            label: 'Email',
            color: const Color(0xFF6B5B95),
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

  Widget _buildPersonalDetails(StaffModel staffData) {
    return _buildSectionCard(
      title: 'Personal Details',
      icon: Icons.person_outline_rounded,
      children: [
        _buildDetailRow(
          'Date of Birth',
          staffData.birthday != null
              ? DateFormat('dd MMM, yyyy').format(staffData.birthday!)
              : 'Not provided',
        ),
        _buildDetailRow(
          'Age',
          staffData.age != null ? '${staffData.age} years' : 'Not provided',
        ),
        _buildDetailRow(
          'Gender',
          (staffData.gender?.isNotEmpty == true)
              ? staffData.gender!
              : 'Not provided',
        ),
      ],
    );
  }

  Widget _buildContactInformation(StaffModel staffData) {
    return _buildSectionCard(
      title: 'Contact Information',
      icon: Icons.contact_phone_outlined,
      children: [
        _buildDetailRow(
          'Mobile',
          (staffData.mobile?.isNotEmpty == true)
              ? staffData.mobile!
              : 'Not provided',
        ),
        _buildDetailRow(
          'Email',
          (staffData.email?.isNotEmpty == true)
              ? staffData.email!
              : 'Not provided',
        ),
        _buildDetailRow(
          'Address',
          _formatAddress(staffData),
        ),
      ],
    );
  }

  Widget _buildBankDetails(StaffModel staffData) {
    return _buildSectionCard(
      title: 'Bank Details',
      icon: Icons.account_balance_outlined,
      children: [
        _buildDetailRow(
          'Bank Name',
          (staffData.bankName?.isNotEmpty == true)
              ? staffData.bankName!
              : 'Not provided',
        ),
        _buildDetailRow(
          'Account Name',
          (staffData.accountName?.isNotEmpty == true)
              ? staffData.accountName!
              : 'Not provided',
        ),
        _buildDetailRow(
          'Account No.',
          (staffData.accountNo?.isNotEmpty == true)
              ? staffData.accountNo!
              : 'Not provided',
        ),
      ],
    );
  }

  Widget _buildIdentificationSection(StaffModel staffData) {
    return _buildSectionCard(
      title: 'Identification',
      icon: Icons.badge_outlined,
      children: [
        _buildDetailRow(
          'ID Type',
          (staffData.documentType?.isNotEmpty == true)
              ? staffData.documentType!
              : 'Not provided',
        ),
        _buildDetailRow(
          'ID Number',
          (staffData.documentNumber?.isNotEmpty == true)
              ? staffData.documentNumber!
              : 'Not provided',
        ),
        if (staffData.documents?.isNotEmpty == true) ...[
          const SizedBox(height: 8),
          _buildDocumentsList(staffData.documents!),
        ],
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
              style: GoogleFonts.urbanist(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: const Color(0xFF1A1A2E)),
            ),
          ),
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
        ...documents
            .map((doc) => _buildDocumentItem(doc.fileName ?? 'Document')),
      ],
    );
  }

  Widget _buildDocumentItem(String fileName) {
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
              fileName,
              style: GoogleFonts.urbanist(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF1A1A2E)),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const Icon(Icons.open_in_new_rounded,
              size: 16, color: Color(0xFF928F9E)),
        ],
      ),
    );
  }

  String _formatAddress(StaffModel staff) {
    if (staff.address == null) return 'Not provided';
    final parts = [
      staff.address?.house,
      staff.address?.street,
      staff.address?.landmarks,
      staff.address?.city,
      staff.address?.pincode,
    ].where((p) => p?.isNotEmpty == true).toList();
    return parts.isNotEmpty ? parts.join(', ') : 'Not provided';
  }

  String _getInitials(String name) {
    final parts = name.trim().split(' ');
    if (parts.isEmpty || parts.first.isEmpty) return '?';
    if (parts.length == 1) return parts.first[0].toUpperCase();
    return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
  }

  String _getStaffRole(StaffModel staff) {
    if (staff.isDoctor == true) {
      final spec = (staff.specialization ?? '').toLowerCase();
      if (spec.contains('nurse') || spec.contains('nursing')) return 'Nurse';
      return 'Doctor';
    }
    return 'Staff';
  }

  Color _getRoleBadgeColor(String role) {
    switch (role) {
      case 'Doctor':
        return const Color(0xFF1B7A5A);
      case 'Nurse':
        return const Color(0xFF2E86AB);
      default:
        return const Color(0xFF6B5B95);
    }
  }
}
