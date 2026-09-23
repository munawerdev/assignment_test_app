import 'package:fpdart/fpdart.dart';

import '/domain/failures/local/get_local_storage_failure.dart';
import '/domain/failures/local/remove_local_storage_failure.dart';
import '/domain/failures/local/set_local_storage_failure.dart';

abstract class LocalStorageBaseApiService {
  Future<Either<SetLocalStorageFailure, bool>> setBool({
    required String key,
    required bool value,
  });

  Future<Either<GetLocalStorageFailure, bool>> getBool({required String key});

  Future<Either<RemoveLocalStorageFailure, bool>> deleteAll();

  Future<Either<GetLocalStorageFailure, bool>> containsKey({
    required String key,
  });
}
