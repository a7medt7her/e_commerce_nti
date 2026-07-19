import 'package:e_commerce_nti/core/helper/svg_helper.dart';
import 'package:e_commerce_nti/core/unitles/app_color.dart';
import 'package:e_commerce_nti/core/unitles/app_text_style.dart';
import 'package:e_commerce_nti/core/unitles/asstes.dart';
import 'package:e_commerce_nti/features/home/data/models/products_model.dart';
import 'package:e_commerce_nti/features/home/presentation/view/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

List<Products> myFavoriteProducts = [];

class MyFavoriteView extends StatelessWidget {
  const MyFavoriteView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Search',
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
        body: myFavoriteProducts.isEmpty
            ? Text('Empty')
            : SingleChildScrollView(
                child: Padding(
                  padding: REdgeInsets.symmetric(horizontal: 17),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 34.h),

                      SizedBox(height: 17.h),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 17.w,
                          mainAxisSpacing: 17.h,
                          childAspectRatio: 0.52,
                        ),
                        itemCount: myFavoriteProducts.length,
                        itemBuilder: (context, index) {
                          final product = myFavoriteProducts[index];
                          return ProductCard(
                            image: product.imagePath!,
                            title: product.name!,
                            description: product.description!,
                            price: product.price!,
                            rating: product.rating!,
                            isFavorites: product.isFavorite!,
                            productId: product.id!,
                            addFavoritesPress: () {},
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
