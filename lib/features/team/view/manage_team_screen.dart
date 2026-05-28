import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:clinica_flow/shared/ui/member/add/personal_detail_screen.dart';
import 'package:clinica_flow/features/team/viewmodel/staff_cubit.dart';
import 'package:clinica_flow/features/team/view/team_records_screen.dart';
import 'package:clinica_flow/features/team/model/staff_model.dart';
import '../../../core/constants/app_colors.dart';
import 'package:clinica_flow/core/utils/enums/bloc_enums.dart';
import 'package:clinica_flow/core/utils/mixins/app_bar_mixin.dart';
import 'package:clinica_flow/core/utils/snackbar.dart';

class ManageTeamScreen extends StatefulWidget {
  const ManageTeamScreen({super.key});

  @override
  State<ManageTeamScreen> createState() => _ManageTeamScreenState();
}

class _ManageTeamScreenState extends State<ManageTeamScreen> with AppBarMixin {
  String selectedFilter = 'All';
  List<StaffModel>? searchResult;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<StaffCubit>().fetchStaffs();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        context,
        title: "Manage Team",
        showDefaultActions: false,
      ),
      body: BlocBuilder<StaffCubit, StaffState>(
        builder: (context, state) {
          final bool isLoading = state.state == StaffStates.fetchingStaff ||
              state.state == StaffStates.initial;
          final bool isProcessing = state.state == StaffStates.deletingStaff ||
              state.state == StaffStates.creatingStaff;

          return Stack(
            children: [
              _buildMainContent(state, isLoading),
              if (isProcessing)
                const Center(child: CircularProgressIndicator()),
              _buildAddMemberButton(),
            ],
          );
        },
      ),
    );
  }

  Widget _buildMainContent(StaffState state, bool isLoading) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: _buildSearchBar(state),
        ),
        const SizedBox(height: 16),
        _buildFilterChips(),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: _buildStaffCount(state),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: _buildStaffList(state, isLoading),
        ),
        const SizedBox(height: 90),
      ],
    );
  }

  Widget _buildSearchBar(StaffState state) {
    return TextField(
      controller: _searchController,
      decoration: InputDecoration(
        fillColor: const Color(0xFFF5F5F5),
        filled: true,
        hintText: 'Search',
        hintStyle: GoogleFonts.montserrat(
          color: Colors.grey,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide.none,
        ),
        suffixIcon: const Icon(Icons.search, color: Colors.grey),
      ),
      onChanged: (query) => _onSearchChanged(query, state),
    );
  }

  void _onSearchChanged(String query, StaffState state) {
    if (query.isEmpty) {
      setState(() => searchResult = null);
    } else {
      final filtered = state.staffList?.where((e) {
            final firstNameMatch = e.firstName
                    ?.toLowerCase()
                    .trim()
                    .startsWith(query.toLowerCase()) ??
                false;
            final lastNameMatch = e.lastName
                    ?.toLowerCase()
                    .trim()
                    .startsWith(query.toLowerCase()) ??
                false;
            return firstNameMatch || lastNameMatch;
          }).toList() ??
          [];
      setState(() => searchResult = filtered);
    }
  }

  Widget _buildStaffCount(StaffState state) {
    final filteredStaff = _getFilteredList(state);
    if (filteredStaff.isEmpty) return const SizedBox.shrink();

    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        'All ${filteredStaff.length} team members are listed',
        style: GoogleFonts.roboto(
          textStyle: const TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w400,
            height: 15.6 / 13,
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  Widget _buildFilterChips() {
    return Container(
      height: 38,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _FilterChip(
            text: 'All',
            isSelected: selectedFilter == 'All',
            onTap: () => setState(() => selectedFilter = 'All'),
          ),
          _FilterChip(
            text: 'Admin',
            isSelected: selectedFilter == 'Admin',
            onTap: () => setState(() => selectedFilter = 'Admin'),
          ),
          _FilterChip(
            text: 'Doctors',
            isSelected: selectedFilter == 'Doctors',
            onTap: () => setState(() => selectedFilter = 'Doctors'),
          ),
          _FilterChip(
            text: 'Staff',
            isSelected: selectedFilter == 'Staff',
            onTap: () => setState(() => selectedFilter = 'Staff'),
          ),
        ],
      ),
    );
  }

  Widget _buildStaffList(StaffState state, bool isLoading) {
    if (isLoading) return const Center(child: CircularProgressIndicator());

    final filteredStaff = _getFilteredList(state);
    if (filteredStaff.isEmpty) {
      return const Center(child: Text('No data found.'));
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      itemCount: filteredStaff.length,
      itemBuilder: (context, index) => _buildStaffCard(filteredStaff[index]),
    );
  }

  Widget _buildStaffCard(StaffModel staff) {
    final badge = _getStaffBadge(staff);
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => TeamRecordsScreen(data: staff)),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.only(bottom: 6.0),
        decoration: BoxDecoration(
          color: const Color(0xffF5F5F5),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${staff.firstName ?? ''} ${staff.lastName ?? ''}'
                            .trim(),
                        style: GoogleFonts.montserrat(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        staff.mobile ?? '',
                        style: GoogleFonts.montserrat(
                          fontSize: 11,
                          color: Colors.grey,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                _buildRoleBadge(badge),
              ],
            ),
            const SizedBox(height: 15),
            _buildStaffCardFooter(staff),
          ],
        ),
      ),
    );
  }

  Widget _buildRoleBadge(String badge) {
    return Container(
      height: 35,
      width: 85,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF32856E),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Center(
        child: Text(
          badge,
          style: GoogleFonts.montserrat(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildStaffCardFooter(StaffModel staff) {
    return Row(
      children: [
        Text(
          staff.specialization ?? '',
          style: GoogleFonts.montserrat(
            fontSize: 12,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        const Spacer(),
        _buildActionIcons(staff),
      ],
    );
  }

  Widget _buildActionIcons(StaffModel staff) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const Padding(
          padding: EdgeInsets.only(right: 10),
          child: Icon(Icons.mail_outline, size: 20),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Image.asset(
            "assets/homeimages/whatsapp.png",
            color: const Color(0xFF110C2C),
            height: 26,
            width: 26,
          ),
        ),
        InkWell(
          onTap: () => _showDeleteDialog(staff),
          child: const Icon(Icons.delete, size: 20),
        ),
      ],
    );
  }

  Widget _buildAddMemberButton() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: InkWell(
        onTap: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (BuildContext context) => const SelectStaffType(),
          );
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          height: 52,
          decoration: BoxDecoration(
            color: AppColors.greenColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 1.5),
                ),
                child: const Icon(Icons.add, color: Colors.white, size: 16),
              ),
              const SizedBox(width: 8),
              Text(
                "Add member",
                style: GoogleFonts.urbanist(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getStaffBadge(StaffModel staff) {
    if (staff.isDoctor == true) {
      final spec = (staff.specialization ?? '').toLowerCase();
      if (spec.contains('admin')) return 'Admin';
      return 'Doctor';
    }
    return 'Staff';
  }

  List<StaffModel> _getFilteredList(StaffState state) {
    final baseList = searchResult ?? state.staffList ?? [];
    if (selectedFilter == 'All') return baseList;

    return baseList.where((staff) {
      final badge = _getStaffBadge(staff);
      switch (selectedFilter) {
        case 'Admin':
          return badge == 'Admin';
        case 'Doctors':
          return badge == 'Doctor';
        case 'Staff':
          return badge == 'Staff';
        default:
          return true;
      }
    }).toList();
  }

  void _showDeleteDialog(StaffModel staff) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Column(
            children: [
              const Text(
                'Do you want to delete the staff from the directory?',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
              const SizedBox(height: 6),
              const Text(
                'The staff details will be deleted permanently.',
                style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              style: TextButton.styleFrom(
                backgroundColor: const Color(0xff32856E),
                minimumSize: const Size(110, 50),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0)),
              ),
              child: const Text('No', style: TextStyle(color: Colors.white)),
            ),
            TextButton(
              onPressed: () {
                _deleteStaff(staff);
                Navigator.pop(context);
              },
              style: TextButton.styleFrom(
                backgroundColor: const Color(0xFFF5F5F5),
                minimumSize: const Size(110, 50),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0)),
              ),
              child: const Text('Yes', style: TextStyle(color: Colors.black)),
            ),
          ],
        );
      },
    );
  }

  void _deleteStaff(StaffModel staff) {
    context.read<StaffCubit>().deleteStaff(staff.id!).then((value) {
      if (context.read<StaffCubit>().state.state == StaffStates.staffDeleted) {
        showSnackbar("Staff deleted successfully", context);
        context.read<StaffCubit>().fetchStaffs();
      } else {
        showSnackbar("An error occurred", context);
      }
    });
  }
}

class _FilterChip extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterChip(
      {required this.text, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color:
                isSelected ? const Color(0xFF52CFAC) : const Color(0xffF5F5F5),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              text,
              style: GoogleFonts.urbanist(
                textStyle: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: isSelected
                      ? const Color(0xff0C091F)
                      : const Color(0xff928F9E),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SelectStaffType extends StatelessWidget {
  const SelectStaffType({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2)),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'SELECT ROLE',
            style: GoogleFonts.urbanist(
              fontSize: 14,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.2,
              color: const Color(0xFF6B7280),
            ),
          ),
          const SizedBox(height: 16),
          _buildRoleOption(
            context,
            icon: Icons.admin_panel_settings_outlined,
            title: 'Admin',
            description:
                'Full clinic management, staff controls, and analytics access.',
            color: const Color(0xFF6366F1),
            onTap: () => _navigateToCreate(context, isAdmin: true),
          ),
          const SizedBox(height: 12),
          _buildRoleOption(
            context,
            icon: Icons.medical_services_outlined,
            title: 'Doctor',
            description:
                'Clinical access: Patient records, prescriptions, and consultations.',
            color: const Color(0xFF10B981),
            onTap: () => _navigateToCreate(context, isAdmin: true),
          ),
          const SizedBox(height: 12),
          _buildRoleOption(
            context,
            icon: Icons.people_outline_rounded,
            title: 'Staff',
            description:
                'Operations access: Scheduling, billing, and front-desk management.',
            color: const Color(0xFF3B82F6),
            onTap: () => _navigateToCreate(context, isAdmin: false),
          ),
        ],
      ),
    );
  }

  Widget _buildRoleOption(BuildContext context,
      {required IconData icon,
      required String title,
      required String description,
      required Color color,
      required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE5E7EB)),
          color: color.withOpacity(0.02),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12)),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.urbanist(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF111827)),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: GoogleFonts.urbanist(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF6B7280),
                        height: 1.4),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Icon(Icons.chevron_right_rounded, color: Colors.grey[400]),
          ],
        ),
      ),
    );
  }

  void _navigateToCreate(BuildContext context, {required bool isAdmin}) {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              PersonalDetailScreen(isAdmin: isAdmin, forStaff: true)),
    );
  }
}
