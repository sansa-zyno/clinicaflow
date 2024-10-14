import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'edit_profile_screen.dart';

class EditProfiles extends StatefulWidget {
  const EditProfiles({super.key});

  @override
  State<EditProfiles> createState() => _EditProfilesState();
}

class _EditProfilesState extends State<EditProfiles> {
  final PageController pageController = PageController(initialPage: 0);
  int currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        automaticallyImplyLeading: false,
        actions: [
          if (currentPageIndex > 1)
            TextButton(
              onPressed: () {},
              child: const Text(
                'Skip',
                style: TextStyle(color: Color(0XFF4646B5)),
              ),
            ),
          if (currentPageIndex > 1)
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.more_vert),
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SmoothPageIndicator(
                controller: pageController,
                count: 3,
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
              height: 10,
            ),
            Expanded(
              child: PageView(
                controller: pageController,
                scrollDirection: Axis.horizontal,
                onPageChanged: (index) {
                  setState(() {
                    currentPageIndex = index;
                  });
                },
                children: [
                  EditProfileScreens(
                    pageController: pageController,
                  ),
                  // EditContactScreen(
                  //   pageController: pageController,
                  // ),
                  // EditDocumentScreen(
                  //   pageController: pageController,
                  // ),
                ],
              ),
            ),
            // const SizedBox(
            //   height: 5,
            // ),
          ],
        ),
      ),
    );
  }
}
