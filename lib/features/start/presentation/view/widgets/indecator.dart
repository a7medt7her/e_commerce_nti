import 'package:e_commerce_nti/core/unitles/app_color.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Indicator extends StatelessWidget {
  const Indicator({
    super.key,
    required this.currentIndex,
    required this.length,
  });
  final int currentIndex;
  final int length;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(length, (index) {
        return Container(
          margin: REdgeInsets.symmetric(horizontal: 10),
          width: currentIndex == index ? 40.w : 10.w,
          height: currentIndex == index ? 8.h : 10.h,
          decoration: BoxDecoration(
            borderRadius: currentIndex == index
                ? BorderRadius.circular(100.r)
                : null,
            color: currentIndex == index
                ? AppColors.black
                : AppColors.indicator,
            shape: currentIndex == index ? BoxShape.rectangle : BoxShape.circle,
          ),
        );
      }),
    );
  }
}
