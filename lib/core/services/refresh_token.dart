import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:e_commerce_nti/core/helper/dio_helper.dart';
import 'package:e_commerce_nti/core/helper/secure_storage_service.dart';
import 'package:e_commerce_nti/core/services/app_dependencies.dart';

class RefreshToken {
  static Future<Either<String, String>> refreshToken() async {
    try {
      final refreshToken = await getIt
          .get<SecureStorageService>()
          .getRefreshToken();
      var data = await getIt.get<DioHelper>().dio.post(
        'refresh_token',
        options: Options(headers: {'Authorization': 'Bearer $refreshToken'}),
      );
      return right(data.data['access_token']);
    } catch (e) {
      return left(e.toString());
    }
  }
}
