class WatchModel {
  WatchModel({
    this.dates,
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  final Dates? dates;
  final int? page;
  final List<Result>? results;
  final int? totalPages;
  final int? totalResults;

  WatchModel copyWith({
    Dates? dates,
    int? page,
    List<Result>? results,
    int? totalPages,
    int? totalResults,
  }) => WatchModel(
    dates: dates ?? this.dates,
    page: page ?? this.page,
    results: results ?? this.results,
    totalPages: totalPages ?? this.totalPages,
    totalResults: totalResults ?? this.totalResults,
  );

  factory WatchModel.fromJson(Map<String, dynamic> json) => WatchModel(
    dates: json['dates'] is Map<String, dynamic>
        ? Dates.fromJson(json['dates'] as Map<String, dynamic>)
        : null,
    page: (json['page'] as num?)?.toInt(),
    results: (json['results'] as List<dynamic>?)
        ?.whereType<Map<String, dynamic>>()
        .map(Result.fromJson)
        .toList(),
    totalPages: (json['total_pages'] as num?)?.toInt(),
    totalResults: (json['total_results'] as num?)?.toInt(),
  );
}

class Dates {
  Dates({this.maximum, this.minimum});

  final DateTime? maximum;
  final DateTime? minimum;

  Dates copyWith({DateTime? maximum, DateTime? minimum}) =>
      Dates(maximum: maximum ?? this.maximum, minimum: minimum ?? this.minimum);

  factory Dates.fromJson(Map<String, dynamic> json) => Dates(
    maximum: DateTime.tryParse(json['maximum'] as String? ?? ''),
    minimum: DateTime.tryParse(json['minimum'] as String? ?? ''),
  );
}

class Result {
  Result({
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.id,
    this.title,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.softcore,
    this.video,
    this.voteAverage,
    this.voteCount,
  });

  final bool? adult;
  final String? backdropPath;
  final List<int>? genreIds;
  final int? id;
  final String? title;
  final String? originalLanguage;
  final String? originalTitle;
  final String? overview;
  final double? popularity;
  final String? posterPath;
  final DateTime? releaseDate;
  final bool? softcore;
  final bool? video;
  final double? voteAverage;
  final int? voteCount;

  Result copyWith({
    bool? adult,
    String? backdropPath,
    List<int>? genreIds,
    int? id,
    String? title,
    String? originalLanguage,
    String? originalTitle,
    String? overview,
    double? popularity,
    String? posterPath,
    DateTime? releaseDate,
    bool? softcore,
    bool? video,
    double? voteAverage,
    int? voteCount,
  }) => Result(
    adult: adult ?? this.adult,
    backdropPath: backdropPath ?? this.backdropPath,
    genreIds: genreIds ?? this.genreIds,
    id: id ?? this.id,
    title: title ?? this.title,
    originalLanguage: originalLanguage ?? this.originalLanguage,
    originalTitle: originalTitle ?? this.originalTitle,
    overview: overview ?? this.overview,
    popularity: popularity ?? this.popularity,
    posterPath: posterPath ?? this.posterPath,
    releaseDate: releaseDate ?? this.releaseDate,
    softcore: softcore ?? this.softcore,
    video: video ?? this.video,
    voteAverage: voteAverage ?? this.voteAverage,
    voteCount: voteCount ?? this.voteCount,
  );

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    adult: json['adult'] as bool?,
    backdropPath: json['backdrop_path'] as String?,
    genreIds: (json['genre_ids'] as List<dynamic>?)
        ?.whereType<num>()
        .map((id) => id.toInt())
        .toList(),
    id: (json['id'] as num?)?.toInt(),
    title: json['title'] as String?,
    originalLanguage: json['original_language'] as String?,
    originalTitle: json['original_title'] as String?,
    overview: json['overview'] as String?,
    popularity: (json['popularity'] as num?)?.toDouble(),
    posterPath: json['poster_path'] as String?,
    releaseDate: DateTime.tryParse(json['release_date'] as String? ?? ''),
    softcore: json['softcore'] as bool?,
    video: json['video'] as bool?,
    voteAverage: (json['vote_average'] as num?)?.toDouble(),
    voteCount: (json['vote_count'] as num?)?.toInt(),
  );
}
