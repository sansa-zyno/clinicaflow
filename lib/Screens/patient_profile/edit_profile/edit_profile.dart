import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final controller = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profileeee"),
      ),
      // body: Column(
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: [
      //     const SizedBox(
      //       height: 10,
      //     ),
      // Padding(
      //   padding: const EdgeInsets.symmetric(horizontal: 16),
      //   child: SmoothPageIndicator(
      //     controller: controller,
      //     count: 4,
      //     effect: const ExpandingDotsEffect(
      //         expansionFactor: 5,
      //         dotColor: Color(0XFF5351C7),
      //         strokeWidth: 3,
      //         dotHeight: 8,
      //         dotWidth: 8,
      //         paintStyle: PaintingStyle.fill),
      //   ),
      // ),
      // const SizedBox(
      //   height: 10,
      // ),
      // Expanded(
      //   child: PageView(
      //     controller: controller,
      //     scrollDirection: Axis.horizontal,
      //     children: const [
      //       PersonalEdit(),
      //       ContactsEdit(),
      //       DocumentDetails(),
      //       PaymentDetails()
      //     ],
      //   ),
      // ),
      //     Padding(
      //       padding: const EdgeInsets.symmetric(horizontal: 16),
      //       child: CustomButton(
      //         data: "Save",
      //         width: MediaQuery.of(context).size.width,
      //         height: 50,
      //         color: const Color(0XFF03BF9C),
      //         Textcolor: Colors.white,
      //         Textsize: 16,
      //       ),
      //     ),
      //     const SizedBox(
      //       height: 10,
      //     )
      //   ],
      // )
    );
  }
}
