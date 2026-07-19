import 'package:e_commerce_nti/core/services/app_dependencies.dart';
import 'package:e_commerce_nti/core/unitles/app_color.dart';
import 'package:e_commerce_nti/features/card/presentation/view_modle/card_state/cubit/card_cubit.dart';
import 'package:e_commerce_nti/features/start/presentation/view/splash_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupServices();
  await initializeDateFormatting();
  runApp(BlocProvider(create: (context) => CartCubit(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (_, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,

          theme: ThemeData(
            appBarTheme: AppBarTheme(backgroundColor: AppColors.white),
            scaffoldBackgroundColor: AppColors.background,
            fontFamily: 'Montserrat',
          ),
          home: SplashScreen(),
        );
      },
    );
  }
}
