import 'package:e_commerce_nti/core/helper/secure_storage_service.dart';
import 'package:e_commerce_nti/core/helper/svg_helper.dart';
import 'package:e_commerce_nti/core/services/app_dependencies.dart';
import 'package:e_commerce_nti/core/unitles/app_color.dart';
import 'package:e_commerce_nti/core/unitles/app_text_style.dart';
import 'package:e_commerce_nti/core/unitles/asstes.dart';
import 'package:e_commerce_nti/features/auth/presentation/view/login_view.dart';
import 'package:e_commerce_nti/features/my%20_favorites/presentation/view/my_favorit_viiew.dart';
import 'package:e_commerce_nti/features/order/presentation/view/my_order.dart';
import 'package:e_commerce_nti/features/profile/presentation/view/app_setting.dart';
import 'package:e_commerce_nti/features/profile/presentation/view/update_profile.dart';
import 'package:e_commerce_nti/features/profile/presentation/view/widgets/setting_tile.dart';
import 'package:e_commerce_nti/features/profile/presentation/view_model/get_user_data/cubit/user_data_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserDataCubit()..getUserData(),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 32.h),
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
                SizedBox(height: 19.h),
                BlocBuilder<UserDataCubit, UserDataState>(
                  builder: (context, state) {
                    if (state is UserDataSuccess) {
                      var name = state.user.name;
                      return Text(
                        '$name',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: AppTextStyle.semiBold,
                          color: AppColors.primary,
                        ),
                      );
                    }
                    return SizedBox();
                  },
                ),
                SizedBox(height: 54.h),
                SettingTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => UpdateProfile()),
                    );
                  },
                  leading: svgHelper(
                    AssetsIcon.profileIconlyPro,
                    17.15999984741211.w,
                    21.526268005371094.h,
                  ),
                  text: 'My Profile',
                ),
                SizedBox(height: 36.h),
                SettingTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyOrder()),
                    );
                  },
                  leading: svgHelper(
                    AssetsIcon.bagIconlyPro,
                    17.15999984741211.w,
                    21.526268005371094.h,
                  ),
                  text: 'My Orders',
                ),
                SizedBox(height: 36.h),
                SettingTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyFavoriteView()),
                    );
                  },
                  leading: svgHelper(
                    AssetsIcon.heartIconlyPro,
                    17.15999984741211.w,
                    21.526268005371094.h,
                  ),
                  text: 'My Favorites',
                ),
                SizedBox(height: 36.h),
                SettingTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AppSettings()),
                    );
                  },
                  leading: svgHelper(
                    AssetsIcon.settingIconlyPro,
                    17.15999984741211.w,
                    21.526268005371094.h,
                  ),
                  text: 'Settings',
                ),
                SizedBox(height: 36.h),
                Divider(color: AppColors.primary),
                SizedBox(height: 42.h),
                SettingTile(
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => LoginView()),
                      (context) => false,
                    );
                    getIt.get<SecureStorageService>().logout();
                  },
                  leading: svgHelper(
                    AssetsIcon.logoutIconlyPro,
                    17.15999984741211.w,
                    21.526268005371094.h,
                  ),
                  text: 'Log Out',
                ),
                SizedBox(height: 88.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
