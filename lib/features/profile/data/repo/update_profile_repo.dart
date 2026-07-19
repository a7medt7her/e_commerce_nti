import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:e_commerce_nti/core/helper/dio_helper.dart';
import 'package:e_commerce_nti/core/helper/secure_storage_service.dart';
import 'package:e_commerce_nti/core/services/app_dependencies.dart';
import 'package:e_commerce_nti/features/profile/data/model/user_data.dart';

class ProfileRepo {
  static Future<Either<String, String>> updateProfile({
    required String name,
    required String phone,
  }) async {
    try {
      final token = await getIt.get<SecureStorageService>().getAccessToken();

      final formData = FormData.fromMap({"name": name, "phone": phone});

      var response = await getIt.get<DioHelper>().dio.put(
        "update_profile",
        data: formData,
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );

      return right(response.data["message"]);
    } catch (e) {
      return left(getIt.get<DioHelper>().errorMessage(e));
    }
  }

  static Future<Either<String, UserModel>> getUser() async {
    try {
      final token = await getIt.get<SecureStorageService>().getAccessToken();

      var response = await getIt.get<DioHelper>().dio.get(
        "get_user_data",

        options: Options(headers: {"Authorization": "Bearer $token"}),
      );
      var user = UserModel.fromJson(response.data['user']);
      return right(user);
    } catch (e) {
      return left(getIt.get<DioHelper>().errorMessage(e));
    }
  }
}
