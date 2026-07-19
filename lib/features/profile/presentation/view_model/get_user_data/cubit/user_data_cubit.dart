import 'package:bloc/bloc.dart';
import 'package:e_commerce_nti/core/helper/secure_storage_service.dart';
import 'package:e_commerce_nti/core/services/app_dependencies.dart';
import 'package:e_commerce_nti/core/services/refresh_token.dart';
import 'package:e_commerce_nti/features/profile/data/model/user_data.dart';
import 'package:e_commerce_nti/features/profile/data/repo/update_profile_repo.dart';
import 'package:meta/meta.dart';

part 'user_data_state.dart';

class UserDataCubit extends Cubit<UserDataState> {
  UserDataCubit() : super(UserDataInitial());

  Future<void> getUserData() async {
    emit(UserDataLoading());

    final data = await ProfileRepo.getUser();

    data.fold(
      (error) async {
        if (error == "Token has expired.") {
          final refresh = await RefreshToken.refreshToken();

          refresh.fold(
            (refreshError) {
              emit(UserDataError(refreshError));
            },
            (token) async {
              await getIt.get<SecureStorageService>().saveAccessToken(token);
              await getUserData();
            },
          );
        } else {
          emit(UserDataError(error));
        }
      },
      (user) {
        emit(UserDataSuccess(user));
      },
    );
  }
}
