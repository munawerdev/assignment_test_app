import 'package:dio/dio.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';

import '/domain/repositories/local/local_storage_base_api_service.dart';

class DioConfig {
  static Dio createDio({
    required LocalStorageBaseApiService localStorageRepository,
  }) {
    final dio = Dio();

    // Base configuration
    dio.options = BaseOptions(
      // baseUrl: AppConfig.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
      headers: {'Content-Type': 'application/json'},
    );

    // Add interceptors in order
    dio.interceptors.add(
      TalkerDioLogger(
        settings: const TalkerDioLoggerSettings(
          printRequestHeaders: true,
          printErrorHeaders: false,
          printErrorMessage: false,
        ),
      ),
    );
    return dio;
  }
}
