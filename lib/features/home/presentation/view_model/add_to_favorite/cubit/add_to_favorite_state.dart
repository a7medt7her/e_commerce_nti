part of 'add_to_favorite_cubit.dart';

@immutable
sealed class AddToFavoriteState {}

final class AddToFavoriteInitial extends AddToFavoriteState {}

final class AddToFavoriteLoading extends AddToFavoriteState {}

final class AddToFavoriteSuccess extends AddToFavoriteState {
  final String successMassage;
  AddToFavoriteSuccess({required this.successMassage});
}

final class AddToFavoriteError extends AddToFavoriteState {
  final String errorMassage;
  AddToFavoriteError({required this.errorMassage});
}
