import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healtether_clinic_app/Screens/AppointmentScreen/widgets/custom_textfield.dart';
import 'package:healtether_clinic_app/Screens/ManageStaff/edit_document_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class EditContactScreen extends StatefulWidget {
  final PageController? pageController;

  const EditContactScreen({super.key, this.pageController});

  @override
  State<EditContactScreen> createState() => _EditContactScreenState();
}

class _EditContactScreenState extends State<EditContactScreen> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController houseController = TextEditingController();
  TextEditingController landmarkController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController additionalPhoneController = TextEditingController();
  TextEditingController additionalEmailController = TextEditingController();
  bool showAdditionalPhone = false;
  bool showAdditionalEmail = false;
  final PageController pageController = PageController(initialPage: 1);
  int currentPageIndex = 1;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Edit Profile'),),
        body: SingleChildScrollView(
          // physics: const NeverScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0,right: 8.0,top: 8.0,bottom: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisSize: MainAxisSize.min,
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
                const SizedBox(height: 10,),
                const Text(
                  'Contact Details',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: phoneController,
                  hintText: 'Phone',
                  height: 45,
                ),
                const SizedBox(height: 10),
                if (showAdditionalPhone) ...[
                  CustomTextField(
                    controller: additionalPhoneController,
                    hintText: 'Additional Phone',
                    height: 45,
                  ),
                ],
                GestureDetector(
                  onTap: () {
                    setState(() {
                      showAdditionalPhone = true;
                    });
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.add, color: Color(0xff5351C7)),
                          Text(
                            "Add another number",
                            style: TextStyle(color: Color(0xff5351C7)),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          height: 2,
                          width: screenSize.width * 0.5,
                          color: const Color(0xff5351C7),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),
                CustomTextField(
                  controller: emailController,
                  hintText: 'Email',
                  height: 45,
                ),
                const SizedBox(height: 7),
                if (showAdditionalEmail) ...[
                  CustomTextField(
                    controller: additionalEmailController,
                    hintText: 'Additional Email',
                    height: 45,
                  ),
                  const SizedBox(height: 10),
                ],
                GestureDetector(
                  onTap: () {
                    setState(() {
                      showAdditionalEmail = true;
                    });
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(
                            Icons.add,
                            color: Color(0xff5351C7),
                          ),
                          Text(
                            "Add another email",
                            style: TextStyle(color: Color(0xff5351C7)),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          height: 2,
                          width: screenSize.width * 0.5,
                          color: const Color(0xff5351C7),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(
                  height: 2,
                ),
                // const Divider(),
                const SizedBox(height: 10),
                const Text(
                  'Address',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                CustomTextField(
                  controller: houseController,
                  hintText: 'House/Building/Room no',
                  height: 45,
                ),
                const SizedBox(height: 5),
                CustomTextField(
                  controller: areaController,
                  hintText: 'Street/Area',
                  height: 45,
                ),
                const SizedBox(height: 5),
                CustomTextField(
                  controller: landmarkController,
                  hintText: 'Landmarks',
                  height: 45,
                ),
                const SizedBox(height: 5),
                CustomTextField(
                  controller: cityController,
                  hintText: 'City',
                  height: 45,
                ),
                const SizedBox(height: 5),
                CustomTextField(
                  controller: pincodeController,
                  hintText: 'Pin code',
                  height: 45,
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.all(36),
                  child: Container(
                      height: 60,
                      width: 280,
                      decoration: BoxDecoration(
                        color: const Color(0xff32856E),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return const EditDocumentScreen();
                            }));
                          },
                          child: Text(
                            'Save',
                            style: GoogleFonts.montserrat(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xffFFFFFF),
                            ),
                          ),
                        ),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
// git config --global user.name "Dinesh"
