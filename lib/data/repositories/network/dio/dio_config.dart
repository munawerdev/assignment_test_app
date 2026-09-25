import 'package:dio/dio.dart';

class DioConfig {
  static Dio createDio() {
    final dio = Dio();

    // Base configuration
    dio.options = BaseOptions(
      // baseUrl: AppConfig.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
      headers: {'Content-Type': 'application/json'},
    );

    return dio;
  }
}
