class MovieDetailModel {
  const MovieDetailModel({
    this.adult,
    this.backdropPath,
    this.belongsToCollection,
    this.budget,
    this.genres = const [],
    this.homepage,
    this.id,
    this.imdbId,
    this.originCountry = const [],
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.productionCompanies = const [],
    this.productionCountries = const [],
    this.releaseDate,
    this.revenue,
    this.runtime,
    this.softcore,
    this.spokenLanguages = const [],
    this.status,
    this.tagline,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
  });

  final bool? adult;
  final String? backdropPath;
  final MovieCollection? belongsToCollection;
  final int? budget;
  final List<MovieGenre> genres;
  final String? homepage;
  final int? id;
  final String? imdbId;
  final List<String> originCountry;
  final String? originalLanguage;
  final String? originalTitle;
  final String? overview;
  final double? popularity;
  final String? posterPath;
  final List<ProductionCompany> productionCompanies;
  final List<ProductionCountry> productionCountries;
  final DateTime? releaseDate;
  final int? revenue;
  final int? runtime;
  final bool? softcore;
  final List<SpokenLanguage> spokenLanguages;
  final String? status;
  final String? tagline;
  final String? title;
  final bool? video;
  final double? voteAverage;
  final int? voteCount;

  factory MovieDetailModel.fromJson(
    Map<String, dynamic> json,
  ) => MovieDetailModel(
    adult: json['adult'] as bool?,
    backdropPath: json['backdrop_path'] as String?,
    belongsToCollection: json['belongs_to_collection'] is Map<String, dynamic>
        ? MovieCollection.fromJson(
            json['belongs_to_collection'] as Map<String, dynamic>,
          )
        : null,
    budget: (json['budget'] as num?)?.toInt(),
    genres: (json['genres'] as List<dynamic>? ?? const [])
        .whereType<Map<String, dynamic>>()
        .map(MovieGenre.fromJson)
        .toList(),
    homepage: json['homepage'] as String?,
    id: (json['id'] as num?)?.toInt(),
    imdbId: json['imdb_id'] as String?,
    originCountry: (json['origin_country'] as List<dynamic>? ?? const [])
        .whereType<String>()
        .toList(),
    originalLanguage: json['original_language'] as String?,
    originalTitle: json['original_title'] as String?,
    overview: json['overview'] as String?,
    popularity: (json['popularity'] as num?)?.toDouble(),
    posterPath: json['poster_path'] as String?,
    productionCompanies:
        (json['production_companies'] as List<dynamic>? ?? const [])
            .whereType<Map<String, dynamic>>()
            .map(ProductionCompany.fromJson)
            .toList(),
    productionCountries:
        (json['production_countries'] as List<dynamic>? ?? const [])
            .whereType<Map<String, dynamic>>()
            .map(ProductionCountry.fromJson)
            .toList(),
    releaseDate: DateTime.tryParse(json['release_date'] as String? ?? ''),
    revenue: (json['revenue'] as num?)?.toInt(),
    runtime: (json['runtime'] as num?)?.toInt(),
    softcore: json['softcore'] as bool?,
    spokenLanguages: (json['spoken_languages'] as List<dynamic>? ?? const [])
        .whereType<Map<String, dynamic>>()
        .map(SpokenLanguage.fromJson)
        .toList(),
    status: json['status'] as String?,
    tagline: json['tagline'] as String?,
    title: json['title'] as String?,
    video: json['video'] as bool?,
    voteAverage: (json['vote_average'] as num?)?.toDouble(),
    voteCount: (json['vote_count'] as num?)?.toInt(),
  );
}

class MovieGenre {
  const MovieGenre({this.id, this.name});
  final int? id;
  final String? name;
  factory MovieGenre.fromJson(Map<String, dynamic> json) => MovieGenre(
    id: (json['id'] as num?)?.toInt(),
    name: json['name'] as String?,
  );
}

class ProductionCompany {
  const ProductionCompany({
    this.id,
    this.logoPath,
    this.name,
    this.originCountry,
  });
  final int? id;
  final String? logoPath;
  final String? name;
  final String? originCountry;
  factory ProductionCompany.fromJson(Map<String, dynamic> json) =>
      ProductionCompany(
        id: (json['id'] as num?)?.toInt(),
        logoPath: json['logo_path'] as String?,
        name: json['name'] as String?,
        originCountry: json['origin_country'] as String?,
      );
}

class ProductionCountry {
  const ProductionCountry({this.iso31661, this.name});
  final String? iso31661;
  final String? name;
  factory ProductionCountry.fromJson(Map<String, dynamic> json) =>
      ProductionCountry(
        iso31661: json['iso_3166_1'] as String?,
        name: json['name'] as String?,
      );
}

class MovieCollection {
  const MovieCollection({
    this.id,
    this.name,
    this.posterPath,
    this.backdropPath,
  });

  final int? id;
  final String? name;
  final String? posterPath;
  final String? backdropPath;

  factory MovieCollection.fromJson(Map<String, dynamic> json) =>
      MovieCollection(
        id: (json['id'] as num?)?.toInt(),
        name: json['name'] as String?,
        posterPath: json['poster_path'] as String?,
        backdropPath: json['backdrop_path'] as String?,
      );
}

class SpokenLanguage {
  const SpokenLanguage({this.englishName, this.iso6391, this.name});

  final String? englishName;
  final String? iso6391;
  final String? name;

  factory SpokenLanguage.fromJson(Map<String, dynamic> json) => SpokenLanguage(
    englishName: json['english_name'] as String?,
    iso6391: json['iso_639_1'] as String?,
    name: json['name'] as String?,
  );
}
