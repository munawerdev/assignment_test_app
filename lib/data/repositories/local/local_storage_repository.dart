import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fpdart/fpdart.dart';

import '/domain/failures/local/get_local_storage_failure.dart';
import '/domain/failures/local/remove_local_storage_failure.dart';
import '/domain/failures/local/set_local_storage_failure.dart';
import '/domain/repositories/local/local_storage_base_api_service.dart';

class LocalStorageRepository implements LocalStorageBaseApiService {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  @override
  Future<Either<GetLocalStorageFailure, bool>> getBool({
    required String key,
  }) async {
    try {
      final String? value = await _storage.read(key: key);
      if (value == null) {
        return right(false);
      }
      return right(value.toLowerCase() == 'true');
    } catch (ex) {
      return left(GetLocalStorageFailure(error: ex.toString()));
    }
  }

  @override
  Future<Either<SetLocalStorageFailure, bool>> setBool({
    required String key,
    required bool value,
  }) async {
    try {
      await _storage.write(key: key, value: value.toString());
      return right(true);
    } catch (ex) {
      return left(SetLocalStorageFailure(error: ex.toString()));
    }
  }

  @override
  Future<Either<RemoveLocalStorageFailure, bool>> deleteAll() async {
    try {
      await _storage.deleteAll();
      return right(true);
    } catch (ex) {
      return left(RemoveLocalStorageFailure(error: ex.toString()));
    }
  }

  @override
  Future<Either<GetLocalStorageFailure, bool>> containsKey({
    required String key,
  }) async {
    try {
      final bool contains = await _storage.containsKey(key: key);
      return right(contains);
    } catch (ex) {
      return left(GetLocalStorageFailure(error: ex.toString()));
    }
  }
}
