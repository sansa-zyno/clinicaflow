// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
// import 'package:healtether_clinic_app/Screens/HomeScreen/page_view_screen.dart';
import 'package:healtether_clinic_app/business_logic/blocs/login_bloc/login_bloc.dart';
import 'package:healtether_clinic_app/constants/app_colors.dart';
// import 'package:healtether_clinic_app/widgets/CustomTextField.dart';
import 'package:healtether_clinic_app/widgets/customButton.dart';
import 'package:healtether_clinic_app/utils/enums/route_enums.dart';
// import 'package:healtether_clinic_app/utils/global.dart';
import 'package:healtether_clinic_app/utils/snackbar.dart';
import 'package:healtether_clinic_app/Screens/AppointmentScreen/widgets/custom_textfield.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formkey = GlobalKey<FormState>();

  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  // final LoginBloc bloc = LoginBloc();
  bool isPasswordVisible = false;

  @override
  void dispose() {
    super.dispose();
    _mobileController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      // bloc: bloc,
      listenWhen: (previous, current) => current is LoginActionState ? true : false,
      listener: (context, state) {
        if (state is LoginFailState) {
          showSnackbar(state.error, context);
          context.read<LoginBloc>().add(LoginRestartEvent());
        } else if (state is LoginSuccessfulState) {
          // Navigator.of(context).pushReplacement(createRoute(HomePageView(selectedIndex: 0)));
          context.goNamed(AppRoutes.welcome.name);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Login",
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
                    "Enter your mobile number *",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  CustomTextField(
                    height: 52,
                    hintText: "Mobile number",
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
                    inputFormatters: [LengthLimitingTextInputFormatter(10), FilteringTextInputFormatter.digitsOnly],
                    controller: _mobileController,
                    validator: (number) => (number!.isEmpty) ? "The mobile number is incorrect, please try again!" : null,
                    keyBoardType: TextInputType.number,
                    onChanged: (x) {
                      setState(() {});
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text(
                    "Password *",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  CustomTextField(
                    hintText: "Password",
                    controller: _passwordController,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
                    validator: (password) => (password!.isEmpty) ? "Please enter the password" : null,
                    obscureText: !isPasswordVisible,
                    suffixIcon: InkWell(
                      onTap: () {
                        setState(() {
                          isPasswordVisible = !isPasswordVisible;
                        });
                      },
                      child: Icon(
                        isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                      ),
                    ),
                    onChanged: (x) {
                      setState(() {});
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            "By continuing, you agree to our ",
                            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
                          ),
                          GestureDetector(
                              onTap: () {},
                              child: const Text(
                                "Terms & Conditions",
                                style: TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.w400, color: AppColors.blueViolet, decoration: TextDecoration.underline),
                              ))
                        ],
                      )),
                  const SizedBox(
                    height: 16,
                  ),
                  GestureDetector(
                      onTap: () {},
                      child: const Text("Forgot Password?",
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.blueViolet,
                            fontWeight: FontWeight.w400,
                          ))),
                  const SizedBox(
                    height: 30,
                  ),
                  BlocBuilder<LoginBloc, LoginState>(
                    // bloc: L,
                    builder: (context, state) {
                      if (state is LoginInitial) {
                        return GestureDetector(
                          onTap: () {
                            bool ans = _formkey.currentState!.validate();
                            if (ans) {
                              context
                                  .read<LoginBloc>()
                                  .add(LogingProcessEvent(number: _mobileController.text, password: _passwordController.text, context: context));
                            }
                          },
                          child: CustomButton(
                            data: "Log me in",
                            color:
                                _mobileController.text.isNotEmpty && _passwordController.text.isNotEmpty ? AppColors.darkTeal : AppColors.whiteSmoke,
                            height: 54,
                            Textsize: 14,
                            Textcolor: _mobileController.text.isNotEmpty && _passwordController.text.isNotEmpty ? Colors.white : AppColors.lightGrey3,
                          ),
                        );
                      } else {
                        return const CustomButton(
                          data: "Logging you in..",
                          color: AppColors.darkTeal,
                          height: 54,
                          Textsize: 16,
                          Textcolor: Colors.white,
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
