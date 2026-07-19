import 'package:e_commerce_nti/core/helper/app_validator.dart';
import 'package:e_commerce_nti/core/helper/show_custom_snakbar.dart';
import 'package:e_commerce_nti/core/helper/svg_helper.dart';
import 'package:e_commerce_nti/core/unitles/app_color.dart';
import 'package:e_commerce_nti/core/unitles/app_text_style.dart';
import 'package:e_commerce_nti/core/unitles/asstes.dart';
import 'package:e_commerce_nti/core/widgets/coustom_elvatedbutton.dart';
import 'package:e_commerce_nti/core/widgets/coustom_textfiled.dart';
import 'package:e_commerce_nti/features/auth/presentation/view_model/login_cubit/cubit/login_cubit.dart';
import 'package:e_commerce_nti/features/home/presentation/view/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: BlocListener<LoginCubit, LoginState>(
              listener: (context, state) {
                if (state is LoginError) {
                  showSnackBar(
                    context,
                    text: state.errorMassage,
                    state: SnackBarState.fail,
                  );
                }
                if (state is LoginSuccess) {
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
                  child: BlocBuilder<LoginCubit, LoginState>(
                    builder: (context, state) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 8.h),
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: svgHelper(AssetsIcon.backArrow, 9.5.w, 19.h),
                          ),
                          SizedBox(height: 42.h),
                          Text(
                            'Welcome \nBack!',
                            style: TextStyle(
                              fontSize: 36.sp,
                              fontWeight: AppTextStyle.black,
                              color: AppColors.black,
                            ),
                          ),
                          SizedBox(height: 45.h),
                          CustomTextFiled(
                            validator: AppValidator.emailValidator,
                            hintText: 'Email',
                            controller: email,
                            obscureText: false,
                            prefixIcon: svgHelper(AssetsIcon.email, 24.w, 24.h),
                          ),
                          SizedBox(height: 22.h),
                          CustomTextFiled(
                            validator: AppValidator.passwordValidator,
                            hintText: 'Password',
                            controller: password,
                            obscureText: context
                                .read<LoginCubit>()
                                .isVisibility,
                            prefixIcon: svgHelper(
                              AssetsIcon.password,
                              24.w,
                              24.h,
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                context.read<LoginCubit>().password();
                              },
                              icon: svgHelper(AssetsIcon.eye, 20.w, 20.h),
                            ),
                          ),
                          SizedBox(height: 56.h),
                          BlocBuilder<LoginCubit, LoginState>(
                            builder: (context, state) {
                              if (state is LoginLoading) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              return CustomElvatedButton(
                                onPressed: () async {
                                  if (formKey.currentState!.validate()) {
                                    await context.read<LoginCubit>().login(
                                      email.text,
                                      password.text,
                                    );

                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => HomeView(),
                                      ),
                                      (context) => false,
                                    );
                                  }
                                },
                                text: 'Login',
                                fontSize: 20.sp,
                              );
                            },
                          ),
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
