import 'package:bloc/bloc.dart';
import 'package:e_commerce_nti/core/helper/secure_storage_service.dart';
import 'package:e_commerce_nti/core/services/app_dependencies.dart';
import 'package:e_commerce_nti/core/services/refresh_token.dart';
import 'package:e_commerce_nti/features/order/data/model/orders.dart';
import 'package:e_commerce_nti/features/order/data/repo/order_repo.dart';
import 'package:meta/meta.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(OrdersInitial());
  Future<void> getOrders() async {
    emit(OrdersLoading());

    final data = await OrderRepo.orders();

    data.fold(
      (l) async {
        if (l == "Token has expired.") {
          final refresh = await RefreshToken.refreshToken();

          refresh.fold(
            (error) {
              emit(OrdersError(error));
            },
            (token) async {
              await getIt.get<SecureStorageService>().saveAccessToken(token);

              await getOrders();
            },
          );
        } else {
          emit(OrdersError(l));
        }
      },
      (r) {
        emit(OrdersSuccess(r));
      },
    );
  }
}
