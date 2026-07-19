import 'package:e_commerce_nti/core/unitles/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomElvatedButton extends StatelessWidget {
  const CustomElvatedButton({
    super.key,
    required this.onPressed,
    required this.text,

    this.colorContainer,
    this.border,

    this.textColor,
    required this.fontSize,
    this.widget,
    this.sizedBoxWidth,
  });
  final VoidCallback onPressed;
  final String text;
  final Color? colorContainer;
  final BoxBorder? border;
  final Color? textColor;
  final double fontSize;
  final Widget? widget;
  final double? sizedBoxWidth;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: REdgeInsets.symmetric(vertical: 15.5),
        width: double.infinity,
        decoration: BoxDecoration(
          border: BoxBorder.all(width: 1.w, color: AppColors.primary),
          borderRadius: BorderRadius.circular(4.r),
          color: colorContainer ?? AppColors.primary,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            widget ?? SizedBox(),
            SizedBox(width: sizedBoxWidth ?? 0),
            Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: textColor ?? AppColors.white,
                fontSize: fontSize.sp,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
