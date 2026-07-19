import 'package:e_commerce_nti/core/unitles/app_color.dart';
import 'package:e_commerce_nti/core/unitles/app_text_style.dart';
import 'package:e_commerce_nti/features/start/data/model/body_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardBody extends StatelessWidget {
  const OnboardBody({super.key, required this.data});
  final BodyModel data;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        data.image,
        SizedBox(height: 15.h),
        Text(
          data.text1,
          style: TextStyle(
            color: AppColors.black,
            fontSize: 24.sp,
            fontWeight: AppTextStyle.extraBold,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 10.h),
        Text(
          data.text2,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: AppTextStyle.semiBold,
            color: AppColors.gray,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
