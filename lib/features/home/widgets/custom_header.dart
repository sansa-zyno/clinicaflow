import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:clinica_flow/features/auth/model/user_model.dart';
import 'package:clinica_flow/core/constants/app_colors.dart';
import 'package:clinica_flow/core/utils/responsive_layout.dart';

/// Header widget that displays the user's profile picture (loaded from
/// SharedPreferences), a time-of-day greeting, the user's name,
/// and optional action buttons.
class CustomHeader extends StatefulWidget {
  final List<Widget>? actions;

  const CustomHeader({super.key, this.actions});

  @override
  State<CustomHeader> createState() => _CustomHeaderState();
}

class _CustomHeaderState extends State<CustomHeader> {
  UserModel? _user;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final user = await UserModel.getCurrentUser();
    if (mounted) {
      setState(() {
        _user = user;
        _isLoading = false;
      });
    }
  }

  String get _greeting {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good Morning';
    if (hour <= 16) return 'Good Afternoon';
    return 'Good Evening';
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Center(
          child: SizedBox(
            height: 44,
            width: 44,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: AppColors.primaryColor,
            ),
          ),
        ),
      );
    }

    if (_user == null) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Row(
        children: [
          // Profile picture (or placeholder if desktop)
          if (!ResponsiveLayout.isDesktop(context))
            GestureDetector(
              onTap: () => Scaffold.of(context).openDrawer(),
              child: CircleAvatar(
                radius: 22,
                backgroundColor: AppColors.whiteSmoke2,
                backgroundImage: _user!.profilePic.isNotEmpty
                    ? NetworkImage(_user!.profilePic)
                    : null,
                child: _user!.profilePic.isEmpty
                    ? Text(
                        '${_user!.firstName[0]}${_user!.lastName[0]}'
                            .toUpperCase(),
                        style: GoogleFonts.urbanist(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: AppColors.primaryColor,
                        ),
                      )
                    : null,
              ),
            ),
          if (!ResponsiveLayout.isDesktop(context)) const SizedBox(width: 12),

          // Greeting + name
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _greeting,
                  style: GoogleFonts.urbanist(
                    fontSize: 14,
                    color: AppColors.grey,
                  ),
                ),
                Text(
                  '${_user!.title} ${_user!.firstName} ${_user!.lastName}',
                  style: GoogleFonts.urbanist(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: AppColors.eerieBlack,
                  ),
                ),
              ],
            ),
          ),

          // Action buttons
          if (widget.actions != null && widget.actions!.isNotEmpty)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: widget.actions!,
            ),
        ],
      ),
    );
  }
}
