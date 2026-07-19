part of 'place_order_cubit.dart';

@immutable
sealed class PlaceOrderState {}

final class PlaceOrderInitial extends PlaceOrderState {}

final class PlaceOrderILoading extends PlaceOrderState {}

final class PlaceOrderSuccess extends PlaceOrderState {
  final String successMassage;
  PlaceOrderSuccess({required this.successMassage});
}

final class PlaceOrderError extends PlaceOrderState {
  final String errorMassage;
  PlaceOrderError({required this.errorMassage});
}
