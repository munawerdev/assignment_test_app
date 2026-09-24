abstract class AppUrl {
  AppUrl._();

  static String? get _base => 'https://api.themoviedb.org';
  static String get _baseUrl => '$_base/3/movie';

  // watch
  static String get watch => '$_baseUrl/upcoming';

  // media_library
  static String get mediaLibrary => '$_baseUrl/media_library';
}
// static String endpoint(String userId) => '$_baseUrl/$path';
