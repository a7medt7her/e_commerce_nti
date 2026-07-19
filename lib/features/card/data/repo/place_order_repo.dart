import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:e_commerce_nti/core/helper/dio_helper.dart';
import 'package:e_commerce_nti/core/helper/secure_storage_service.dart';
import 'package:e_commerce_nti/core/services/app_dependencies.dart';

class PlaceOrderRepo {
  static Future<Either<String, String>> placeOrder(
    Map<String, dynamic> body,
  ) async {
    try {
      var token = await getIt.get<SecureStorageService>().getAccessToken();
      var response = await getIt.get<DioHelper>().dio.post(
        'place_order',
        data: body,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      final model = response.data['message'];
      return right(model);
    } catch (e) {
      return left(getIt.get<DioHelper>().errorMessage(e));
    }
  }
}
