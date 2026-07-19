import 'package:e_commerce_nti/core/helper/show_custom_snakbar.dart';
import 'package:e_commerce_nti/core/helper/svg_helper.dart';
import 'package:e_commerce_nti/core/unitles/app_color.dart';
import 'package:e_commerce_nti/core/unitles/app_text_style.dart';
import 'package:e_commerce_nti/core/unitles/asstes.dart';
import 'package:e_commerce_nti/core/widgets/coustom_elvatedbutton.dart';
import 'package:e_commerce_nti/core/widgets/custom_cartI_tem%20.dart';
import 'package:e_commerce_nti/core/widgets/custom_progress_indicator.dart';
import 'package:e_commerce_nti/features/card/presentation/view_modle/card_state/cubit/card_cubit.dart';
import 'package:e_commerce_nti/features/card/presentation/view_modle/place_order_cubit/cubit/place_order_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CheckOut extends StatelessWidget {
  const CheckOut({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PlaceOrderCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Checkout',
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
            final body = {
              "items": items.map((item) {
                return {
                  "product_id": item["productId"],
                  "quantity": item["quantity"],
                };
              }).toList(),
            };
            if (items.isEmpty) {
              return Center(
                child: Text(
                  "Your cart is empty",
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
            }

            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 31.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        svgHelper(AssetsIcon.location2, 20.w, 20.h),
                        SizedBox(width: 4.w),
                        Text(
                          'Delivery Address',
                          style: TextStyle(
                            color: AppColors.black,
                            fontSize: 14.sp,
                            fontWeight: AppTextStyle.semiBold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      children: [
                        Container(
                          padding: REdgeInsets.symmetric(
                            horizontal: 17,
                            vertical: 12,
                          ),

                          width: 220.w,
                          decoration: BoxDecoration(color: AppColors.white),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Address',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: AppTextStyle.medium,
                                  color: AppColors.black,
                                ),
                              ),
                              SizedBox(
                                height: 45.h,
                                child: TextField(
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hint: Text(
                                      'Type address here \nor pick from map',
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: AppTextStyle.regular,
                                        color: AppColors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 12.w),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            padding: REdgeInsets.symmetric(
                              horizontal: 22,
                              vertical: 19,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            child: svgHelper(
                              AssetsIcon.location,
                              33.w,
                              41.25.h,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 31.w),
                      child: Text(
                        'Shopping List',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    SizedBox(height: 10.h),

                    Column(
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

                    SizedBox(height: 61.h),
                    BlocConsumer<PlaceOrderCubit, PlaceOrderState>(
                      listener: (context, state) {
                        if (state is PlaceOrderError) {
                          showSnackBar(
                            context,
                            text: state.errorMassage,
                            state: SnackBarState.fail,
                          );
                        }
                        if (state is PlaceOrderSuccess) {
                          showSnackBar(
                            context,
                            text: state.successMassage,
                            state: SnackBarState.success,
                          );
                        }
                      },
                      builder: (context, state) {
                        if (state is PlaceOrderILoading) {
                          return CustomProgressIndicator();
                        }
                        return CustomElvatedButton(
                          onPressed: () {
                            context.read<PlaceOrderCubit>().placeOrderResponse(
                              body,
                            );
                          },
                          text: 'Place Order',
                          fontSize: 15.sp,
                        );
                      },
                    ),
                    SizedBox(height: 61.h),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
