import 'package:e_commerce_nti/core/unitles/app_color.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeIndicator extends StatelessWidget {
  const HomeIndicator({
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
          margin: REdgeInsets.symmetric(horizontal: 2),
          width: 9.w,
          height: 9.h,
          decoration: BoxDecoration(
            color: currentIndex == index
                ? AppColors.pink
                : AppColors.lightGray2,
            shape: BoxShape.circle,
          ),
        );
      }),
    );
  }
}
