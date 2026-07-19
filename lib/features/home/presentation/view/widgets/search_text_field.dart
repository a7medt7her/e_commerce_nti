import 'package:e_commerce_nti/core/helper/app_validator.dart';
import 'package:e_commerce_nti/core/helper/svg_helper.dart';
import 'package:e_commerce_nti/core/unitles/app_color.dart';
import 'package:e_commerce_nti/core/unitles/app_text_style.dart';
import 'package:e_commerce_nti/core/unitles/asstes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({super.key, this.onFieldSubmitted, this.onChanged});

  final void Function(String)? onFieldSubmitted;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.02),
            offset: Offset(0, 2),
            spreadRadius: 0,
            blurRadius: 9,
          ),
        ],
      ),
      child: TextFormField(
        validator: AppValidator.checkFelid,
        onChanged: onChanged,
        onFieldSubmitted: onFieldSubmitted,

        decoration: InputDecoration(
          border: InputBorder.none,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6.sp),
            borderSide: BorderSide(color: AppColors.gray),
          ),
          fillColor: AppColors.white,
          filled: true,
          prefixIcon: Padding(
            padding: REdgeInsets.symmetric(horizontal: 15),
            child: svgHelper(AssetsIcon.search, 20.w, 20.h),
          ),
          hint: Text(
            'Search any Product..',
            style: TextStyle(
              color: AppColors.lightGray2,
              fontSize: 14.sp,
              fontWeight: AppTextStyle.regular,
            ),
          ),
        ),
      ),
    );
  }
}
