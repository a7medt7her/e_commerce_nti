import 'package:e_commerce_nti/core/helper/show_custom_snakbar.dart';
import 'package:e_commerce_nti/core/helper/svg_helper.dart';
import 'package:e_commerce_nti/core/unitles/app_color.dart';
import 'package:e_commerce_nti/core/unitles/app_text_style.dart';
import 'package:e_commerce_nti/core/unitles/asstes.dart';
import 'package:e_commerce_nti/core/widgets/coustom_elvatedbutton.dart';
import 'package:e_commerce_nti/features/card/presentation/view_modle/card_state/cubit/card_cubit.dart';
import 'package:e_commerce_nti/features/home/presentation/view_model/product_view_cubit/cubit/product_view_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductView extends StatelessWidget {
  const ProductView({
    super.key,
    required this.image,
    required this.title,
    required this.description,
    required this.price,
    required this.rating,
    required this.isFavorites,
    required this.productId,
  });
  final String image;
  final String title;
  final String description;
  final num price;
  final num rating;
  final int reviewCount = 152344;

  final bool isFavorites;
  final int productId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductViewCubit(price: price),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Product',
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
              onPressed: () {
                Navigator.pop(context);
              },
              icon: svgHelper(AssetsIcon.backArrow, 9.5.w, 19.h),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: REdgeInsets.symmetric(horizontal: 35),
            child: BlocBuilder<ProductViewCubit, ProductViewState>(
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.r),
                          child: Image.network(
                            image,
                            width: 306.w,
                            height: 308.h,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Container(
                              height: 170.h,
                              color: Colors.grey.shade200,
                              child: const Icon(Icons.image_not_supported),
                            ),
                          ),
                        ),
                        Align(
                          alignment: AlignmentGeometry.topRight,
                          child: Container(
                            width: 37.w,
                            height: 37.h,
                            decoration: BoxDecoration(
                              color: AppColors.gray,
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              onPressed: () {},
                              icon: svgHelper(
                                isFavorites
                                    ? AssetsIcon.heart
                                    : AssetsIcon.whiteHeart,
                                19.50019073486328.w,
                                17.81624412536621.h,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 36.h),

                    Text(
                      title,

                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: AppTextStyle.semiBold,
                        color: Colors.black,
                      ),
                    ),

                    SizedBox(height: 16.h),

                    Text(
                      description,

                      style: TextStyle(
                        fontSize: 14.sp,
                        height: 1.3,
                        fontWeight: AppTextStyle.regular,
                        color: AppColors.black,
                      ),
                    ),

                    SizedBox(height: 32.h),

                    Row(
                      children: [
                        Text(
                          "${state.totalPrice} \$",
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: AppTextStyle.semiBold,
                            color: AppColors.primary,
                          ),
                        ),
                        Spacer(),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                context.read<ProductViewCubit>().decrement();
                              },
                              child: Container(
                                width: 24.sp,
                                height: 24.sp,
                                decoration: BoxDecoration(
                                  color: AppColors.pink,
                                  borderRadius: BorderRadius.circular(5.r),
                                ),
                                child: Icon(
                                  Icons.remove,
                                  color: AppColors.white,
                                ),
                              ),
                            ),
                            SizedBox(width: 10.w),
                            Text(
                              state.quantity.toString(),
                              style: TextStyle(
                                fontSize: 24.43.sp,
                                fontWeight: AppTextStyle.regular,
                                color: Color(0xFF391713),
                              ),
                            ),
                            SizedBox(width: 10.w),
                            GestureDetector(
                              onTap: () {
                                context.read<ProductViewCubit>().increment();
                              },
                              child: Container(
                                width: 24.sp,
                                height: 24.sp,
                                decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  borderRadius: BorderRadius.circular(5.r),
                                ),
                                child: Icon(Icons.add, color: AppColors.white),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    SizedBox(height: 49.h),
                    CustomElvatedButton(
                      onPressed: () {
                        showSnackBar(
                          context,
                          text: 'added',
                          state: SnackBarState.success,
                        );
                        context.read<CartCubit>().addToCart(
                          productId: productId,
                          image: image,
                          title: title,
                          price: price,
                          rating: rating,
                          quantity: state.quantity,
                        );
                      },
                      text: 'Add To Cart',
                      fontSize: 15.sp,
                      sizedBoxWidth: 14.w,
                      widget: svgHelper(AssetsIcon.shoppingCart2, 24.w, 24.h),
                    ),
                    SizedBox(height: 122.h),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
