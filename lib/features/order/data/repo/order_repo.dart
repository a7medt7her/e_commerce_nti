import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:e_commerce_nti/core/helper/dio_helper.dart';
import 'package:e_commerce_nti/core/helper/secure_storage_service.dart';
import 'package:e_commerce_nti/core/services/app_dependencies.dart';
import 'package:e_commerce_nti/features/order/data/model/orders.dart';
import 'package:e_commerce_nti/features/order/data/model/orders_model.dart';

class OrderRepo {
  static Future<Either<String, Orders>> orders() async {
    try {
      var token = await getIt.get<SecureStorageService>().getAccessToken();

      var response = await getIt.get<DioHelper>().dio.get(
        'orders',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      final model = OrdersModel.fromJson(response.data);

      return right(model.orders!);
    } catch (e) {
      return left(getIt.get<DioHelper>().errorMessage(e));
    }
  }

  static Future<Either<String, String>> cancelOrder(int id) async {
    try {
      final token = await getIt.get<SecureStorageService>().getAccessToken();

      final response = await getIt.get<DioHelper>().dio.post(
        'orders/cancel/$id',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      return right(response.data["message"]);
    } catch (e) {
      return left(getIt.get<DioHelper>().errorMessage(e));
    }
  }

  static Future<Either<String, String>> completeOrder(int id) async {
    try {
      final token = await getIt.get<SecureStorageService>().getAccessToken();

      final response = await getIt.get<DioHelper>().dio.post(
        'orders/complete/$id',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      return right(response.data["message"]);
    } catch (e) {
      return left(getIt.get<DioHelper>().errorMessage(e));
    }
  }
}
