import 'package:e_commerce_nti/core/unitles/app_color.dart';
import 'package:e_commerce_nti/core/unitles/app_text_style.dart';
import 'package:e_commerce_nti/core/unitles/asstes.dart';
import 'package:e_commerce_nti/core/widgets/coustom_elvatedbutton.dart';
import 'package:e_commerce_nti/features/auth/presentation/view/login_view.dart';
import 'package:e_commerce_nti/features/auth/presentation/view/register_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GetStart extends StatelessWidget {
  const GetStart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(AssetsImages.getStart, fit: BoxFit.cover),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0.h,

            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: AlignmentGeometry.topCenter,
                  end: AlignmentGeometry.bottomCenter,
                  colors: [
                    AppColors.black.withValues(alpha: 0),
                    AppColors.black.withValues(alpha: 0.63),
                  ],
                ),
              ),

              child: Padding(
                padding: REdgeInsets.symmetric(horizontal: 55),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(height: 10.h),
                    Text(
                      'You want Authentic, here you go!',
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 34.sp,
                        fontWeight: AppTextStyle.semiBold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 24.h),
                    Text(
                      'You want Authentic, here you go!',
                      style: TextStyle(
                        color: AppColors.lightGray3,
                        fontSize: 14.sp,
                        fontWeight: AppTextStyle.regular,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 24.h),
                    CustomElvatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginView()),
                        );
                      },
                      text: 'Login',
                      fontSize: 23.sp,
                    ),
                    SizedBox(height: 15.h),
                    CustomElvatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RegisterView(),
                          ),
                        );
                      },
                      text: 'Register',
                      fontSize: 23.sp,
                      textColor: AppColors.primary,
                      colorContainer: AppColors.white,
                      border: Border.all(width: 1, color: AppColors.primary),
                    ),
                    SizedBox(height: 34.h),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
