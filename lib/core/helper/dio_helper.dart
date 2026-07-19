import 'package:dio/dio.dart';

class DioHelper {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://nti-ecommerce-api-production-0f69.up.railway.app/api/',
    ),
  );
  String errorMessage(Object e) {
    if (e is DioException) {
      print("Status: ${e.response?.statusCode}");
      print("Data: ${e.response?.data}");
      return e.response?.data["message"] ?? "Unknown error";
    } else {
      return 'something wrong';
    }
  }
}
