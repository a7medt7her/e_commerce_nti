import 'package:e_commerce_nti/core/helper/svg_helper.dart';
import 'package:e_commerce_nti/core/unitles/app_color.dart';
import 'package:e_commerce_nti/core/unitles/app_text_style.dart';
import 'package:e_commerce_nti/core/unitles/asstes.dart';
import 'package:e_commerce_nti/features/home/presentation/view_model/pages_cubit/cubit/pages_cubit.dart';
import 'package:e_commerce_nti/features/order/presentation/view/active_orders_page.dart';
import 'package:e_commerce_nti/features/order/presentation/view/cancelled_orders_page.dart';
import 'package:e_commerce_nti/features/order/presentation/view/completed_orders_page.dart';
import 'package:e_commerce_nti/features/order/presentation/view/widgets/states_order.dart';
import 'package:e_commerce_nti/features/order/presentation/view_model/oredr_cubt/cubit/order_cubit.dart';
import 'package:e_commerce_nti/features/order/presentation/view_model/state_order/order_action_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyOrder extends StatelessWidget {
  MyOrder({super.key});

  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => PagesCubit()),
        BlocProvider(create: (_) => OrderCubit()..getOrders()),
        BlocProvider(create: (_) => OrderActionCubit()),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'My Orders',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: AppTextStyle.semiBold,
              color: AppColors.black,
            ),
          ),
          centerTitle: true,
          leading: Padding(
            padding: REdgeInsets.symmetric(horizontal: 17),
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: svgHelper(AssetsIcon.backArrow, 9.5.w, 19.h),
            ),
          ),
        ),
        body: BlocBuilder<OrderCubit, OrderState>(
          builder: (context, orderState) {
            if (orderState is OrdersLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (orderState is OrdersError) {
              return Center(child: Text(orderState.error));
            }

            if (orderState is OrdersSuccess) {
              final pages = [
                ActiveOrdersPage(orders: orderState.orders.active ?? []),
                CompletedOrdersPage(orders: orderState.orders.completed ?? []),
                CancelledOrdersPage(orders: orderState.orders.canceled ?? []),
              ];

              return Padding(
                padding: REdgeInsets.symmetric(horizontal: 26),
                child: BlocBuilder<PagesCubit, int>(
                  builder: (context, pageState) {
                    return Column(
                      children: [
                        SizedBox(height: 44.h),

                        StatesOrder(
                          currentIndex: pageState,
                          onTap: (index) {
                            pageController.animateToPage(
                              index,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );

                            context.read<PagesCubit>().pageNavigator(index);
                          },
                        ),

                        SizedBox(height: 40.h),

                        Expanded(
                          child: PageView.builder(
                            controller: pageController,
                            itemCount: pages.length,
                            onPageChanged: (index) {
                              context.read<PagesCubit>().pageNavigator(index);
                            },
                            itemBuilder: (context, index) {
                              return pages[index];
                            },
                          ),
                        ),
                      ],
                    );
                  },
                ),
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}
