part of 'register_cubit.dart';

@immutable
sealed class RegisterState {}

final class RegisterInitial extends RegisterState {}

final class RegisterLoading extends RegisterState {}

final class RegisterSuccess extends RegisterState {
  final String successMassage;
  RegisterSuccess({required this.successMassage});
}

final class RegisterError extends RegisterState {
  final String errorMassage;
  RegisterError({required this.errorMassage});
}

final class RegisterIsVisible1 extends RegisterState {}
