import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/app_images.dart';
import '../model/onboarding_model.dart';

class OnboardingState {
  final int selectedPageIndex;

  const OnboardingState({this.selectedPageIndex = 0});

  OnboardingState copyWith({int? selectedPageIndex}) {
    return OnboardingState(
      selectedPageIndex: selectedPageIndex ?? this.selectedPageIndex,
    );
  }
}

class OnboardingCubit extends Cubit<OnboardingState> {
  final PageController pageController = PageController();

  final List<OnboardingModel> onBoardingList = [
    OnboardingModel(
      AppImages.obd1,
      "Your Practice, Simplified.",
      "Manage appointments, patient records, invoices, and virtual visits — all from a single, intuitive dashboard.",
    ),
    OnboardingModel(
      AppImages.obd2,
      "Team Roles, Your Way",
      "Bring your staff on board and tailor permissions so everyone sees exactly what they need — nothing more, nothing less.",
    ),
    OnboardingModel(
      AppImages.obd3,
      "Smarter Insights, Faster Care",
      "Leverage AI-powered analytics and predictive insights to make informed decisions and deliver proactive care.",
    ),
  ];

  OnboardingCubit() : super(const OnboardingState());

  void setPage(int index) {
    emit(state.copyWith(selectedPageIndex: index));
  }

  @override
  Future<void> close() {
    pageController.dispose();
    return super.close();
  }
}
