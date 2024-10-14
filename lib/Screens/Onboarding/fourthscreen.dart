// import 'package:flutter/material.dart';
// import 'package:healtether_clinic_app/Screens/loginpage/login_page.dart';


// class FourthScreen extends StatefulWidget {
//   const FourthScreen({Key? key}) : super(key: key);

//   @override
//   State<FourthScreen> createState() => _FourthScreenState();
// }

// class _FourthScreenState extends State<FourthScreen> {
//   final int _totalDots = 3;

//   void _moveForward() {
//     Navigator.pushReplacement(
//       context,
//       PageRouteBuilder(
//         transitionDuration: const Duration(milliseconds: 500),
//         pageBuilder: (context, animation, secondaryAnimation) => const LoginPage(),
//         transitionsBuilder: (context, animation, secondaryAnimation, child) {
//           return FadeTransition(
//             opacity: animation,
//             child: child,
//           );
//         },
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           Container(
//             decoration: const BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.center,
//                 end: Alignment.bottomCenter,
//                 colors: [
//                   Color(0xFFFFFFFF), // #85F8D5 at 0%
//                   Color(0xFF85F8D5), // #85F8D5 at 48%
//                   Color(0xFF53CFAC), // #53CFAC at 100%
//                 ],
//                 stops: [0.0, 0.48, 1.0], // corresponding stops for each color
//               ),
//             ),
//           ),
//           Positioned(
//             top: 100,
//             left: 0,
//             right: 0,
//             child: Image.asset(
//               'assets/homeimages/onboarding/shape3.png', // Path to your irregular shape image
//               fit: BoxFit.contain,
//             ),
//           ),
//           Positioned(
//             top: 50, // Adjust top position as needed
//             left: 0,
//             right: 0,
//             child: Image.asset(
//               'assets/homeimages/onboarding/logo_text.png',
//               height: 40, // Adjust the height as needed
//               fit: BoxFit.contain, // Maintain aspect ratio
//             ),
//           ),
//           Positioned(
//             bottom: MediaQuery.of(context).size.height * 0.12,
//             left: 20,
//             right: 20,
//             child: Column(
//               children: [
//                 const SizedBox(height: 20), // Spacer
//                 const Text(
//                   'Expert care, anytime, anywhere.',
//                   style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//                   textAlign: TextAlign.center,
//                 ),
//                 const SizedBox(height: 10), // Spacer
//                 const Text(
//                   'Access top-tier healthcare - Connect with renowned specialist doctors.',
//                   style: TextStyle(fontSize: 14),
//                   textAlign: TextAlign.center,
//                 ),
//                 const SizedBox(height: 20,),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: List.generate(_totalDots, (index) {
//                     return Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                       child: Container(
//                         width: 8,
//                         height: 8,
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           color: index == 2 ? Colors.black : Colors.transparent,
//                           border: Border.all(color: Colors.black, width: 1),
//                         ),
//                       ),
//                     );
//                   }),
//                 ),
//                 const SizedBox(height: 20,),
//                 GestureDetector(
//                   onTap: _moveForward,
//                   child: Stack(
//                     alignment: Alignment.center,
//                     children: [ // Arrow icon
//                       Container(
//                         width: 50,
//                         height: 50,
//                         decoration: const BoxDecoration(
//                           shape: BoxShape.circle,
//                           color: Color(0xFF266A57), // Circle color with opacity
//                         ),
//                       ),
//                       const Icon(Icons.arrow_forward, size: 40, color: Colors.white,),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
