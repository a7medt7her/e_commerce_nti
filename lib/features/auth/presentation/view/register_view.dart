import 'package:e_commerce_nti/core/helper/app_validator.dart';
import 'package:e_commerce_nti/core/helper/show_custom_snakbar.dart';
import 'package:e_commerce_nti/core/helper/svg_helper.dart';
import 'package:e_commerce_nti/core/unitles/app_color.dart';
import 'package:e_commerce_nti/core/unitles/app_text_style.dart';
import 'package:e_commerce_nti/core/unitles/asstes.dart';
import 'package:e_commerce_nti/core/widgets/coustom_elvatedbutton.dart';
import 'package:e_commerce_nti/core/widgets/coustom_textfiled.dart';
import 'package:e_commerce_nti/features/auth/presentation/view/login_view.dart';
import 'package:e_commerce_nti/features/auth/presentation/view_model/register_cubit/cubit/register_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterView extends StatelessWidget {
  RegisterView({super.key});
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController name = TextEditingController();
  final TextEditingController phone = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: BlocListener<RegisterCubit, RegisterState>(
              listener: (context, state) {
                if (state is RegisterError) {
                  showSnackBar(
                    context,
                    text: state.errorMassage,
                    state: SnackBarState.fail,
                  );
                }
                if (state is RegisterSuccess) {
                  showSnackBar(
                    context,
                    text: state.successMassage,
                    state: SnackBarState.success,
                  );
                }
              },
              child: Form(
                key: formKey,
                child: Padding(
                  padding: REdgeInsets.symmetric(horizontal: 32),
                  child: BlocBuilder<RegisterCubit, RegisterState>(
                    builder: (context, state) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 11.h),
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: svgHelper(AssetsIcon.backArrow, 9.5.w, 19.h),
                          ),
                          SizedBox(height: 39.h),
                          Text(
                            'Create an \naccount',
                            style: TextStyle(
                              fontSize: 36.sp,
                              fontWeight: AppTextStyle.black,
                              color: AppColors.black,
                            ),
                          ),
                          SizedBox(height: 33.h),
                          CustomTextFiled(
                            validator: AppValidator.checkFelid,
                            hintText: 'Name',
                            controller: name,
                            obscureText: false,
                            prefixIcon: svgHelper(AssetsIcon.user, 24.w, 24.h),
                          ),
                          SizedBox(height: 10.h),
                          CustomTextFiled(
                            validator: AppValidator.checkFelid,
                            hintText: 'Phone',
                            controller: phone,
                            obscureText: false,
                            prefixIcon: svgHelper(AssetsIcon.phone, 24.w, 24.h),
                          ),
                          SizedBox(height: 10.h),
                          CustomTextFiled(
                            validator: AppValidator.emailValidator,
                            hintText: 'Email',
                            controller: email,
                            obscureText: false,
                            prefixIcon: svgHelper(AssetsIcon.email, 24.w, 24.h),
                          ),
                          SizedBox(height: 10.h),
                          CustomTextFiled(
                            validator: AppValidator.passwordValidator,
                            hintText: 'Password',
                            controller: password,
                            obscureText: context
                                .read<RegisterCubit>()
                                .isVisibility,
                            prefixIcon: svgHelper(
                              AssetsIcon.password,
                              24.w,
                              24.h,
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                context.read<RegisterCubit>().password();
                              },
                              icon: svgHelper(AssetsIcon.eye, 20.w, 20.h),
                            ),
                          ),
                          SizedBox(height: 10.h),
                          CustomTextFiled(
                            validator: (value) {
                              return AppValidator.passwordConfirmValidator(
                                value,
                                password.text,
                              );
                            },
                            hintText: 'Confirm Password',
                            controller: confirmPassword,
                            obscureText: context
                                .read<RegisterCubit>()
                                .isVisibility,
                            prefixIcon: svgHelper(
                              AssetsIcon.password,
                              24.w,
                              24.h,
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                context.read<RegisterCubit>().password();
                              },
                              icon: svgHelper(AssetsIcon.eye, 20.w, 20.h),
                            ),
                          ),
                          SizedBox(height: 21.h),
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'By clicking the ',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: AppTextStyle.regular,
                                    color: AppColors.black,
                                  ),
                                ),
                                TextSpan(
                                  text: 'Register ',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: AppTextStyle.regular,
                                    color: AppColors.primary,
                                  ),
                                ),
                                TextSpan(
                                  text: 'button, you agree to the public offer',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: AppTextStyle.regular,
                                    color: AppColors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 25.h),
                          BlocBuilder<RegisterCubit, RegisterState>(
                            builder: (context, state) {
                              if (state is RegisterLoading) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              return CustomElvatedButton(
                                onPressed: () async {
                                  if (formKey.currentState!.validate()) {
                                    await context.read<RegisterCubit>().login(
                                      email.text,
                                      password.text,
                                      name.text,
                                      phone.text,
                                    );
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => LoginView(),
                                      ),
                                    );
                                  }
                                },
                                text: 'Create Account',
                                fontSize: 20.sp,
                              );
                            },
                          ),
                          SizedBox(height: 131.h),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
