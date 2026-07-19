import 'package:e_commerce_nti/core/helper/svg_helper.dart';
import 'package:e_commerce_nti/core/unitles/app_color.dart';
import 'package:e_commerce_nti/core/unitles/app_text_style.dart';
import 'package:e_commerce_nti/core/unitles/asstes.dart';
import 'package:e_commerce_nti/features/start/data/model/body_model.dart';
import 'package:e_commerce_nti/features/start/presentation/view/widgets/indecator.dart';
import 'package:e_commerce_nti/features/start/presentation/view/widgets/onboard_body.dart';
import 'package:e_commerce_nti/features/start/presentation/view_model/cubit/onboard_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardView extends StatelessWidget {
  OnboardView({super.key});
  final List<Widget> pages = [
    OnboardBody(
      data: BodyModel(
        image: svgHelper(AssetsIcon.onboard1, 300.w, 300.h),
        text1: 'Choose Products',
        text2:
            'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit.',
      ),
    ),
    OnboardBody(
      data: BodyModel(
        image: svgHelper(AssetsIcon.onboard2, 300.w, 300.h),
        text1: 'Make Payment',
        text2:
            'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit.',
      ),
    ),
    OnboardBody(
      data: BodyModel(
        image: svgHelper(AssetsIcon.onboard3, 350.w, 350.h),
        text1: 'Get Your Order',
        text2:
            'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit.',
      ),
    ),
  ];
  final PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OnboardCubit(),
      child: Scaffold(
        body: Padding(
          padding: REdgeInsets.symmetric(horizontal: 18),
          child: BlocBuilder<OnboardCubit, int>(
            builder: (context, state) {
              return Column(
                children: [
                  SizedBox(height: 15.h),
                  state == pages.length - 1
                      ? SizedBox()
                      : Align(
                          alignment: AlignmentGeometry.topRight,
                          child: TextButton(
                            onPressed: () {
                              pageController.jumpToPage(pages.length);
                            },
                            child: Text(
                              'skip',
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: AppTextStyle.semiBold,
                                color: AppColors.black,
                              ),
                            ),
                          ),
                        ),
                  SizedBox(height: 85.h),
                  Expanded(
                    child: PageView.builder(
                      controller: pageController,
                      onPageChanged: (value) {
                        context.read<OnboardCubit>().pageNavigator(value);
                      },
                      itemCount: pages.length,
                      itemBuilder: (context, index) {
                        return pages[index];
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      state == 0
                          ? Spacer()
                          : TextButton(
                              onPressed: () {
                                pageController.previousPage(
                                  duration: Duration(seconds: 1),
                                  curve: Curves.easeInOut,
                                );
                              },
                              child: Text(
                                'Prev',
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: AppTextStyle.semiBold,
                                  color: AppColors.lightGray,
                                ),
                              ),
                            ),
                      Spacer(),
                      Indicator(currentIndex: state, length: pages.length),
                      Spacer(),
                      TextButton(
                        onPressed: () {
                          context.read<OnboardCubit>().nextButton(
                            pages.length,
                            pageController,
                            context,
                          );
                        },
                        child: Text(
                          state == pages.length - 1 ? 'Get Started' : 'Next',
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: AppTextStyle.semiBold,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
