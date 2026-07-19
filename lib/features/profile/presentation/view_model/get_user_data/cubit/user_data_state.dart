part of 'user_data_cubit.dart';

@immutable
sealed class UserDataState {}

final class UserDataInitial extends UserDataState {}

final class UserDataLoading extends UserDataState {}

final class UserDataSuccess extends UserDataState {
  final UserModel user;

  UserDataSuccess(this.user);
}

final class UserDataError extends UserDataState {
  final String errorMessage;

  UserDataError(this.errorMessage);
}
