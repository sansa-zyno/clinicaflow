import 'package:flutter/cupertino.dart';
import 'package:healtether_clinic_app/widgets/CustomTextField.dart';

class OthersRegisterScreen extends StatelessWidget {
  final TextEditingController password;
  final TextEditingController confirmPassController;
  const OthersRegisterScreen(
      {super.key, required this.password, required this.confirmPassController});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),

          const Text(
            "Others",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),

          const SizedBox(
            height: 20,
          ),

          const Text(
            "Password *",
            style: TextStyle(fontSize: 14),
          ),
          const SizedBox(
            height: 8,
          ),
          CustomTextField(
            controller: password,
            hintText: "Password",
          ),
          const SizedBox(
            height: 10,
          ),

          const Text(
            "Confirm Password *",
            style: TextStyle(fontSize: 14),
          ),
          const SizedBox(
            height: 8,
          ),
          CustomTextField(
            controller: confirmPassController,
            hintText: "Confirm Password",
          ),
          FittedBox(
              fit: BoxFit.scaleDown,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    "By continuing, you agree to our",
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  GestureDetector(
                      onTap: () {},
                      child: const Text(
                        "Terms & Conditions",
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff5351C7),
                            decoration: TextDecoration.underline),
                      ))
                ],
              )),

          const SizedBox(
            height: 30,
          ),
          // GestureDetector(
          //   onTap: () {},
          //   child: CustomButton(data:"Next",color: Color(0xff03BF9C),height: 50,))
        ],
      ),
    );
  }
}
