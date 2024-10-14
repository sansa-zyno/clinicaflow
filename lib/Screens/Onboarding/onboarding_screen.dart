import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healtether_clinic_app/widgets/components/onboard_page_component.dart';
import 'package:healtether_clinic_app/utils/enums/route_enums.dart';
import 'package:healtether_clinic_app/utils/helper_functions/log.dart';
import 'package:healtether_clinic_app/utils/mixins/device_info_mixin.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> with DeviceInfoMixin {
  int currentPage = 0;

  late List<Widget> pages = [
    OnboardPage(
      title: 'Comprehensive Digital Clinic Management.',
      subtitle:
          'A robust platform for doctors  for appointment scheduling, patient record management, billing, and telemedicine capabilities',
      backgroundAsset: 'assets/svg/onboarding1.svg',
      assetLeft: screenDimensions(context).height * 0.0225,
      assetTop: screenDimensions(context).height * 0.176,
      assetRight: 0,
    ),
    OnboardPage(
      title: 'Customizable Staff Access Control',
      subtitle:
          'You can now add staff to their digital clinic and assign specific roles ensuring that each team member has access to only the features they need, increasing your efficiency.',
      backgroundAsset: 'assets/svg/onboarding2.svg',
      assetLeft: 0,
      assetTop: screenDimensions(context).height * 0.1285,
      assetRight: 0,
      // assetBottom: screenDimensions(context).height * 0.5,
    ),
    OnboardPage(
      title: 'AI-Enhanced Diagnosis Assistance',
      subtitle:
          'Integrated advanced AI algorithms to assist you to speed up the diagnosis process, allowing for more timely treatments and improved patient outcomes.',
      backgroundAsset: 'assets/svg/onboarding3.svg',
      assetTop: screenDimensions(context).height * 0.125,
      assetBottom: screenDimensions(context).height * 0.25,
      assetLeft: 0,
      assetRight: 0,
    ),
  ];

  late PageController _controller;

  @override
  void initState() {
    super.initState();

    _controller = PageController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.center,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFFFFFFF),
                  Color(0xFF85F8D5),
                  Color(0xFF53CFAC),
                ],
                stops: [0.0, 0.48, 1.0],
              ),
            ),
          ),
          Positioned(
            top: 70,
            left: 0,
            right: 0,
            child: SvgPicture.asset("assets/svg/icon/logo2.svg"),
          ),
          PageView.builder(
              controller: _controller,
              onPageChanged: (value) {
                setState(() {
                  currentPage = value;
                });
              },
              itemCount: pages.length,
              itemBuilder: (context, index) {
                return pages[index];
              }),
          Positioned(
            bottom: screenDimensions(context).height * 0.15,
            // left: screenDimensions.width * 0.5,
            child: Column(
              children: [
                // const SizedBox(
                //   height: 20,
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(pages.length, (index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(2),
                          color: index == currentPage
                              ? const Color(0xff266A57)
                              : Colors.white,
                        ),
                      ),
                    );
                  }),
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    if (currentPage != pages.length - 1) {
                      log('animate to next page');
                      _controller.animateToPage(currentPage + 1,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut);
                    } else {
                      log('animate to login');
                      context.goNamed(AppRoutes.login.name);
                    }
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Arrow icon
                      Container(
                        width: 50,
                        height: 50,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF266A57), // Circle color with opacity
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward,
                        size: 40,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
