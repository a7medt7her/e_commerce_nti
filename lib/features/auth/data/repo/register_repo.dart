import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:e_commerce_nti/core/helper/dio_helper.dart';
import 'package:e_commerce_nti/core/services/app_dependencies.dart';

class RegisterRepo {
  static Future<Either<String, String>> registerResponse(
    String email,
    String password,
    String name,
    String phone,
  ) async {
    try {
      var data = await getIt.get<DioHelper>().dio.post(
        'register',
        data: FormData.fromMap({
          'email': email,
          'password': password,
          'name': name,
          'phone': phone,
        }),
      );
      final String message = data.data['message'];
      return right(message);
    } catch (e) {
      return left(getIt.get<DioHelper>().errorMessage(e));
    }
  }
}
