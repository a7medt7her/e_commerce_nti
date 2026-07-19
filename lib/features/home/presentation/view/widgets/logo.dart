import 'package:e_commerce_nti/core/helper/svg_helper.dart';
import 'package:e_commerce_nti/core/unitles/app_color.dart';
import 'package:e_commerce_nti/core/unitles/app_text_style.dart';
import 'package:e_commerce_nti/core/unitles/asstes.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        svgHelper(AssetsIcon.logo, 38.78093338012695.w, 31.02627182006836.h),
        SizedBox(width: 4.51.w),
        Text(
          'Stylish',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: AppTextStyle.bold,
            color: AppColors.blue,
          ),
        ),
      ],
    );
  }
}
