import '/data/datasources/user/user_data_sources.dart';
import '/domain/repositories/local/local_storage_base_api_service.dart';

class UserUseCases {
  final UserDataSources _userDataSources;
  final LocalStorageBaseApiService _localStorageRepository;
  UserUseCases(this._userDataSources, this._localStorageRepository);

  // Future<Either<NetworkFailure, UserInfoStoreModel>> execute({
  //   required Map<String, dynamic> userData,
  // }) async => await _localStorageRepository
  //     .setUserData(userInfoStoreModel: UserInfoStoreModel.fromJson(userData))
  //     .then(
  //       (value) => value.fold((l) => left(NetworkFailure(error: l.error)), (
  //         tokenRight,
  //       ) {
  //         _userDataSources.setUserDataSources(
  //           userInfoStoreModel: UserInfoStoreModel.fromJson(userData),
  //         );
  //         return right(UserInfoStoreModel.fromJson(userData));
  //       }),
  //     );
}
