import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healtether_clinic_app/utils/enums/onboarding_enum.dart';
import 'package:healtether_clinic_app/utils/enums/route_enums.dart';
import 'package:healtether_clinic_app/utils/helper_functions/log.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  OnboardingState onboardingState = OnboardingState.first;

  Timer? _timer;

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      log(timer.tick);
      /* if (timer.tick == 6) {
        onboardingState = OnboardingState.second;
      } else if (timer.tick == 10) {
        onboardingState = OnboardingState.third;
      } else if (timer.tick == 12) {
        onboardingState = OnboardingState.end;
        context.goNamed(AppRoutes.onboarding.name);
        _timer?.cancel();
      }*/

      if (timer.tick == 2) {
        //onboardingState = OnboardingState.end;
        context.goNamed(AppRoutes.onboarding.name);
      }

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFFFFFFF),
                Color(0xFFFFFFFF),
                Color(0xFF53CFAC),
              ],
              stops: [0.0, 0.48, 1.0],
            ),
          ),
        ),
        Center(
          child: AnimatedCrossFade(
              duration: const Duration(seconds: 1),
              firstChild: Transform.scale(
                scale: 1.1,
                child: SvgPicture.asset("assets/svg/icon/logo.svg"),
              ),
              secondChild: Transform.scale(
                  scale: 0.8,
                  child:
                      null //onboardingState == OnboardingState.second ? SvgPicture.asset("assets/svg/logo2.svg") : SvgPicture.asset("assets/svg/logo3.svg")
                  ),
              crossFadeState:
                  CrossFadeState.showFirst //onboardingState == OnboardingState.first ? CrossFadeState.showFirst : CrossFadeState.showSecond,
              ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
