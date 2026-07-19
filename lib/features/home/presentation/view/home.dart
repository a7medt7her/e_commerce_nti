import 'package:e_commerce_nti/core/helper/svg_helper.dart';
import 'package:e_commerce_nti/core/unitles/app_color.dart';

import 'package:e_commerce_nti/core/unitles/asstes.dart';
import 'package:e_commerce_nti/features/card/presentation/view/car.dart';
import 'package:e_commerce_nti/features/home/presentation/view/home_view.dart';
import 'package:e_commerce_nti/features/items/presentation/view/item_view.dart';
import 'package:e_commerce_nti/features/home/presentation/view_model/pages_cubit/cubit/pages_cubit.dart';
import 'package:e_commerce_nti/features/profile/presentation/view/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Home extends StatelessWidget {
  Home({super.key});
  final List<Widget> pages = [HomeView(), ItemView(), ProfileView()];
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PagesCubit(),
      child: BlocBuilder<PagesCubit, int>(
        builder: (context, state) {
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              shape: const CircleBorder(),
              backgroundColor: AppColors.primary,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Car()),
                );
              },
              child: svgHelper(AssetsIcon.bag, 24.w, 26.666671752929688.h),
            ),
            body: pages[state],
            bottomNavigationBar: BottomNavigationBar(
              onTap: (value) {
                context.read<PagesCubit>().pageNavigator(value);
              },
              currentIndex: state,
              backgroundColor: Colors.white,
              items: [
                BottomNavigationBarItem(
                  activeIcon: svgHelper(AssetsIcon.home1, 24.w, 24.h),
                  label: 'Home',
                  icon: Padding(
                    padding: REdgeInsets.only(top: 0),
                    child: svgHelper(AssetsIcon.home, 24.w, 24.h),
                  ),
                ),
                BottomNavigationBarItem(
                  activeIcon: svgHelper(AssetsIcon.shoppingCart0, 24.w, 24.h),

                  label: 'Items',
                  icon: svgHelper(AssetsIcon.shoppingCart1, 24.w, 24.h),
                ),
                BottomNavigationBarItem(
                  activeIcon: svgHelper(AssetsIcon.profile, 24.w, 24.h),
                  label: 'Profile',
                  icon: svgHelper(AssetsIcon.profileIconlyPro, 24.w, 24.h),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
