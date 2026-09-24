import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

import '/data/repositories/network/errors/api_error_handler.dart';
import '/domain/failures/network/network_failure.dart';
import '/domain/repositories/network/network_base_api_service.dart';
import 'dio_config.dart';

class DioNetworkRepository implements NetworkBaseApiService {
  final ApiErrorHandler _apiErrorHandler;
  late final Dio _dio;

  DioNetworkRepository(this._apiErrorHandler) {
    _dio = DioConfig.createDio();
  }

  @override
  Future<Either<NetworkFailure, T>> get<T>({
    required String url,
    Map<String, dynamic>? queryParams,
    Map<String, String>? headers,
    CancelToken? cancelToken,
  }) async {
    return _executeRequest<T>(
      () => _dio.get(
        url,
        queryParameters: queryParams,
        cancelToken: cancelToken,
        options: Options(headers: headers),
      ),
    );
  }

  /// Common method to execute requests and handle errors
  Future<Either<NetworkFailure, T>> _executeRequest<T>(
    Future<Response> Function() request,
  ) async {
    try {
      final response = await request();
      return right(response.data);
    } on DioException catch (e) {
      return left(_apiErrorHandler.handleDioError(e));
    } catch (e) {
      return left(NetworkFailure(error: 'Unexpected error: $e'));
    }
  }
}
