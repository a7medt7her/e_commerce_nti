import 'package:e_commerce_nti/core/helper/svg_helper.dart';
import 'package:e_commerce_nti/core/unitles/app_color.dart';
import 'package:e_commerce_nti/core/unitles/app_text_style.dart';
import 'package:e_commerce_nti/core/unitles/asstes.dart';
import 'package:e_commerce_nti/core/widgets/custom_progress_indicator.dart';
import 'package:e_commerce_nti/features/home/presentation/view/widgets/product_card.dart';
import 'package:e_commerce_nti/features/home/presentation/view/widgets/search_text_field.dart';
import 'package:e_commerce_nti/features/home/presentation/view_model/add_to_favorite/cubit/add_to_favorite_cubit.dart';
import 'package:e_commerce_nti/features/search/presentation/view_modle/search_cubit/cubit/search_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key, required this.q});
  final String q;
  @override
  Widget build(BuildContext context) {
    int items = 0;
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AddToFavoriteCubit()),
        BlocProvider(create: (_) => SearchCubit()..searchItems(q)),
      ],
      child: SafeArea(
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
          body: SingleChildScrollView(
            child: Padding(
              padding: REdgeInsets.symmetric(horizontal: 17),
              child: BlocBuilder<SearchCubit, SearchState>(
                builder: (context, state) {
                  if (state is SearchLoading) {
                    return CustomProgressIndicator();
                  }
                  if (state is SearchSuccess) {
                    items = state.products.length;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 34.h),
                        SearchTextField(
                          onFieldSubmitted: (p0) {
                            context.read<SearchCubit>().searchItems(p0);
                          },
                        ),
                        SizedBox(height: 17.h),
                        Text(
                          '$items items',
                          style: TextStyle(
                            color: AppColors.black,
                            fontSize: 18.sp,
                            fontWeight: AppTextStyle.semiBold,
                          ),
                        ),
                        SizedBox(height: 17.h),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 17.w,
                                mainAxisSpacing: 17.h,
                                childAspectRatio: 0.52,
                              ),
                          itemCount: state.products.length,
                          itemBuilder: (context, index) {
                            final product = state.products[index];
                            return ProductCard(
                              image: product.imagePath!,
                              title: product.name!,
                              description: product.description!,
                              price: product.price!,
                              rating: product.rating!,
                              isFavorites: product.isFavorite!,
                              productId: product.id!,
                              addFavoritesPress: () {
                                context.read<AddToFavoriteCubit>().addFavorites(
                                  product.id.toString(),
                                );
                              },
                            );
                          },
                        ),
                      ],
                    );
                  }
                  return SizedBox();
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
