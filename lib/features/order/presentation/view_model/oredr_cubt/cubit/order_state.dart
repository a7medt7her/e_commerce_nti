part of 'order_cubit.dart';

@immutable
sealed class OrderState {}

final class OrdersInitial extends OrderState {}

final class OrdersLoading extends OrderState {}

final class OrdersSuccess extends OrderState {
  final Orders orders;

  OrdersSuccess(this.orders);
}

final class OrdersError extends OrderState {
  final String error;

  OrdersError(this.error);
}
