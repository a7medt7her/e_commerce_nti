import 'package:bloc/bloc.dart';
import 'package:e_commerce_nti/core/helper/secure_storage_service.dart';
import 'package:e_commerce_nti/core/services/app_dependencies.dart';
import 'package:e_commerce_nti/core/services/refresh_token.dart';
import 'package:e_commerce_nti/features/home/data/models/products_model.dart';
import 'package:e_commerce_nti/features/home/data/repo/get_products.dart';
import 'package:meta/meta.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());
  Future searchItems(String q) async {
    emit(SearchLoading());
    final data = await RpoItems.search(q);
    data.fold(
      (l) async {
        if (l == "Token has expired.") {
          final data = await RefreshToken.refreshToken();
          data.fold(
            (error) {
              emit(SearchError(errorMassage: error));
            },
            (r) {
              getIt.get<SecureStorageService>().saveAccessToken(r);
            },
          );
        } else {
          emit(SearchError(errorMassage: l));
        }
      },
      (r) {
        emit(SearchSuccess(products: r));
      },
    );
  }
}
