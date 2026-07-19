import 'package:e_commerce_nti/core/helper/svg_helper.dart';
import 'package:e_commerce_nti/core/unitles/app_color.dart';
import 'package:e_commerce_nti/core/unitles/app_text_style.dart';
import 'package:e_commerce_nti/core/unitles/asstes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppSettings extends StatefulWidget {
  const AppSettings({super.key});

  @override
  State<AppSettings> createState() => _AppSettingsState();
}

String language = 'En';

class _AppSettingsState extends State<AppSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: REdgeInsets.only(left: 20),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: svgHelper(AssetsIcon.backArrow, 21.w, 21.h),
          ),
        ),
        centerTitle: true,
        title: Text(
          'App Settings',
          style: TextStyle(
            fontSize: 19.sp,
            fontWeight: AppTextStyle.semiBold,
            color: AppColors.black,
          ),
        ),
      ),
      body: Padding(
        padding: REdgeInsets.symmetric(horizontal: 27),
        child: Column(
          children: [
            SizedBox(height: 71.h),
            Row(
              children: [
                Text(
                  'Language',
                  style: TextStyle(
                    fontWeight: AppTextStyle.medium,
                    fontSize: 20.sp,
                    color: AppColors.black,
                  ),
                ),
                Spacer(),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          language = 'Ar';
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: language == 'Ar'
                              ? AppColors.primary
                              : AppColors.pink,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(5.r),
                            bottomRight: Radius.circular(5.r),
                          ),
                        ),
                        child: Padding(
                          padding: REdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            'Ar',
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: AppTextStyle.medium,
                              color: language == 'Ar'
                                  ? AppColors.white
                                  : AppColors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          language = 'En';
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: language == 'En'
                              ? AppColors.primary
                              : AppColors.pink,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5.r),
                            bottomLeft: Radius.circular(5.r),
                          ),
                        ),
                        child: Padding(
                          padding: REdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            'En',
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: AppTextStyle.medium,
                              color: language == 'En'
                                  ? AppColors.white
                                  : AppColors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
