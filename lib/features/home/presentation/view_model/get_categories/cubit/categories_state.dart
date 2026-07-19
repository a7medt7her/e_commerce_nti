part of 'categories_cubit.dart';

@immutable
sealed class CategoriesState {}

final class CategoriesInitial extends CategoriesState {}

final class CategoriesLoading extends CategoriesState {}

final class CategoriesSuccess extends CategoriesState {
  final List<Categories2> categories;
  CategoriesSuccess({required this.categories});
}

final class CategoriesError extends CategoriesState {
  final String errorMassage;
  CategoriesError({required this.errorMassage});
}
