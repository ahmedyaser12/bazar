import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

import '../data/model/onboarding_model.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(OnboardingInitial());

  int pageIndex = 0;
  PageController pageController = PageController();
  List<OnboardingModel> data = [
    OnboardingModel(
      'assets/images/onboarding1.png',
      'Now reading books will be easier',
      ' Discover new worlds, join a vibrant\n reading community. Start your reading\n adventure effortlessly with us.',
    ),
    OnboardingModel(
      'assets/images/onboarding2.png',
      'Your Bookish Soulmate Awaits',
      'Let us be your guide to the perfect read.\n Discover books tailored to your tastes\n for a truly rewarding experience.',
    ),
    OnboardingModel(
      'assets/images/onboarding3.png',
      'Start Your Adventure',
      'Ready to embark on a quest for\n inspiration and knowledge? Your\n adventure begins now. Let\'s go!',
    )
  ];

  void currentIndex(int index) {
    emit(OnboardingInitial());
    pageIndex = index;
    print(pageIndex);
    emit(OnboardingNext());
  }
}
