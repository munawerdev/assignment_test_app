// To parse this JSON data, do
//
//     final watchModel = watchModelFromJson(jsonString);

import 'dart:convert';

WatchModel watchModelFromJson(String str) =>
    WatchModel.fromJson(json.decode(str));

class WatchModel {
  final Dates dates;
  final int page;
  final List<Result> results;
  final int totalPages;
  final int totalResults;

  WatchModel({
    required this.dates,
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory WatchModel.fromJson(Map<String, dynamic> json) => WatchModel(
    dates: Dates.fromJson(json['dates']),
    page: json['page'],
    results: List<Result>.from(json['results'].map((x) => Result.fromJson(x))),
    totalPages: json['total_pages'],
    totalResults: json['total_results'],
  );
}

class Dates {
  final DateTime maximum;
  final DateTime minimum;

  Dates({required this.maximum, required this.minimum});

  factory Dates.fromJson(Map<String, dynamic> json) => Dates(
    maximum: DateTime.parse(json['maximum']),
    minimum: DateTime.parse(json['minimum']),
  );
}

class Result {
  final bool adult;
  final String backdropPath;
  final List<int> genreIds;
  final int id;
  final String title;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String posterPath;
  final DateTime releaseDate;
  final bool softcore;
  final bool video;
  final double voteAverage;
  final int voteCount;

  Result({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.title,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.softcore,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    adult: json['adult'],
    backdropPath: json['backdrop_path'],
    genreIds: List<int>.from(json['genre_ids'].map((x) => x)),
    id: json['id'],
    title: json['title'],
    originalLanguage: json['original_language'],
    originalTitle: json['original_title'],
    overview: json['overview'],
    popularity: json['popularity']?.toDouble(),
    posterPath: json['poster_path'],
    releaseDate: DateTime.parse(json['release_date']),
    softcore: json['softcore'],
    video: json['video'],
    voteAverage: json['vote_average']?.toDouble(),
    voteCount: json['vote_count'],
  );
}
