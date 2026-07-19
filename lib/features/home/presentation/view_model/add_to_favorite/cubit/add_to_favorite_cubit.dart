import 'package:bloc/bloc.dart';
import 'package:e_commerce_nti/core/helper/secure_storage_service.dart';
import 'package:e_commerce_nti/core/services/app_dependencies.dart';
import 'package:e_commerce_nti/core/services/refresh_token.dart';
import 'package:e_commerce_nti/features/home/data/repo/get_products.dart';
import 'package:meta/meta.dart';

part 'add_to_favorite_state.dart';

class AddToFavoriteCubit extends Cubit<AddToFavoriteState> {
  AddToFavoriteCubit() : super(AddToFavoriteInitial());
  Future addFavorites(String id) async {
    emit(AddToFavoriteLoading());

    final data = await RpoItems.addFavorite(id);

    data.fold(
      (l) async {
        if (l == "Token has expired.") {
          final data = await RefreshToken.refreshToken();

          data.fold(
            (error) {
              emit(AddToFavoriteError(errorMassage: error));
            },
            (r) async {
              await getIt.get<SecureStorageService>().saveAccessToken(r);
              await addFavorites(id);
            },
          );
        } else {
          emit(AddToFavoriteError(errorMassage: l));
        }
      },
      (r) {
        emit(AddToFavoriteSuccess(successMassage: r));
      },
    );
  }
}
