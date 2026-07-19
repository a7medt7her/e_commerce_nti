import 'package:bloc/bloc.dart';
import 'package:e_commerce_nti/features/start/presentation/view/get_start.dart';
import 'package:flutter/material.dart';

class OnboardCubit extends Cubit<int> {
  OnboardCubit() : super(0);
  void pageNavigator(int index) {
    emit(index);
  }

  void nextButton(
    int length,
    PageController pageController,
    BuildContext context,
  ) {
    if (state < length - 1) {
      pageController.nextPage(
        duration: Duration(seconds: 1),
        curve: Curves.easeInOut,
      );
    } else if (state == length - 1) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => GetStart()),
        (context) => false,
      );
    }
  }
}
