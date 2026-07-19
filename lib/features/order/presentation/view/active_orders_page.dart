import 'package:e_commerce_nti/core/helper/show_custom_snakbar.dart';
import 'package:e_commerce_nti/core/helper/svg_helper.dart';
import 'package:e_commerce_nti/core/unitles/app_color.dart';
import 'package:e_commerce_nti/core/unitles/app_text_style.dart';
import 'package:e_commerce_nti/core/unitles/asstes.dart';
import 'package:e_commerce_nti/core/widgets/custom_progress_indicator.dart';
import 'package:e_commerce_nti/features/order/data/model/order_data.dart';
import 'package:e_commerce_nti/features/order/presentation/view/order_details.dart';
import 'package:e_commerce_nti/features/order/presentation/view/widgets/order_card.dart';
import 'package:e_commerce_nti/features/order/presentation/view_model/oredr_cubt/cubit/order_cubit.dart';
import 'package:e_commerce_nti/features/order/presentation/view_model/state_order/order_action_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ActiveOrdersPage extends StatelessWidget {
  const ActiveOrdersPage({super.key, required this.orders});

  final List<OrderData> orders;

  @override
  Widget build(BuildContext context) {
    if (orders.isEmpty) {
      return Column(
        children: [
          svgHelper(AssetsIcon.transferDocumentIcon, 140.651.w, 167.h),
          SizedBox(height: 41.h),
          Text(
            "You don't have any active orders at this time",
            style: TextStyle(
              fontSize: 30.sp,
              fontWeight: AppTextStyle.medium,
              color: AppColors.primary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      );
    }

    return BlocConsumer<OrderActionCubit, OrderActionState>(
      listener: (context, state) {
        if (state is OrderActionSuccess) {
          showSnackBar(
            context,
            text: state.successMessage,
            state: SnackBarState.success,
          );

          context.read<OrderCubit>().getOrders();
        }

        if (state is OrderActionError) {
          showSnackBar(
            context,
            text: state.errorMessage,
            state: SnackBarState.fail,
          );
        }
      },
      builder: (context, state) {
        if (state is OrderActionLoading) {
          return const Center(child: CustomProgressIndicator());
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
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        OrderDetails(order: order, isComplete: false),
                  ),
                );
              },
              onTrack: () {},
              onCancel: () {
                context.read<OrderActionCubit>().cancelOrder(order.id!);
              },
              isActive: true,
              isCompleted: false,
            );
          },
        );
      },
    );
  }
}
