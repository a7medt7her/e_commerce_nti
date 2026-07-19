import 'package:e_commerce_nti/core/unitles/app_color.dart';
import 'package:e_commerce_nti/core/unitles/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StatesOrder extends StatelessWidget {
  const StatesOrder({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    final titles = ['Active', 'Completed', 'Cancelled'];

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        final isSelected = currentIndex == index;

        return GestureDetector(
          onTap: () => onTap(index),
          child: Container(
            margin: REdgeInsets.symmetric(horizontal: 5),
            padding: REdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(38.r),
              color: isSelected ? AppColors.primary : AppColors.pink,
            ),
            child: Text(
              titles[index],
              style: TextStyle(
                fontSize: 17.sp,
                fontWeight: AppTextStyle.medium,
                color: isSelected ? AppColors.white : AppColors.primary,
              ),
            ),
          ),
        );
      }),
    );
  }
}
