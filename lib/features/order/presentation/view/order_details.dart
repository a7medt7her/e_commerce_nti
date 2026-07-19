import 'package:e_commerce_nti/core/helper/svg_helper.dart';
import 'package:e_commerce_nti/core/unitles/app_color.dart';
import 'package:e_commerce_nti/core/unitles/app_text_style.dart';
import 'package:e_commerce_nti/core/unitles/asstes.dart';
import 'package:e_commerce_nti/core/widgets/custom_cartI_tem%20.dart';
import 'package:e_commerce_nti/features/order/data/model/order_data.dart';
import 'package:e_commerce_nti/features/order/presentation/view_model/state_order/order_action_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class OrderDetails extends StatelessWidget {
  const OrderDetails({
    super.key,
    required this.order,
    required this.isComplete,
  });
  final bool isComplete;
  final OrderData order;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrderActionCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Order Details',
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
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 36.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 31.w),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Order No. 005',
                          style: TextStyle(
                            color: AppColors.black,
                            fontSize: 20.sp,
                            fontWeight: AppTextStyle.medium,
                          ),
                        ),
                        Text(
                          DateFormat(
                            'EEE d MMMM, yyyy',
                            'en',
                          ).format(DateTime.now()),
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: AppTextStyle.light,
                            color: AppColors.black,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Text(
                      isComplete ? 'Completed' : 'Active',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 20.sp,
                        fontWeight: AppTextStyle.medium,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 31.w),
                child: Column(
                  children: List.generate(order.items!.length, (index) {
                    final item = order.items![index];

                    return Padding(
                      padding: EdgeInsets.only(
                        bottom: index == order.items!.length - 1 ? 0 : 25.h,
                      ),
                      child: CustomCartItem(
                        productId: item.id!,
                        image: item.imagePath!,
                        title: item.name!,
                        rating: item.rating!,
                        price: item.price!,
                        oldPrice: item.price!,
                        quantity: item.quantity!,

                        needButton: false,

                        onIncrement: null,
                        onDecrement: null,
                      ),
                    );
                  }),
                ),
              ),

              SizedBox(height: 25.h),

              const Divider(),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  children: [
                    SizedBox(height: 16.h),

                    _priceRow(
                      "Subtotal",
                      "\$${order.subtotal!.toStringAsFixed(2)}",
                    ),

                    SizedBox(height: 12.h),

                    _priceRow("Tax", "\$${order.tax!.toStringAsFixed(2)}"),

                    SizedBox(height: 12.h),

                    _priceRow(
                      "Shipping",
                      "\$${order.shipping!.toStringAsFixed(2)}",
                    ),

                    SizedBox(height: 16.h),

                    const Divider(),

                    SizedBox(height: 16.h),

                    _priceRow(
                      "Order Total",
                      "\$${order.total!.toStringAsFixed(2)}",
                      isTotal: true,
                    ),

                    SizedBox(height: 30.h),
                    isComplete
                        ? SizedBox()
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  context.read<OrderActionCubit>().cancelOrder(
                                    order.id!,
                                  );
                                },
                                child: Container(
                                  padding: REdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 9,
                                  ),
                                  height: 42.h,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: const Color(0xffF83758),
                                    borderRadius: BorderRadius.circular(30.r),
                                  ),
                                  child: Text(
                                    "Cancel Order",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12.sp,
                                      fontWeight: AppTextStyle.extraBold,
                                    ),
                                  ),
                                ),
                              ),

                              SizedBox(width: 8.w),

                              GestureDetector(
                                onTap: () {},
                                child: Container(
                                  padding: REdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 9,
                                  ),
                                  height: 42.h,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: const Color(0xffF83758),
                                    borderRadius: BorderRadius.circular(30.r),
                                  ),
                                  child: Text(
                                    "Track Driver",

                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12.sp,
                                      fontWeight: AppTextStyle.extraBold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                    SizedBox(height: 30.h),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _priceRow(String title, String value, {bool isTotal = false}) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: isTotal ? 17.sp : 16.sp,
            fontWeight: isTotal ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 17.sp : 16.sp,
            fontWeight: FontWeight.w600,
            color: isTotal ? AppColors.primary : Colors.black,
          ),
        ),
      ],
    );
  }
}
