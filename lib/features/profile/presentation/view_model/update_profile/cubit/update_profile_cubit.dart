import 'package:bloc/bloc.dart';
import 'package:e_commerce_nti/core/helper/secure_storage_service.dart';
import 'package:e_commerce_nti/core/services/app_dependencies.dart';
import 'package:e_commerce_nti/core/services/refresh_token.dart';
import 'package:e_commerce_nti/features/profile/data/repo/update_profile_repo.dart';
import 'package:meta/meta.dart';

part 'update_profile_state.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileState> {
  UpdateProfileCubit() : super(UpdateProfileInitial());

  Future<void> updateProfile({
    required String name,
    required String phone,
  }) async {
    emit(UpdateProfileLoading());

    final data = await ProfileRepo.updateProfile(name: name, phone: phone);

    data.fold(
      (error) async {
        if (error == "Token has expired.") {
          final refresh = await RefreshToken.refreshToken();

          refresh.fold(
            (refreshError) {
              emit(UpdateProfileError(errorMessage: refreshError));
            },
            (token) async {
              await getIt.get<SecureStorageService>().saveAccessToken(token);

              await updateProfile(name: name, phone: phone);
            },
          );
        } else {
          emit(UpdateProfileError(errorMessage: error));
        }
      },
      (message) {
        emit(UpdateProfileSuccess(successMessage: message));
      },
    );
  }
}
