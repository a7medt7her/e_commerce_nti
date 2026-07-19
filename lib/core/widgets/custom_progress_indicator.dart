import 'package:e_commerce_nti/core/unitles/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomProgressIndicator extends StatelessWidget {
  const CustomProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator(color: AppColors.primary));
  }
}
