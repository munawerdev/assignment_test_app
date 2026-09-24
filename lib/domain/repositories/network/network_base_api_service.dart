import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

import '/domain/failures/network/network_failure.dart';

abstract class NetworkBaseApiService {
  Future<Either<NetworkFailure, T>> get<T>({
    required String url,
    Map<String, dynamic>? queryParams,
    Map<String, String>? headers,
    CancelToken? cancelToken,
  });
}
