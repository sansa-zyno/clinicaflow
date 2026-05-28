import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:clinica_flow/features/auth/bloc/login_bloc.dart';
import 'package:clinica_flow/core/network/api_endpoints.dart';
import 'package:clinica_flow/core/constants/app_colors.dart';
import 'package:clinica_flow/features/auth/model/user_model.dart';
import 'package:clinica_flow/core/utils/shared_preferences_service.dart';
import 'package:clinica_flow/core/utils/enums/route_enums.dart';

class DrawerMenu extends StatefulWidget {
  const DrawerMenu({super.key});

  @override
  State<DrawerMenu> createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  UserModel? userModel;
  Map? selectedClinic;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    var data = await UserModel.getCurrentUser();
    userModel = data;

    String clinicId = await SharedPrefService.getClinicId() ?? "";
    selectedClinic = data?.linkedClinics
        .where((element) => element['id'] == clinicId)
        .toList()[0];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // ── Profile Header ──
          _buildProfileHeader(context),

          // ── Scrollable Menu Body ──
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Clinic Section ──
                  const _SectionLabel(label: 'CLINIC'),
                  const SizedBox(height: 4),
                  _DrawerMenuItem(
                    icon: Icons.bar_chart_rounded,
                    iconColor: const Color(0xFF1B9C85),
                    iconBgColor: const Color(0xFFE8F5F3),
                    label: 'Analytics',
                    onTap: () {
                      context.pop();
                      context.pushNamed(AppRoutes.patientAnalysis.name);
                    },
                  ),
                  _DrawerMenuItem(
                    icon: Icons.rocket_launch_outlined,
                    iconColor: const Color(0xFF5351C7),
                    iconBgColor: const Color(0xFFF1E7F9),
                    label: 'Upgrade Plan',
                    onTap: () {
                      context.pop();
                    },
                  ),

                  const SizedBox(height: 8),
                  const _SectionDivider(),
                  const SizedBox(height: 12),

                  // ── General Section ──
                  const _SectionLabel(label: 'GENERAL'),
                  const SizedBox(height: 4),
                  _DrawerMenuItem(
                    icon: Icons.settings_outlined,
                    iconColor: const Color(0xFF266A57),
                    iconBgColor: const Color(0xFFE8F5F3),
                    label: 'Settings',
                    onTap: () {
                      context.pop();
                      context.pushNamed(AppRoutes.myClinicsSetting.name);
                    },
                  ),
                  _DrawerMenuItem(
                    icon: Icons.help_outline_rounded,
                    iconColor: const Color(0xFF0288D1),
                    iconBgColor: const Color(0xFFE1F5FE),
                    label: 'Help & Support',
                    onTap: () {
                      context.pop();
                    },
                  ),
                  _DrawerMenuItem(
                    icon: Icons.chat_bubble_outline_rounded,
                    iconColor: const Color(0xFFEF6C00),
                    iconBgColor: const Color(0xFFFFF3E0),
                    label: 'Feedback',
                    onTap: () {
                      context.pop();
                      context.pushNamed(AppRoutes.feedBack.name);
                    },
                  ),

                  const SizedBox(height: 8),
                  const _SectionDivider(),
                  const SizedBox(height: 12),

                  // ── Account Section ──
                  const _SectionLabel(label: 'ACCOUNT'),
                  const SizedBox(height: 4),
                  _DrawerMenuItem(
                    icon: Icons.person_outline_rounded,
                    iconColor: const Color(0xFF266A57),
                    iconBgColor: const Color(0xFFE8F5F3),
                    label: 'Edit Profile',
                    onTap: () {
                      context.pop();
                      context.pushNamed(AppRoutes.editProfile.name);
                    },
                  ),
                  _DrawerMenuItem(
                    icon: Icons.logout_rounded,
                    iconColor: const Color(0xFFD32F2F),
                    iconBgColor: const Color(0xFFFFEBEE),
                    label: 'Logout',
                    isDestructive: true,
                    onTap: () => _showLogoutDialog(context),
                  ),
                ],
              ),
            ),
          ),

          // ── Footer ──
          _buildFooter(context),
        ],
      ),
    );
  }

  // ── Profile Header ────────────────────────────────────────────────

  Widget _buildProfileHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF266A57),
            Color(0xFF1B9C85),
            Color(0xFF52CFAC),
          ],
          stops: [0.0, 0.5, 1.0],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 16, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Close button
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () => context.pop(),
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.close_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 8),

              // Avatar + Info row
              Row(
                children: [
                  // Avatar
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2.5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      radius: 38,
                      backgroundColor: Colors.white,
                      child: ClipOval(
                        child: (userModel?.profilePic ?? '') == ''
                            ? Image.asset(
                                'assets/homeimages/Ellipse 760 (2).png',
                                height: 72,
                                width: 72,
                                fit: BoxFit.cover,
                              )
                            : Image.network(
                                userModel!.profilePic,
                                height: 72,
                                width: 72,
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),

                  // Name, specialization, role
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Role badge
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.4),
                            ),
                          ),
                          child: Text(
                            (userModel?.isSuperAdmin ?? false) ||
                                    (userModel?.isDoctor ?? false)
                                ? 'Admin'
                                : 'Staff',
                            style: GoogleFonts.montserrat(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),

                        // User name
                        Text(
                          '${userModel?.title ?? ''} ${userModel?.firstName ?? ''} ${userModel?.lastName ?? ''}',
                          style: GoogleFonts.montserrat(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),

                        // Specialization
                        if (userModel?.specialization != null) ...[
                          const SizedBox(height: 2),
                          Text(
                            userModel!.specialization!,
                            style: GoogleFonts.montserrat(
                              color: Colors.white.withOpacity(0.85),
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),

              // Clinic info row
              if (selectedClinic != null) ...[
                const SizedBox(height: 20),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.2),
                    ),
                  ),
                  child: Row(
                    children: [
                      // Clinic logo
                      CircleAvatar(
                        radius: 16,
                        backgroundColor: Colors.white,
                        child: ClipOval(
                          child: (selectedClinic!['logo'] ?? '') == ''
                              ? Image.asset(
                                  'assets/homeimages/Group 36536.png',
                                  height: 28,
                                  width: 28,
                                  fit: BoxFit.cover,
                                )
                              : Image.network(
                                  "${ApiEndPoint.logoBaseUrl}${selectedClinic!['logo']}",
                                  height: 28,
                                  width: 28,
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                      const SizedBox(width: 10),

                      // Clinic name
                      Expanded(
                        child: Text(
                          selectedClinic!['clinicName'] ?? '',
                          style: GoogleFonts.montserrat(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),

                      // Switch clinic button
                      GestureDetector(
                        onTap: () {
                          context.goNamed(AppRoutes.welcome.name);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            'Switch',
                            style: GoogleFonts.montserrat(
                              color: const Color(0xFF266A57),
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  // ── Footer ────────────────────────────────────────────────────────

  Widget _buildFooter(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
      child: Column(
        children: [
          // Legal links
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {},
                child: Text(
                  'Privacy Policy',
                  style: GoogleFonts.montserrat(
                    color: AppColors.grey,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Container(
                  width: 4,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.grey.withOpacity(0.5),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Text(
                  'Terms of Service',
                  style: GoogleFonts.montserrat(
                    color: AppColors.grey,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // App version
          Text(
            'v1.0.0',
            style: GoogleFonts.montserrat(
              color: AppColors.grey.withOpacity(0.5),
              fontSize: 11,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  // ── Logout Dialog ─────────────────────────────────────────────────

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Icon
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFEBEE),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.logout_rounded,
                    color: Color(0xFFD32F2F),
                    size: 28,
                  ),
                ),
                const SizedBox(height: 16),

                // Title
                Text(
                  'Logout',
                  style: GoogleFonts.montserrat(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF110C2C),
                  ),
                ),
                const SizedBox(height: 8),

                // Description
                Text(
                  'Are you sure you want to log out of your account?',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.grey,
                  ),
                ),
                const SizedBox(height: 24),

                // Buttons
                Row(
                  children: [
                    // Cancel
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.of(dialogContext).pop(),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          side: BorderSide(color: AppColors.grey3),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'Cancel',
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF110C2C),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Logout
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(dialogContext).pop();
                          context.read<LoginBloc>().add(LoginRestartEvent());
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFD32F2F),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'Logout',
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// ── Helper Widgets ────────────────────────────────────────────────────

/// A labeled section header for grouping drawer items.
class _SectionLabel extends StatelessWidget {
  final String label;
  const _SectionLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, top: 8, bottom: 4),
      child: Text(
        label,
        style: GoogleFonts.montserrat(
          color: AppColors.grey.withOpacity(0.7),
          fontSize: 11,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}

/// A thin horizontal divider between menu sections.
class _SectionDivider extends StatelessWidget {
  const _SectionDivider();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      color: AppColors.grey3,
    );
  }
}

/// A single drawer menu item with icon, label, and trailing chevron.
class _DrawerMenuItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color iconBgColor;
  final String label;
  final VoidCallback onTap;
  final bool isDestructive;

  const _DrawerMenuItem({
    required this.icon,
    required this.iconColor,
    required this.iconBgColor,
    required this.label,
    required this.onTap,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 12),
            child: Row(
              children: [
                // Icon container
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: iconBgColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: iconColor, size: 20),
                ),
                const SizedBox(width: 14),

                // Label
                Expanded(
                  child: Text(
                    label,
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: isDestructive
                          ? const Color(0xFFD32F2F)
                          : const Color(0xFF110C2C),
                    ),
                  ),
                ),

                // Trailing chevron
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 16,
                  color: isDestructive
                      ? const Color(0xFFD32F2F).withOpacity(0.4)
                      : AppColors.grey.withOpacity(0.4),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
