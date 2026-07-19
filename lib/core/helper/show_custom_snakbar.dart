import 'package:e_commerce_nti/core/unitles/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum SnackBarState { success, fail, warning, info }

showSnackBar(context, {required String text, required SnackBarState state}) {
  IconData icon;
  Color color;
  switch (state) {
    case SnackBarState.success:
      color = AppColors.success;
      icon = Icons.check_circle;
    case SnackBarState.fail:
      color = AppColors.error;
      icon = Icons.error;
    case SnackBarState.warning:
      color = AppColors.warning;
      icon = Icons.warning;
    case SnackBarState.info:
      color = AppColors.gray;
      icon = Icons.info;
  }
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: color,
      content: Row(
        children: [
          Icon(icon, color: AppColors.white),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(text, style: TextStyle(color: AppColors.white)),
          ),
        ],
      ),
    ),
  );
}
