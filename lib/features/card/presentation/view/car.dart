import 'package:e_commerce_nti/core/helper/show_custom_snakbar.dart';
import 'package:e_commerce_nti/core/helper/svg_helper.dart';
import 'package:e_commerce_nti/core/unitles/app_color.dart';
import 'package:e_commerce_nti/core/unitles/app_text_style.dart';
import 'package:e_commerce_nti/core/unitles/asstes.dart';
import 'package:e_commerce_nti/core/widgets/coustom_elvatedbutton.dart';
import 'package:e_commerce_nti/core/widgets/custom_cartI_tem .dart';
import 'package:e_commerce_nti/features/card/presentation/view/check_out.dart';
import 'package:e_commerce_nti/features/card/presentation/view_modle/card_state/cubit/card_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Car extends StatelessWidget {
  const Car({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cart',
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
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          final items = state.items;

          final subtotal = items.fold<double>(
            0,
            (sum, item) =>
                sum +
                (item["price"] as num).toDouble() * (item["quantity"] as int),
          );

          const tax = 3.0;
          const delivery = 2.0;

          final total = subtotal + tax + delivery;

          if (items.isEmpty) {
            return Center(
              child: Text(
                "Your cart is empty",
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: AppTextStyle.semiBold,
                ),
              ),
            );
          }

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 31.w),
                  child: Text(
                    'Shopping List',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: AppTextStyle.semiBold,
                    ),
                  ),
                ),

                SizedBox(height: 10.h),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 31.w),
                  child: Column(
                    children: List.generate(items.length, (index) {
                      final item = items[index];

                      return Padding(
                        padding: EdgeInsets.only(
                          bottom: index == items.length - 1 ? 0 : 25.h,
                        ),
                        child: CustomCartItem(
                          productId: item["productId"],
                          image: item["image"],
                          title: item["title"],
                          rating: item["rating"],
                          price: item["price"],
                          oldPrice: item["price"],
                          quantity: item["quantity"],

                          onIncrement: () {
                            context.read<CartCubit>().increment(
                              item["productId"],
                            );
                          },

                          onDecrement: () {
                            context.read<CartCubit>().decrement(
                              item["productId"],
                            );
                          },
                          needButton: true,
                        ),
                      );
                    }),
                  ),
                ),

                SizedBox(height: 25.h),

                const Divider(color: Color(0xffCACACA), thickness: 1),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 19.w),
                  child: Column(
                    children: [
                      SizedBox(height: 16.h),

                      _priceRow(
                        title: "Subtotal",
                        value: "\$${subtotal.toStringAsFixed(2)}",
                      ),

                      SizedBox(height: 12.h),

                      _priceRow(
                        title: "Tax and Fees",
                        value: "\$${tax.toStringAsFixed(2)}",
                      ),

                      SizedBox(height: 12.h),

                      _priceRow(
                        title: "Delivery Fee",
                        value: "\$${delivery.toStringAsFixed(2)}",
                      ),

                      SizedBox(height: 19.h),

                      const Divider(color: Color(0xffCACACA), thickness: 1),

                      SizedBox(height: 19.h),

                      Row(
                        children: [
                          Text(
                            "Order Total",
                            style: TextStyle(
                              fontSize: 17.sp,
                              fontWeight: AppTextStyle.medium,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            "\$${total.toStringAsFixed(2)}",
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: AppTextStyle.semiBold,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 58.h),
                    ],
                  ),
                ),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 33.w),
                  child: CustomElvatedButton(
                    onPressed: () {
                      showSnackBar(
                        context,
                        text: 'Added',
                        state: SnackBarState.success,
                      );
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => CheckOut()),
                      );
                    },
                    text: "Checkout",
                    fontSize: 15.sp,
                  ),
                ),

                SizedBox(height: 30.h),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _priceRow({required String title, required String value}) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
        ),
        const Spacer(),
        Text(
          value,
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
