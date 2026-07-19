import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:e_commerce_nti/core/helper/dio_helper.dart';
import 'package:e_commerce_nti/core/helper/secure_storage_service.dart';
import 'package:e_commerce_nti/core/services/app_dependencies.dart';

class LoginRepo {
  static Future<Either<String, String>> loginResponse(
    String email,
    String password,
  ) async {
    try {
      var data = await getIt.get<DioHelper>().dio.post(
        'login',
        data: FormData.fromMap({'email': email, 'password': password}),
      );
      getIt.get<SecureStorageService>().saveAccessToken(
        data.data['access_token'],
      );
      getIt.get<SecureStorageService>().saveRefreshToken(
        data.data['refresh_token'],
      );
      return right('welcome');
    } catch (e) {
      return left(getIt.get<DioHelper>().errorMessage(e));
    }
  }
}
