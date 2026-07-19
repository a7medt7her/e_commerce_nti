import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:e_commerce_nti/core/helper/dio_helper.dart';
import 'package:e_commerce_nti/core/helper/secure_storage_service.dart';
import 'package:e_commerce_nti/core/services/app_dependencies.dart';
import 'package:e_commerce_nti/features/home/data/models/category_model.dart';
import 'package:e_commerce_nti/features/home/data/models/products_model.dart';

class RpoItems {
  static Future<Either<String, List<Products>>> products() async {
    try {
      var token = await getIt.get<SecureStorageService>().getAccessToken();
      var response = await getIt.get<DioHelper>().dio.get(
        'products',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      final model = ProductsModel.fromJson(response.data);
      return right(model.products ?? []);
    } catch (e) {
      return left(getIt.get<DioHelper>().errorMessage(e));
    }
  }

  static Future<Either<String, List<Categories2>>> categories() async {
    try {
      var token = await getIt.get<SecureStorageService>().getAccessToken();

      var response = await getIt.get<DioHelper>().dio.get(
        'categories',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      final model = CategoryModel.fromJson(response.data);

      return right(model.categories ?? []);
    } catch (e, s) {
      print(s);
      print(e);
      return left(getIt.get<DioHelper>().errorMessage(e));
    }
  }

  static Future<Either<String, List<Products>>> search(String q) async {
    try {
      var token = await getIt.get<SecureStorageService>().getAccessToken();
      var response = await getIt.get<DioHelper>().dio.get(
        'products/search',
        queryParameters: {'q': q},
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      final model = ProductsModel.fromJson(response.data);
      return right(model.products ?? []);
    } catch (e) {
      return left(getIt.get<DioHelper>().errorMessage(e));
    }
  }

  static Future<Either<String, String>> addFavorite(String id) async {
    try {
      var token = await getIt.get<SecureStorageService>().getAccessToken();
      var response = await getIt.get<DioHelper>().dio.post(
        'add_to_favorite',
        data: FormData.fromMap({'product_id': id}),
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      final message = response.data['message'];
      return right(message);
    } catch (e) {
      return left(getIt.get<DioHelper>().errorMessage(e));
    }
  }
}
