import 'package:flutter/material.dart';
import 'package:flutter_stepindicator/flutter_stepindicator.dart';
import 'package:go_router/go_router.dart';
import 'package:healtether_clinic_app/Screens/RegisterScreen/others.dart';
import 'package:healtether_clinic_app/Screens/RegisterScreen/personal_details.dart';
import 'package:healtether_clinic_app/Screens/RegisterScreen/practice_details.dart';
import 'package:healtether_clinic_app/utils/enums/route_enums.dart';

import 'package:healtether_clinic_app/widgets/customButton.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();
  final TextEditingController specializationController = TextEditingController();
  final TextEditingController registrationNumber = TextEditingController();
  int _page = 0;

  final controller = PageController(initialPage: 0);

  void navigationTapped() {
    print("navigation tapped");
    _page += 1;
    setState(() {});
    controller.animateToPage(_page, duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> items = [
      PersonalDetailsRegisterScreen(
        nameController: nameController,
        numberController: numberController,
      ),
      PracticeDetailsRegisterScreen(
        specializationController: specializationController,
        registrationNumber: registrationNumber,
      ),
      OthersRegisterScreen(
        password: passwordController,
        confirmPassController: confirmPassController,
      )
    ];
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Register",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              FlutterStepIndicator(
                height: 20,
                list: items,
                onChange: (int index) {},
                page: _page,
              ),
              Expanded(
                child: PageView(
                  physics: const NeverScrollableScrollPhysics(),
                  onPageChanged: (value) => onPageChanged(value),
                  controller: controller,
                  scrollDirection: Axis.horizontal,
                  children: items,
                ),
              ),
              GestureDetector(
                  onTap: () => _page == 2
                      ? context.goNamed(AppRoutes.homePageView.name)
                      // ? Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (context) =>
                      //           HomePageView(selectedIndex: 0),
                      //     ))
                      : navigationTapped(),
                  child: CustomButton(
                    data: _page == 2 ? "Register" : "Next",
                    height: 50,
                    color: const Color(0xff03BF9C),
                    Textcolor: Colors.white,
                  )),
              const SizedBox(
                height: 50,
              )
            ],
          ),
        ));
  }
}
