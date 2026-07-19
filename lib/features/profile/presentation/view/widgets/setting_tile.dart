import 'package:e_commerce_nti/core/helper/svg_helper.dart';
import 'package:e_commerce_nti/core/unitles/app_color.dart';
import 'package:e_commerce_nti/core/unitles/app_text_style.dart';
import 'package:e_commerce_nti/core/unitles/asstes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class SettingTile extends StatelessWidget {
  const SettingTile({
    super.key,
    required this.leading,
    required this.text,
    this.onTap,
  });
  final SvgPicture leading;
  final String text;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        color: AppColors.white,
      ),
      child: ListTile(
        onTap: onTap,
        leading: leading,
        title: Text(
          text,
          style: TextStyle(
            fontWeight: AppTextStyle.medium,
            fontSize: 18.sp,
            color: AppColors.black,
          ),
        ),
        trailing: svgHelper(AssetsIcon.arrow, 21.w, 21.h),
      ),
    );
  }
}
