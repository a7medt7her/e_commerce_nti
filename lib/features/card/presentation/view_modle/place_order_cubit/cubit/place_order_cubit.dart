import 'package:bloc/bloc.dart';
import 'package:e_commerce_nti/core/helper/secure_storage_service.dart';
import 'package:e_commerce_nti/core/services/app_dependencies.dart';
import 'package:e_commerce_nti/core/services/refresh_token.dart';
import 'package:e_commerce_nti/features/card/data/repo/place_order_repo.dart';
import 'package:meta/meta.dart';

part 'place_order_state.dart';

class PlaceOrderCubit extends Cubit<PlaceOrderState> {
  PlaceOrderCubit() : super(PlaceOrderInitial());
  Future placeOrderResponse(Map<String, dynamic> body) async {
    emit(PlaceOrderILoading());
    final data = await PlaceOrderRepo.placeOrder(body);

    data.fold(
      (l) async {
        if (l == "Token has expired.") {
          final data = await RefreshToken.refreshToken();
          data.fold(
            (error) {
              emit(PlaceOrderError(errorMassage: error));
            },
            (r) async {
              await getIt.get<SecureStorageService>().saveAccessToken(r);
              await placeOrderResponse(body);
            },
          );
        } else {
          emit(PlaceOrderError(errorMassage: l));
        }
      },
      (r) {
        emit(PlaceOrderSuccess(successMassage: r));
      },
    );
  }
}
