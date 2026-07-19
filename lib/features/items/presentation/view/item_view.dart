import 'package:e_commerce_nti/core/unitles/app_color.dart';
import 'package:e_commerce_nti/core/unitles/app_text_style.dart';
import 'package:e_commerce_nti/core/widgets/custom_progress_indicator.dart';
import 'package:e_commerce_nti/features/home/presentation/view/widgets/categories.dart';
import 'package:e_commerce_nti/features/home/presentation/view/widgets/logo.dart';
import 'package:e_commerce_nti/features/home/presentation/view/widgets/product_card.dart';
import 'package:e_commerce_nti/features/home/presentation/view_model/add_to_favorite/cubit/add_to_favorite_cubit.dart';
import 'package:e_commerce_nti/features/home/presentation/view_model/get_categories/cubit/categories_cubit.dart';
import 'package:e_commerce_nti/features/home/presentation/view_model/get_proudct/cubit/product_cubit.dart';
import 'package:e_commerce_nti/features/items/presentation/view_model/selected_item/cubit/selected_item_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ItemView extends StatelessWidget {
  const ItemView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ProductCubit()..productResponse()),
        BlocProvider(create: (_) => CategoriesCubit()..categories()),
        BlocProvider(create: (_) => SelectedItemCubit()),
        BlocProvider(create: (_) => AddToFavoriteCubit()),
      ],
      child: Scaffold(
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: REdgeInsets.symmetric(horizontal: 16.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 24.h),
                  Logo(),
                  SizedBox(height: 12.h),

                  SizedBox(height: 17.h),
                  Text(
                    'Products',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: AppTextStyle.semiBold,
                      color: AppColors.black,
                    ),
                  ),
                  SizedBox(height: 25.h),
                  SizedBox(
                    child: BlocBuilder<CategoriesCubit, CategoriesState>(
                      builder: (context, state) {
                        if (state is CategoriesLoading) {
                          return CustomProgressIndicator();
                        }
                        if (state is CategoriesSuccess) {
                          return SizedBox(
                            height: 100.h,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                var categories = state.categories[index];
                                return BlocBuilder<SelectedItemCubit, int?>(
                                  builder: (context, state) {
                                    return Categories(
                                      onTap: () {
                                        context
                                            .read<ProductCubit>()
                                            .changeProduct(
                                              categories.products!,
                                            );
                                        context
                                            .read<SelectedItemCubit>()
                                            .selectCategory(categories.id!);
                                      },
                                      title: categories.title!,
                                      imagePath: categories.imagePath!,
                                      id: categories.id!,
                                      selectedId: state ?? 0,
                                    );
                                  },
                                );
                              },
                              separatorBuilder: (context, index) =>
                                  SizedBox(width: 16.w),
                              itemCount: state.categories.length,
                            ),
                          );
                        }
                        return SizedBox();
                      },
                    ),
                  ),
                  SizedBox(height: 15.h),
                  BlocBuilder<ProductCubit, ProductState>(
                    builder: (context, state) {
                      if (state is ProductLoading) {
                        return CustomProgressIndicator();
                      }
                      if (state is ProductSuccess) {
                        return GridView.builder(
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
                                context.read<ProductCubit>().productResponse();
                              },
                            );
                          },
                        );
                      }
                      return SizedBox();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
