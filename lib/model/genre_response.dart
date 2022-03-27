import 'package:untitled/model/genre.dart';

class GenreResponse{
  final List<Genre> genres;
  final String error;

  GenreResponse(
      this.error,
      this.genres
      );
  GenreResponse.fromJson(Map<String, dynamic> json)
      : genres =
  (json["genres"] as List).map((i) => Genre.fromJson(i)).toList(),
        error = "";

  GenreResponse.withError(String errorValue)
      : genres = [],
        error = errorValue;
}