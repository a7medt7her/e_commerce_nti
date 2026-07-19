import 'package:bloc/bloc.dart';
import 'package:e_commerce_nti/features/auth/data/repo/register_repo.dart';
import 'package:meta/meta.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  bool isVisibility = true;
  Future login(String email, String password, String name, String phone) async {
    emit(RegisterLoading());
    var data = await RegisterRepo.registerResponse(
      email,
      password,
      name,
      phone,
    );
    data.fold(
      (l) {
        emit(RegisterError(errorMassage: l));
      },
      (r) {
        emit(RegisterSuccess(successMassage: r));
      },
    );
  }

  void password() {
    isVisibility = !isVisibility;
    emit(RegisterIsVisible1());
  }
}
