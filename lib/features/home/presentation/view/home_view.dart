import 'package:e_commerce_nti/core/unitles/app_color.dart';
import 'package:e_commerce_nti/core/unitles/app_text_style.dart';
import 'package:e_commerce_nti/core/unitles/asstes.dart';
import 'package:e_commerce_nti/core/widgets/custom_progress_indicator.dart';
import 'package:e_commerce_nti/features/home/presentation/view/widgets/categories.dart';
import 'package:e_commerce_nti/features/home/presentation/view/widgets/home_indicator.dart';
import 'package:e_commerce_nti/features/home/presentation/view/widgets/logo.dart';
import 'package:e_commerce_nti/features/home/presentation/view/widgets/product_card.dart';
import 'package:e_commerce_nti/features/home/presentation/view/widgets/search_text_field.dart';
import 'package:e_commerce_nti/features/my%20_favorites/presentation/view/my_favorit_viiew.dart';
import 'package:e_commerce_nti/features/search/presentation/view/search_view.dart';
import 'package:e_commerce_nti/features/home/presentation/view_model/add_to_favorite/cubit/add_to_favorite_cubit.dart';
import 'package:e_commerce_nti/features/home/presentation/view_model/get_categories/cubit/categories_cubit.dart';
import 'package:e_commerce_nti/features/home/presentation/view_model/get_proudct/cubit/product_cubit.dart';
import 'package:e_commerce_nti/features/home/presentation/view_model/pages_cubit/cubit/pages_cubit.dart';
import 'package:e_commerce_nti/features/search/presentation/view_modle/search_cubit/cubit/search_cubit.dart';
import 'package:e_commerce_nti/features/home/presentation/view_model/selected_category/cubit/selectedcategory_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});
  final List<String> sliders = [
    AssetsImages.slider,
    AssetsImages.slider,
    AssetsImages.slider,
  ];
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ProductCubit()..productResponse()),
        BlocProvider(create: (_) => CategoriesCubit()..categories()),
        BlocProvider(create: (_) => PagesCubit()),
        BlocProvider(create: (_) => SelectedCategoryCubit()),
        BlocProvider(create: (_) => AddToFavoriteCubit()),
        BlocProvider(create: (_) => SearchCubit()),
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
                  Form(
                    key: formKey,
                    child: SearchTextField(
                      onFieldSubmitted: (p0) {
                        if (formKey.currentState!.validate()) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SearchView(q: p0),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 17.h),
                  Text(
                    'All Featured',
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

                                return BlocBuilder<SelectedCategoryCubit, int?>(
                                  builder: (context, state) {
                                    return Categories(
                                      onTap: () {
                                        context
                                            .read<ProductCubit>()
                                            .changeProduct(
                                              categories.products!,
                                            );
                                        context
                                            .read<SelectedCategoryCubit>()
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
                  BlocBuilder<PagesCubit, int>(
                    builder: (context, state) {
                      return Column(
                        children: [
                          SizedBox(
                            height: 189.h,
                            child: PageView.builder(
                              itemCount: sliders.length,
                              onPageChanged: (value) {
                                context.read<PagesCubit>().pageNavigator(value);
                              },
                              itemBuilder: ((context, index) {
                                return Container(
                                  width: 343.w,
                                  height: 189.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.r),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage(sliders[index]),
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ),
                          SizedBox(height: 12.h),
                          HomeIndicator(
                            currentIndex: state,
                            length: sliders.length,
                          ),
                        ],
                      );
                    },
                  ),
                  SizedBox(height: 32.h),
                  Text(
                    'Recommended',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: AppTextStyle.semiBold,
                      color: AppColors.black,
                    ),
                  ),
                  SizedBox(height: 15.h),
                  BlocBuilder<ProductCubit, ProductState>(
                    builder: (context, state) {
                      if (state is ProductLoading) {
                        return CustomProgressIndicator();
                      }
                      if (state is ProductSuccess) {
                        myFavoriteProducts = state.products
                            .where((product) => product.isFavorite == true)
                            .toList();
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
