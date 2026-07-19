import 'package:e_commerce_nti/core/helper/svg_helper.dart';
import 'package:e_commerce_nti/core/unitles/app_color.dart';
import 'package:e_commerce_nti/core/unitles/app_text_style.dart';
import 'package:e_commerce_nti/core/unitles/asstes.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({
    super.key,
    required this.image,
    required this.date,
    required this.price,
    required this.quantity,
    this.onTap,
    this.onCancel,
    this.onTrack,
    required this.isActive,
    required this.isCompleted,
  });

  final String image;
  final String date;
  final double price;
  final int quantity;

  final VoidCallback? onTap;
  final VoidCallback? onCancel;
  final VoidCallback? onTrack;
  final bool isActive;
  final bool isCompleted;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              spreadRadius: 0,
              offset: Offset(0, 4),
              blurRadius: 4,
              color: AppColors.black.withValues(alpha: 0.25),
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 103.w,
              height: 106.h,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Image.network(image, fit: BoxFit.cover),
            ),

            SizedBox(width: 11.w),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Mens Starry",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),

                      Text(
                        "\$${price.toStringAsFixed(0)}",
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 11.h),

                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          date,
                          style: TextStyle(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey,
                          ),
                        ),
                      ),

                      Text(
                        "$quantity item",
                        style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 18.h),

                  isActive
                      ? Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: onCancel,
                                child: Container(
                                  height: 42.h,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: const Color(0xffF83758),
                                    borderRadius: BorderRadius.circular(30.r),
                                  ),
                                  child: Text(
                                    "Cancel",

                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(width: 8.w),

                            Expanded(
                              child: GestureDetector(
                                onTap: onTrack,
                                child: Container(
                                  height: 42.h,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: const Color(0xffF83758),
                                    borderRadius: BorderRadius.circular(30.r),
                                  ),
                                  child: Text(
                                    "Track Driver",

                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      : Row(
                          children: [
                            isCompleted
                                ? svgHelper(AssetsIcon.done, 12.w, 12.h)
                                : svgHelper(AssetsIcon.canceled, 12.w, 12.h),
                            SizedBox(width: 5),
                            Text(
                              isCompleted
                                  ? 'Order delivered'
                                  : 'Order Canceled',
                              style: TextStyle(
                                color: AppColors.primary,
                                fontSize: 14.sp,
                                fontWeight: AppTextStyle.light,
                              ),
                            ),
                          ],
                        ),
                  SizedBox(height: 10.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
