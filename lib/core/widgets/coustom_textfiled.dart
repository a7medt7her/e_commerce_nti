import 'package:e_commerce_nti/core/unitles/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFiled extends StatelessWidget {
  const CustomTextFiled({
    super.key,
    this.prefixIcon,
    this.suffixIcon,
    required this.hintText,
    required this.controller,

    required this.obscureText,
    this.validator,

    this.readOnly,
  });
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String hintText;
  final TextEditingController controller;

  final bool obscureText;
  final String? Function(String?)? validator;
  final bool? readOnly;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      obscureText: obscureText,
      controller: controller,
      decoration: InputDecoration(
        fillColor: AppColors.textFiled,
        filled: true,
        suffixIcon: Padding(
          padding: EdgeInsets.only(left: 16.w, right: 15.w),
          child: suffixIcon,
        ),

        prefixIcon: prefixIcon == null
            ? null
            : Padding(
                padding: EdgeInsets.only(left: 16.w, right: 15.w),
                child: prefixIcon,
              ),
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.darkGray,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(color: AppColors.gray),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(color: AppColors.gray),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(color: AppColors.gray),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(color: AppColors.error),
        ),
      ),
    );
  }
}
