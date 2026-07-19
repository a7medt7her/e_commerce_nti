import 'package:bloc/bloc.dart';
import 'package:e_commerce_nti/features/auth/data/repo/login_repo.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  bool isVisibility = true;
  Future login(String email, String password) async {
    emit(LoginLoading());
    var data = await LoginRepo.loginResponse(email, password);
    data.fold(
      (l) {
        emit(LoginError(errorMassage: l));
      },
      (r) {
        emit(LoginSuccess(successMassage: r));
      },
    );
  }

  void password() {
    isVisibility = !isVisibility;
    emit(LoginIsVisible1());
  }
}
