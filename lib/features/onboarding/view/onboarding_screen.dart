import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_images.dart';
import '../../../core/constants/app_textstyles.dart';
import '../../../core/utils/enums/route_enums.dart';
import '../../../core/utils/size_utils.dart';
import '../../../shared/widgets/buttons/custom_button.dart';
import '../viewmodel/onboarding_cubit.dart';
import 'package:clinica_flow/core/utils/responsive_layout.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<OnboardingCubit>();

    final mobileView = Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: cubit.pageController,
              onPageChanged: (i) => cubit.setPage(i),
              itemCount: cubit.onBoardingList.length,
              itemBuilder: (context, index) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: getVerticalSize(45, context)),
                    Image.asset(AppImages.logo, height: getSize(53, context)),
                    SizedBox(height: getVerticalSize(30, context)),
                    Image.asset(
                        cubit.onBoardingList[index].imageAsset.toString(),
                        height: 246),
                    SizedBox(height: getVerticalSize(30, context)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        cubit.onBoardingList[index].title.toString(),
                        style: AppTextStyles.title(context, fontSize: 32),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: getVerticalSize(15, context)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        cubit.onBoardingList[index].description.toString(),
                        style: AppTextStyles.body(context,
                            fontSize: 14, color: AppColors.grey),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: getVerticalSize(50, context)),
                    BlocBuilder<OnboardingCubit, OnboardingState>(
                      builder: (context, state) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            cubit.onBoardingList.length,
                            (index) => Container(
                              margin: const EdgeInsets.symmetric(horizontal: 3),
                              width: state.selectedPageIndex == index ? 20 : 6,
                              height: 6,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: state.selectedPageIndex == index
                                    ? AppColors.primaryColor
                                    : const Color(0xffD4D5E0),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                );
              },
            ),
          ),
          SizedBox(height: getVerticalSize(15, context)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                Expanded(
                  child: CustomButton(
                    border: Border.all(color: AppColors.primaryColor),
                    text: 'Skip',
                    textColor: AppColors.primaryColor,
                    onpressed: () {
                      context.pushNamed(AppRoutes.login.name);
                    },
                  ),
                ),
                SizedBox(width: getHorizontalSize(15, context)),
                Expanded(
                  child: BlocBuilder<OnboardingCubit, OnboardingState>(
                    builder: (context, state) {
                      return CustomButton(
                        color: AppColors.primaryColor,
                        text: 'Next',
                        onpressed: () {
                          if (state.selectedPageIndex < 2) {
                            cubit.pageController
                                .jumpToPage(state.selectedPageIndex + 1);
                          } else {
                            context.pushNamed(AppRoutes.login.name);
                          }
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: getVerticalSize(30, context)),
        ],
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
}
