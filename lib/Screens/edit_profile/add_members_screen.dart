import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'edit_profile_screen.dart';

class AddMembersScreen extends StatefulWidget {
  const AddMembersScreen({super.key});

  @override
  State<AddMembersScreen> createState() => _AddMembersScreenState();
}

class _AddMembersScreenState extends State<AddMembersScreen> {
  final PageController pageController = PageController(initialPage: 0);
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add member'),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        automaticallyImplyLeading: false,
        // actions: [
        //   if (currentPageIndex > 1)
        //     TextButton(
        //       onPressed: () {},
        //       child: const Text(
        //         'Skip',
        //         style: TextStyle(color: Color(0XFF4646B5)),
        //       ),
        //     ),
        //   if (currentPageIndex > 1)
        //     IconButton(
        //       onPressed: () {},
        //       icon: const Icon(Icons.more_vert),
        //     ),
        // ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Padding(
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
                      dotColor: Color(0xff03BF9C),
                      activeDotColor: Color(0xff03BF9C),
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
                child: SizedBox(
                  height: MediaQuery.of(context).size.height *
                      0.7, // Adjust the height as needed
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
                      // ContactDetailScreen(
                      //   pageController: pageController,
                      // ),
                      // DocumentScreen(
                      //   pageController: pageController,
                      // ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
