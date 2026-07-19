import 'package:e_commerce_nti/core/unitles/app_color.dart';
import 'package:e_commerce_nti/core/unitles/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Categories extends StatelessWidget {
  const Categories({
    super.key,
    required this.title,
    required this.imagePath,
    this.onTap,
    required this.id,
    required this.selectedId,
  });
  final String title;
  final String imagePath;
  final void Function()? onTap;
  final int id;
  final int selectedId;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            height: 56.h,
            width: 56.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(imagePath),
              ),
            ),
          ),
        ),
        SizedBox(height: 4),
        Text(
          title,
          style: TextStyle(
            color: id == selectedId ? AppColors.primary : AppColors.darkBAG,
            fontSize: 10.sp,
            fontWeight: AppTextStyle.regular,
          ),
        ),
      ],
    );
  }
}
