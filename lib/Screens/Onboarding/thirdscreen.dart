// import 'package:flutter/material.dart';

// import 'fourthscreen.dart';


// class ThirdScreen extends StatefulWidget {
//   const ThirdScreen({Key? key}) : super(key: key);

//   @override
//   State<ThirdScreen> createState() => _ThirdScreenState();
// }

// class _ThirdScreenState extends State<ThirdScreen> {
//   final int _totalDots = 3;

//   void _moveForward() {
//     Navigator.pushReplacement(
//       context,
//       PageRouteBuilder(
//         transitionDuration: const Duration(milliseconds: 500),
//         pageBuilder: (context, animation, secondaryAnimation) => const FourthScreen(),
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
//                   Color(0xFFFFFFFF),
//                   Color(0xFF85F8D5),
//                   Color(0xFF53CFAC),
//                 ],
//                 stops: [0.0, 0.48, 1.0],
//               ),
//             ),
//           ),
//           Positioned(
//             top: 50,
//             left: 0,
//             right: 0,
//             child: Image.asset(
//               'assets/homeimages/onboarding/vector.png',
//               fit: BoxFit.contain,
//             ),
//           ),
//           Positioned(
//             top: 50,
//             left: 0,
//             right: 0,
//             child: Image.asset(
//               'assets/homeimages/onboarding/logo_text.png',
//               height: 40,
//               fit: BoxFit.contain,
//             ),
//           ),
//           Positioned(
//             bottom: MediaQuery.of(context).size.height * 0.12,
//             left: 20,
//             right: 20,
//             child: Column(
//               children: [
//                 const SizedBox(height: 20),
//                 const Text(
//                   'Expert care, anytime, anywhere.',
//                   style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//                   textAlign: TextAlign.center,
//                 ),
//                 const SizedBox(height: 10),
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
//                           color: index == 1 ? Colors.black : Colors.transparent,
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
//                     children: [
//                       Container(
//                         width: 50,
//                         height: 50,
//                         decoration: const BoxDecoration(
//                           shape: BoxShape.circle,
//                           color: Color(0xFF266A57),
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
