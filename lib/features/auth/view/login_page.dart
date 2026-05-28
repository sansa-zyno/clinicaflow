import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:clinica_flow/features/auth/bloc/login_bloc.dart';
import 'package:clinica_flow/core/constants/app_colors.dart';
import 'package:clinica_flow/shared/widgets/custom_textfield.dart';
import 'package:clinica_flow/shared/widgets/customButton.dart';
import 'package:clinica_flow/core/utils/enums/route_enums.dart';
import 'package:clinica_flow/core/utils/snackbar.dart';
import 'package:clinica_flow/core/utils/responsive_layout.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formkey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isPasswordVisible = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mobileView = Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title:
            const Text("Login", style: TextStyle(fontWeight: FontWeight.bold)),
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
                      "Enter your email *",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    CustomTextField(
                      height: 52,
                      hintText: "Email",
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 16),
                      controller: _emailController,
                      validator: (email) => (email!.isEmpty)
                          ? "The email is incorrect, please try again!"
                          : null,
                      //keyBoardType: TextInputType.number,
                      onChanged: (x) {
                        setState(() {});
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Text(
                      "Password *",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    CustomTextField(
                      hintText: "Password",
                      controller: _passwordController,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 16),
                      validator: (password) => (password!.isEmpty)
                          ? "Please enter the password"
                          : null,
                      obscureText: !isPasswordVisible,
                      suffixIcon: InkWell(
                        onTap: () {
                          setState(() {
                            isPasswordVisible = !isPasswordVisible;
                          });
                        },
                        child: Icon(
                          isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
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
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w400),
                            ),
                            GestureDetector(
                                onTap: () {},
                                child: const Text(
                                  "Terms & Conditions",
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.primaryColor,
                                      decoration: TextDecoration.underline),
                                ))
                          ],
                        )),
                    const SizedBox(
                      height: 16,
                    ),
                    GestureDetector(
                        onTap: () {
                          context.pushNamed(AppRoutes.forgotPassword.name);
                        },
                        child: const Text("Forgot Password?",
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.w400,
                            ))),
                    const SizedBox(
                      height: 30,
                    ),
                    BlocBuilder<LoginBloc, LoginState>(
                      builder: (context, state) {
                        if (state is LoginInitial) {
                          return GestureDetector(
                            onTap: () {
                              bool ans = _formkey.currentState!.validate();
                              if (ans) {
                                context.read<LoginBloc>().add(
                                    LogingProcessEvent(
                                        email: _emailController.text,
                                        password: _passwordController.text,
                                        context: context));
                              }
                            },
                            child: CustomButton(
                              data: "Log In",
                              color: _emailController.text.isNotEmpty &&
                                      _passwordController.text.isNotEmpty
                                  ? AppColors.darkTeal
                                  : AppColors.whiteSmoke,
                              height: 54,
                              Textsize: 14,
                              Textcolor: _emailController.text.isNotEmpty &&
                                      _passwordController.text.isNotEmpty
                                  ? Colors.white
                                  : AppColors.lightGrey3,
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
                  ])),
        ),
      ),
    );

    return BlocListener<LoginBloc, LoginState>(
      listenWhen: (previous, current) =>
          current is LoginActionState ? true : false,
      listener: (context, state) {
        if (state is LoginFailState) {
          showSnackbar(state.error, context);
          context.read<LoginBloc>().add(LoginRestartEvent());
        } else if (state is LoginSuccessfulState) {
          context.goNamed(AppRoutes.welcome.name);
        }
      },
      child: ResponsiveLayout(
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
      ),
    );
  }
}
