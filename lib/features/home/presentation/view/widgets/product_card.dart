import 'package:e_commerce_nti/core/helper/svg_helper.dart';
import 'package:e_commerce_nti/core/unitles/app_color.dart';
import 'package:e_commerce_nti/core/unitles/app_text_style.dart';
import 'package:e_commerce_nti/core/unitles/asstes.dart';
import 'package:e_commerce_nti/features/home/presentation/view/product_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.image,
    required this.title,
    required this.description,
    required this.price,
    required this.rating,
    this.onTap,
    required this.isFavorites,
    required this.productId,
    required this.addFavoritesPress,
  });

  final String image;
  final String title;
  final String description;
  final num price;
  final num rating;
  final int reviewCount = 152344;
  final void Function()? onTap;
  final bool isFavorites;
  final int productId;
  final void Function()? addFavoritesPress;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120.w,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductView(
                image: image,
                title: title,
                description: description,
                price: price,
                rating: rating,
                isFavorites: isFavorites,
                productId: productId,
              ),
            ),
          );
        },

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: Image.network(
                    image,
                    width: double.infinity,
                    height: 170.h,
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
                      onPressed: addFavoritesPress,
                      icon: svgHelper(
                        isFavorites ? AssetsIcon.heart : AssetsIcon.whiteHeart,
                        19.50019073486328.w,
                        17.81624412536621.h,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 10.h),

            Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: AppTextStyle.medium,
                color: Colors.black,
              ),
            ),

            SizedBox(height: 4.h),

            Text(
              description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12.sp,
                height: 1.3,
                color: AppColors.gray,
              ),
            ),

            SizedBox(height: 8.h),

            Text(
              "\$${price.toStringAsFixed(0)}",
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),

            SizedBox(height: 6.h),

            Row(
              children: [
                RatingBarIndicator(
                  rating: rating.toDouble(),
                  itemCount: 5,
                  itemSize: 15.sp,
                  unratedColor: Colors.grey.shade300,
                  itemBuilder: (context, index) =>
                      const Icon(Icons.star, color: Colors.amber),
                ),

                SizedBox(width: 6.w),

                Expanded(
                  child: Text(
                    "($reviewCount)",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 11.sp, color: Colors.grey),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
