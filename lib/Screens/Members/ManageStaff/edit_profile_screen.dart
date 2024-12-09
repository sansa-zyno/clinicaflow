/*import 'package:flutter/material.dart';
import 'package:healtether_clinic_app/Screens/Members/edit_personal_detail_screen.dart';
import 'package:healtether_clinic_app/constants/constants.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final PageController pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back),
            ),
            const Text(AppText.editProfile),
          ],
        ),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.only(left: 14, right: 14, top: 6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SmoothPageIndicator(
                  controller: pageController,
                  count: 4,
                  effect: const ExpandingDotsEffect(
                      expansionFactor: 5,
                      dotColor: Color(0XFF5351C7),
                      strokeWidth: 3,
                      dotHeight: 8,
                      dotWidth: 8,
                      paintStyle: PaintingStyle.fill),
                ),
              ),
              const SizedBox(
                height: 0,
              ),
              Expanded(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: PageView(
                    controller: pageController,
                    scrollDirection: Axis.horizontal,
                    children: [
                      EditPersonalDetailScreen(
                        pageController: pageController,
                      ),
                      // EditContactDetailScreen(
                      //   pageController: pageController,
                      // ),
                      // EditDocumentScreen(
                      //   pageController: pageController,
                      // ),
                      // EditPaymentDetailScreen(
                      //   pageController: pageController,
                      // ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}*/
