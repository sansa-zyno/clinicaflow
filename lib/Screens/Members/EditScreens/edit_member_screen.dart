import 'package:flutter/material.dart';
import 'package:healtether_clinic_app/Screens/Members/EditScreens/edit_personal_detail_screen.dart';

import 'package:healtether_clinic_app/constants/constants.dart';
import 'package:healtether_clinic_app/data_layer/models/patient/patient_model_id.dart';
import 'package:healtether_clinic_app/data_layer/models/staff_model/staff_detail_model.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class EditMemberScreen extends StatefulWidget {
  final bool isAdmin;
  final bool forStaff;
  final StaffByIdModel? staffByIdModel;
  final PatientByIdModel? patientByIdModel;
  const EditMemberScreen({
    super.key,
    required this.isAdmin,
    required this.forStaff,
    this.staffByIdModel,
    this.patientByIdModel,
  });

  @override
  State<EditMemberScreen> createState() => _EditMemberScreenState();
}

class _EditMemberScreenState extends State<EditMemberScreen> {
  final PageController pageController = PageController(initialPage: 0);
  int currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppText.editProfile),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        automaticallyImplyLeading: false,
        /*actions: [
          if (currentPageIndex > 1)
            TextButton(
              onPressed: () {},
              child: const Text(
                AppText.skip,
                style: TextStyle(color: Color(0XFF4646B5)),
              ),
            ),
          if (currentPageIndex > 1)
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.more_vert),
            ),
        ],*/
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: SmoothPageIndicator(
              controller: pageController,
              count: widget.forStaff ? 5 : 3,
              effect: const ExpandingDotsEffect(
                expansionFactor: 5,
                dotColor: Color(0XFF5351C7),
                strokeWidth: 3,
                dotHeight: 8,
                dotWidth: 8,
                paintStyle: PaintingStyle.fill,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.7, // Adjust the height as needed
              child: PageView(
                controller: pageController,
                scrollDirection: Axis.horizontal,
                onPageChanged: (index) {
                  setState(() {
                    currentPageIndex = index;
                  });
                },
                children: [
                  EditPersonalDetailScreen(
                    isAdmin: widget.isAdmin,
                    forStaff: widget.forStaff,
                    pageController: pageController,
                    staffByIdModel: widget.staffByIdModel,
                    patientByIdModel: widget.patientByIdModel,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }
}
