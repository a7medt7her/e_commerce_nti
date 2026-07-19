import 'package:bloc/bloc.dart';
import 'package:e_commerce_nti/core/helper/secure_storage_service.dart';
import 'package:e_commerce_nti/core/services/app_dependencies.dart';
import 'package:e_commerce_nti/core/services/refresh_token.dart';
import 'package:e_commerce_nti/features/home/data/models/category_model.dart';
import 'package:e_commerce_nti/features/home/data/repo/get_products.dart';
import 'package:meta/meta.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit() : super(CategoriesInitial());
  Future categories() async {
    emit(CategoriesLoading());

    final data = await RpoItems.categories();

    data.fold(
      (l) async {
        if (l == "Token has expired.") {
          final data = await RefreshToken.refreshToken();

          data.fold(
            (error) {
              print(error);
              emit(CategoriesError(errorMassage: error));
            },
            (r) async {
              await getIt.get<SecureStorageService>().saveAccessToken(r);
              await categories();
            },
          );
        } else {
          emit(CategoriesError(errorMassage: l));
        }
      },
      (r) {
        emit(CategoriesSuccess(categories: r));
      },
    );
  }
}
