import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:healtether_clinic_app/constants/app_colors.dart';
import 'package:healtether_clinic_app/utils/enums/route_enums.dart';
import 'package:healtether_clinic_app/widgets/customButton.dart';
import 'package:healtether_clinic_app/Screens/AppointmentScreen/widgets/custom_textfield.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formkey = GlobalKey<FormState>();

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool isPasswordVisible = false;

  @override
  void dispose() {
    super.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Forgot Password",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 16,
                ),
                const Text(
                  "Enter your new password *",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                ),
                const SizedBox(
                  height: 8,
                ),
                CustomTextField(
                  height: 52,
                  hintText: "Password",
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
                  controller: _passwordController,
                  validator: (password) => (password!.isEmpty) ? "Please enter the password" : null,
                  obscureText: isPasswordVisible,
                  onChanged: (x) {
                    setState(() {});
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                const Text(
                  "Confirm your password *",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                ),
                const SizedBox(
                  height: 8,
                ),
                CustomTextField(
                  hintText: "Password",
                  controller: _confirmPasswordController,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
                  validator: (password) => (password!.isEmpty) ? "Please enter the confirm password" : null,
                  obscureText: isPasswordVisible,
                  onChanged: (x) {
                    setState(() {});
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Checkbox(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                        value: isPasswordVisible,
                        onChanged: (x) {
                          isPasswordVisible = x!;
                          setState(() {});
                        }),
                    const SizedBox(width: 10),
                    const Text('Show password'),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () {
                    //bool ans = _formkey.currentState!.validate();
                    context.goNamed(AppRoutes.login.name);
                  },
                  child: const CustomButton(
                    data: "Change Password",
                    color: AppColors.darkTeal,
                    height: 54,
                    Textsize: 14,
                    Textcolor: Colors.white,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
