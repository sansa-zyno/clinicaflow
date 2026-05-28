import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:clinica_flow/core/network/api_endpoints.dart';
import 'package:clinica_flow/core/constants/app_colors.dart';
import 'package:clinica_flow/features/auth/model/user_model.dart';
import 'package:clinica_flow/core/utils/shared_preferences_service.dart';
import 'package:clinica_flow/core/utils/enums/route_enums.dart';
import 'package:clinica_flow/core/utils/responsive_layout.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  UserModel? userModel;
  Map? selectedClinic;
  getCurrentUser() async {
    userModel = await UserModel.getCurrentUser();
    log(userModel.toString());
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    final mobileView = Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Welcome To Our Community',
                  style: GoogleFonts.urbanist(
                    textStyle: const TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.w400,
                        color: AppColors.eerieBlack),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            Center(
              child: Text(
                'We need some details to get you sign up!',
                style: GoogleFonts.roboto(
                  textStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColors.lightGrey8),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Center(
              child: Text(
                'This will take just a moment',
                style: GoogleFonts.roboto(
                  textStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColors.lightGrey8),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              'Select Clinic *',
              style: GoogleFonts.roboto(
                textStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.grey4),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 8,
            ),
            InkWell(
              onTap: () {
                if (userModel != null) {
                  showSwitchClinicsBottomSheet(
                      context, userModel!.linkedClinics);
                }
              },
              child: Container(
                height: 52,
                color: AppColors.whiteSmoke,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        selectedClinic == null
                            ? "Empty"
                            : selectedClinic!['clinicName'],
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: selectedClinic == null
                              ? Colors.grey
                              : Colors.black,
                        ),
                      ),
                      const Icon(Icons.keyboard_arrow_down_outlined)
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              height: 52,
              decoration: BoxDecoration(
                color: AppColors.darkTeal,
                borderRadius: BorderRadius.circular(7),
              ),
              child: Center(
                child: TextButton(
                  onPressed: () async {
                    if (selectedClinic != null) {
                      await SharedPrefService.setClinicId(
                          selectedClinic!['id']);
                      log(selectedClinic!['id']);
                      context.goNamed(AppRoutes.homePageView.name);
                    }
                  },
                  child: const Text(
                    'Let\'s go',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );

    return ResponsiveLayout(
      mobile: mobileView,
      desktop: Scaffold(
        backgroundColor: const Color(0xffF5F5F5),
        body: Center(
          child: Container(
            width: 600,
            height: 800,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: MediaQuery(
              data: MediaQuery.of(context).copyWith(
                size: const Size(400, 800),
              ),
              child: mobileView,
            ),
          ),
        ),
      ),
    );
  }

  void showSwitchClinicsBottomSheet(BuildContext context, List linkedClinics) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'SELECT CLINIC',
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Container(
                height: 2,
                width: 55,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppColors.greenLightColor),
              ),
              const SizedBox(
                height: 9,
              ),
              Flexible(
                child: ListView.builder(
                    itemCount: linkedClinics.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          //selectedClinic = linkedClinics[index]['clinic'];
                          selectedClinic = linkedClinics[index];
                          setState(() {});
                          context.pop();
                        },
                        child: Container(
                          height: 52,
                          padding: const EdgeInsets.only(left: 8.0),
                          margin: const EdgeInsets.only(bottom: 8.0),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: AppColors.whiteSmoke,
                            borderRadius: BorderRadius.circular(2),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 20,
                                      child: (linkedClinics[index]?['logo'] ??
                                                  '') ==
                                              ''
                                          ? Image.asset(
                                              'assets/homeimages/image 6 (3).png',
                                              height: 100,
                                              width: 100,
                                              fit: BoxFit.cover,
                                            )
                                          : Image.network(
                                              "${ApiEndPoint.logoBaseUrl}${linkedClinics[index]?['logo']}",
                                              height: 100,
                                              width: 100,
                                            ),
                                      //backgroundImage: AssetImage('assets/homeimages/image 6 (3).png'),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      linkedClinics[index]?['clinicName'] ?? '',
                                      style: GoogleFonts.montserrat(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            ],
          ),
        );
      },
    );
  }
}
//'assets/homeimages/image 6 (3).png'
//assets/homeimages/image 6.png
//assets/homeimages/image 6 (2).png
