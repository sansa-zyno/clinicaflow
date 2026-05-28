import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:clinica_flow/core/constants/app_colors.dart';
import 'package:clinica_flow/core/network/api_endpoints.dart';
import 'package:clinica_flow/core/utils/enums/route_enums.dart';
import 'package:clinica_flow/core/utils/shared_preferences_service.dart';
import 'package:clinica_flow/features/auth/bloc/login_bloc.dart';
import 'package:clinica_flow/features/auth/model/user_model.dart';
import 'package:clinica_flow/features/notification/viewmodel/notification_cubit.dart';

class DesktopSidebar extends StatefulWidget {
  final StatefulNavigationShell shell;

  const DesktopSidebar({super.key, required this.shell});

  @override
  State<DesktopSidebar> createState() => _DesktopSidebarState();
}

class _DesktopSidebarState extends State<DesktopSidebar> {
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
    if (data != null && data.linkedClinics.isNotEmpty) {
      try {
        selectedClinic = data.linkedClinics
            .firstWhere((element) => element['id'] == clinicId);
      } catch (e) {
        // Fallback if not found
      }
    }
    if (mounted) setState(() {});
  }

  void navigationTapped(int page) {
    if (page == 3) {
      context.read<NotificationCubit>().fetchNotifications();
    }
    widget.shell.goBranch(page);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          right: BorderSide(color: AppColors.grey3, width: 1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Clinic Header Info
          _buildClinicHeader(),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _SectionLabel(label: 'MAIN MENU'),
                  const SizedBox(height: 8),
                  _SidebarItem(
                    iconPath: 'assets/homeimages/Home.png',
                    label: 'Home',
                    isSelected: widget.shell.currentIndex == 0,
                    onTap: () => navigationTapped(0),
                  ),
                  _SidebarItem(
                    iconPath: 'assets/homeimages/Calender.png',
                    label: 'Appointments',
                    isSelected: widget.shell.currentIndex == 1,
                    onTap: () => navigationTapped(1),
                  ),
                  _SidebarItem(
                    iconPath: 'assets/homeimages/whatsapp12.png',
                    label: 'Chat',
                    isSelected: widget.shell.currentIndex == 2,
                    onTap: () => navigationTapped(2),
                  ),
                  _SidebarItem(
                    iconPath: 'assets/homeimages/Notifications.png',
                    label: 'Notifications',
                    isSelected: widget.shell.currentIndex == 3,
                    onTap: () => navigationTapped(3),
                  ),
                  const SizedBox(height: 24),
                  const _SectionDivider(),
                  const SizedBox(height: 24),
                  const _SectionLabel(label: 'CLINIC'),
                  const SizedBox(height: 8),
                  _DrawerMenuItem(
                    icon: Icons.bar_chart_rounded,
                    iconColor: const Color(0xFF1B9C85),
                    iconBgColor: const Color(0xFFE8F5F3),
                    label: 'Analytics',
                    onTap: () {
                      context.pushNamed(AppRoutes.patientAnalysis.name);
                    },
                  ),
                  _DrawerMenuItem(
                    icon: Icons.rocket_launch_outlined,
                    iconColor: const Color(0xFF5351C7),
                    iconBgColor: const Color(0xFFF1E7F9),
                    label: 'Upgrade Plan',
                    onTap: () {},
                  ),
                  const SizedBox(height: 24),
                  const _SectionDivider(),
                  const SizedBox(height: 24),
                  const _SectionLabel(label: 'GENERAL'),
                  const SizedBox(height: 8),
                  _DrawerMenuItem(
                    icon: Icons.settings_outlined,
                    iconColor: const Color(0xFF266A57),
                    iconBgColor: const Color(0xFFE8F5F3),
                    label: 'Settings',
                    onTap: () {
                      context.pushNamed(AppRoutes.myClinicsSetting.name);
                    },
                  ),
                  _DrawerMenuItem(
                    icon: Icons.chat_bubble_outline_rounded,
                    iconColor: const Color(0xFFEF6C00),
                    iconBgColor: const Color(0xFFFFF3E0),
                    label: 'Feedback',
                    onTap: () {
                      context.pushNamed(AppRoutes.feedBack.name);
                    },
                  ),
                ],
              ),
            ),
          ),

          // User Profile Bottom Footer
          _buildUserProfileFooter(),
        ],
      ),
    );
  }

  Widget _buildClinicHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAF9),
        border: Border(
          bottom: BorderSide(color: AppColors.grey3, width: 1),
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.white,
            child: ClipOval(
              child: (selectedClinic?['logo'] ?? '') == ''
                  ? Image.asset(
                      'assets/homeimages/Group 36536.png',
                      height: 36,
                      width: 36,
                      fit: BoxFit.cover,
                    )
                  : Image.network(
                      "${ApiEndPoint.logoBaseUrl}${selectedClinic!['logo']}",
                      height: 36,
                      width: 36,
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  selectedClinic?['clinicName'] ?? 'Clinic Management',
                  style: GoogleFonts.montserrat(
                    color: AppColors.eerieBlack,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                GestureDetector(
                  onTap: () => context.goNamed(AppRoutes.welcome.name),
                  child: Text(
                    'Switch Clinic',
                    style: GoogleFonts.montserrat(
                      color: const Color(0xFF266A57),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserProfileFooter() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: AppColors.grey3, width: 1),
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: AppColors.whiteSmoke2,
            backgroundImage: (userModel?.profilePic ?? '').isNotEmpty
                ? NetworkImage(userModel!.profilePic)
                : null,
            child: (userModel?.profilePic ?? '').isEmpty
                ? Text(
                    '${userModel?.firstName[0] ?? ''}${userModel?.lastName[0] ?? ''}'
                        .toUpperCase(),
                    style: GoogleFonts.urbanist(
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryColor,
                    ),
                  )
                : null,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${userModel?.firstName ?? ''} ${userModel?.lastName ?? ''}',
                  style: GoogleFonts.montserrat(
                    color: AppColors.eerieBlack,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  (userModel?.isSuperAdmin ?? false) ||
                          (userModel?.isDoctor ?? false)
                      ? 'Admin'
                      : 'Staff',
                  style: GoogleFonts.montserrat(
                    color: AppColors.grey,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          PopupMenuButton(
            icon: const Icon(Icons.more_vert, color: AppColors.grey),
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'profile',
                child: Row(
                  children: [
                    const Icon(Icons.person_outline,
                        size: 20, color: Color(0xFF266A57)),
                    const SizedBox(width: 8),
                    Text('Edit Profile',
                        style: GoogleFonts.montserrat(fontSize: 14)),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'logout',
                child: Row(
                  children: [
                    const Icon(Icons.logout, size: 20, color: Colors.red),
                    const SizedBox(width: 8),
                    Text('Logout',
                        style: GoogleFonts.montserrat(
                            fontSize: 14, color: Colors.red)),
                  ],
                ),
              ),
            ],
            onSelected: (value) {
              if (value == 'profile') {
                context.pushNamed(AppRoutes.editProfile.name);
              } else if (value == 'logout') {
                context.read<LoginBloc>().add(LoginRestartEvent());
              }
            },
          ),
        ],
      ),
    );
  }
}

class _SidebarItem extends StatelessWidget {
  final String iconPath;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _SidebarItem({
    required this.iconPath,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: isSelected ? const Color(0xFFE8F5F3) : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              children: [
                SizedBox(
                  width: 20,
                  height: 20,
                  child: ImageIcon(
                    AssetImage(iconPath),
                    color:
                        isSelected ? const Color(0xff03BF9C) : AppColors.grey,
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  label,
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                    color:
                        isSelected ? const Color(0xFF266A57) : AppColors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String label;
  const _SectionLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 8, bottom: 4),
      child: Text(
        label,
        style: GoogleFonts.montserrat(
          color: AppColors.grey.withOpacity(0.7),
          fontSize: 11,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}

class _SectionDivider extends StatelessWidget {
  const _SectionDivider();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      color: AppColors.grey3,
    );
  }
}

class _DrawerMenuItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color iconBgColor;
  final String label;
  final VoidCallback onTap;

  const _DrawerMenuItem({
    required this.icon,
    required this.iconColor,
    required this.iconBgColor,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: iconBgColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(icon, color: iconColor, size: 18),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    label,
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.eerieBlack,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
