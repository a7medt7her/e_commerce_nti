import 'package:e_commerce_nti/core/unitles/app_color.dart';
import 'package:e_commerce_nti/core/unitles/app_text_style.dart';
import 'package:e_commerce_nti/features/order/data/model/order_data.dart';
import 'package:e_commerce_nti/features/order/presentation/view/widgets/order_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CancelledOrdersPage extends StatelessWidget {
  const CancelledOrdersPage({super.key, required this.orders});

  final List<OrderData> orders;

  @override
  Widget build(BuildContext context) {
    if (orders.isEmpty) {
      return Center(
        child: Text(
          "No Cancelled Orders",
          style: TextStyle(
            fontSize: 30.sp,
            fontWeight: AppTextStyle.medium,
            color: AppColors.primary,
          ),
        ),
      );
    }

    return ListView.separated(
      padding: EdgeInsets.only(bottom: 20.h),
      itemCount: orders.length,
      separatorBuilder: (_, __) => SizedBox(height: 16.h),
      itemBuilder: (context, index) {
        final order = orders[index];
        final item = order.items!.first;

        return OrderCard(
          image: item.imagePath!,
          date: order.orderDate!,
          price: order.total!,
          quantity: item.quantity!,
          onTap: () {},
          isActive: false,
          isCompleted: false,
        );
      },
    );
  }
}
