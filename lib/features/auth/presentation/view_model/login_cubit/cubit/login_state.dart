part of 'login_cubit.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginSuccess extends LoginState {
  final String successMassage;
  LoginSuccess({required this.successMassage});
}

final class LoginError extends LoginState {
  final String errorMassage;
  LoginError({required this.errorMassage});
}

final class LoginIsVisible1 extends LoginState {}
