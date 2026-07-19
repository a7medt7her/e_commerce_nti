import 'package:bloc/bloc.dart';
import 'package:e_commerce_nti/core/helper/secure_storage_service.dart';
import 'package:e_commerce_nti/core/services/app_dependencies.dart';
import 'package:e_commerce_nti/core/services/refresh_token.dart';
import 'package:e_commerce_nti/features/home/data/models/products_model.dart';
import 'package:e_commerce_nti/features/home/data/repo/get_products.dart';
import 'package:meta/meta.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitial());
  Future productResponse() async {
    emit(ProductLoading());
    final data = await RpoItems.products();

    data.fold(
      (l) async {
        if (l == "Token has expired.") {
          final data = await RefreshToken.refreshToken();
          data.fold(
            (error) {
              emit(ProductError(errorMassage: error));
            },
            (r) async {
              await getIt.get<SecureStorageService>().saveAccessToken(r);
              await productResponse();
            },
          );
        } else {
          emit(ProductError(errorMassage: l));
        }
      },
      (r) {
        emit(ProductSuccess(products: r));
      },
    );
  }

  void changeProduct(List<Products> products) {
    emit(ProductSuccess(products: products));
  }
}
