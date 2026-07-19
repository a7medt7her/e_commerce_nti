import 'package:e_commerce_nti/core/helper/app_validator.dart';
import 'package:e_commerce_nti/core/helper/show_custom_snakbar.dart';
import 'package:e_commerce_nti/core/helper/svg_helper.dart';
import 'package:e_commerce_nti/core/unitles/app_color.dart';
import 'package:e_commerce_nti/core/unitles/app_text_style.dart';
import 'package:e_commerce_nti/core/unitles/asstes.dart';
import 'package:e_commerce_nti/core/widgets/coustom_elvatedbutton.dart';
import 'package:e_commerce_nti/core/widgets/coustom_textfiled.dart';
import 'package:e_commerce_nti/core/widgets/custom_progress_indicator.dart';
import 'package:e_commerce_nti/features/profile/presentation/view_model/update_profile/cubit/update_profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UpdateProfile extends StatelessWidget {
  UpdateProfile({super.key});
  final TextEditingController name = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UpdateProfileCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Profile',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: AppTextStyle.semiBold,
              color: AppColors.black,
            ),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: REdgeInsets.symmetric(horizontal: 24),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 32.h),
                  Stack(
                    children: [
                      Container(
                        width: 96.w,
                        height: 96.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(AssetsImages.userImage),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 60.w,
                        top: 50.w,
                        child: Container(
                          width: 32.w,
                          height: 32.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.blue,

                            border: BoxBorder.all(
                              color: AppColors.white,
                              width: 3,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 68.h),
                  CustomTextFiled(
                    validator: AppValidator.checkFelid,
                    prefixIcon: svgHelper(AssetsIcon.user, 24.w, 24.h),
                    hintText: 'Full Name',
                    controller: name,
                    obscureText: false,
                  ),
                  SizedBox(height: 10.h),
                  CustomTextFiled(
                    validator: AppValidator.phoneValidator,
                    prefixIcon: svgHelper(AssetsIcon.phone, 24.w, 24.h),
                    hintText: 'Phone',
                    controller: phone,
                    obscureText: false,
                  ),
                  SizedBox(height: 75.h),
                  BlocConsumer<UpdateProfileCubit, UpdateProfileState>(
                    builder: (context, state) {
                      if (state is UpdateProfileLoading) {
                        return CustomProgressIndicator();
                      }
                      return CustomElvatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            context.read<UpdateProfileCubit>().updateProfile(
                              name: name.text,
                              phone: phone.text,
                            );
                          }
                        },
                        text: 'Save',
                        fontSize: 15.sp,
                      );
                    },
                    listener: (BuildContext context, state) {
                      if (state is UpdateProfileError) {
                        showSnackBar(
                          context,
                          text: state.errorMessage,
                          state: SnackBarState.fail,
                        );
                      }
                      if (state is UpdateProfileSuccess) {
                        showSnackBar(
                          context,
                          text: state.successMessage,
                          state: SnackBarState.success,
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
