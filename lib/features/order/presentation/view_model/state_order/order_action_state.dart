part of 'order_action_cubit.dart';

@immutable
sealed class OrderActionState {}

final class OrderActionInitial extends OrderActionState {}

final class OrderActionLoading extends OrderActionState {}

final class OrderActionSuccess extends OrderActionState {
  final String successMessage;

  OrderActionSuccess({required this.successMessage});
}

final class OrderActionError extends OrderActionState {
  final String errorMessage;

  OrderActionError({required this.errorMessage});
}
