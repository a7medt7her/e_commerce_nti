import 'package:bloc/bloc.dart';
import 'package:e_commerce_nti/core/helper/secure_storage_service.dart';
import 'package:e_commerce_nti/core/services/app_dependencies.dart';
import 'package:e_commerce_nti/core/services/refresh_token.dart';
import 'package:e_commerce_nti/features/order/data/repo/order_repo.dart';
import 'package:meta/meta.dart';

part 'order_action_state.dart';

class OrderActionCubit extends Cubit<OrderActionState> {
  OrderActionCubit() : super(OrderActionInitial());

  Future<void> cancelOrder(int id) async {
    emit(OrderActionLoading());

    final data = await OrderRepo.cancelOrder(id);

    data.fold(
      (l) async {
        if (l == "Token has expired.") {
          final refresh = await RefreshToken.refreshToken();

          refresh.fold(
            (error) {
              emit(OrderActionError(errorMessage: error));
            },
            (token) async {
              await getIt.get<SecureStorageService>().saveAccessToken(token);
              await cancelOrder(id);
            },
          );
        } else {
          emit(OrderActionError(errorMessage: l));
        }
      },
      (r) {
        emit(OrderActionSuccess(successMessage: r));
      },
    );
  }

  Future<void> completeOrder(int id) async {
    emit(OrderActionLoading());

    final data = await OrderRepo.completeOrder(id);

    data.fold(
      (l) async {
        if (l == "Token has expired.") {
          final refresh = await RefreshToken.refreshToken();

          refresh.fold(
            (error) {
              emit(OrderActionError(errorMessage: error));
            },
            (token) async {
              await getIt.get<SecureStorageService>().saveAccessToken(token);
              await completeOrder(id);
            },
          );
        } else {
          emit(OrderActionError(errorMessage: l));
        }
      },
      (r) {
        emit(OrderActionSuccess(successMessage: r));
      },
    );
  }
}
