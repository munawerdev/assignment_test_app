abstract class AppUrl {
  AppUrl._();

  static String? get _base => 'https://api.themoviedb.org';
  static String get _baseUrl => '$_base/3/movie';

  // watch
  static String get watch => '$_baseUrl/upcoming';

  // movie_detail
  static String movieDetail(String movieId) => '$_baseUrl/$movieId';
}
// static String endpoint(String userId) => '$_baseUrl/$path';
