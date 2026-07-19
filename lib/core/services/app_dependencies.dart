import 'package:e_commerce_nti/core/helper/dio_helper.dart';
import 'package:e_commerce_nti/core/helper/secure_storage_service.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;
void setupServices() {
  getIt.registerLazySingleton<DioHelper>(() => DioHelper());
  getIt.registerLazySingleton<SecureStorageService>(
    () => SecureStorageService(),
  );
}
