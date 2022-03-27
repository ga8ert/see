import 'package:dio/dio.dart';
import 'package:untitled/model/genre_response.dart';
import 'package:untitled/model/movie_response.dart';
import 'package:untitled/model/person_response.dart';

class MovieRepository{
  final String apiKey = "76a9e1145013a1e3f2a7553e0b82e128";
  static String mainUrl = "https://api.themoviedb.org/3";
  final Dio _dio = Dio();
  var getPopularUrl = '$mainUrl/movie/top_rated';
  var getMoviesUrl = '$mainUrl/discover/movie';
  var getPlayingUrl = '$mainUrl/movie/now_plaing';
  var getGenresUrl = '$mainUrl/genre/movie/list';
  var getPersonUrl = '$mainUrl/trending/person/week';

  Future<MovieResponse> getMovies() async {
    var params = {
      "api-key": apiKey,
      "language": "en-Us",
      "page": 1,
    };
  try{
    Response response = await _dio.get(getPopularUrl, queryParameters: params);
    return MovieResponse.fromJson(response.data);
  }  catch(error, stacktrace){
    print("Exceproin occured: $error stackTrace: $stacktrace");
    return MovieResponse.withError("$error");
  }
  }

  Future<MovieResponse> getPlaingMovies() async {
    var params = {
      "api-key": apiKey,
      "language": "en-Us",
      "page": 1,
    };
    try{
      Response response = await _dio.get(getPlayingUrl, queryParameters: params);
      return MovieResponse.fromJson(response.data);
    }  catch(error, stacktrace){
      print("Exceproin occured: $error stackTrace: $stacktrace");
      return MovieResponse.withError("$error");
    }
  }

  Future<GenreResponse> getGenres() async {
    var params = {
      "api-key": apiKey,
      "language": "en-Us",
      "page": 1,
    };
    try{
      Response response = await _dio.get(getGenresUrl, queryParameters: params);
      return GenreResponse.fromJson(response.data);
    }  catch(error, stacktrace){
      print("Exceproin occured: $error stackTrace: $stacktrace");
      return GenreResponse.withError("$error");
    }
  }

  Future<PersonResponse> getPerson() async {
    var params = {
      "api-key": apiKey,
    };
    try{
      Response response = await _dio.get(getPersonUrl, queryParameters: params);
      return PersonResponse.fromJson(response.data);
    }  catch(error, stacktrace){
      print("Exceproin occured: $error stackTrace: $stacktrace");
      return PersonResponse.withError("$error");
    }
  }

  Future<MovieResponse> getMovieByGenre(int id) async {
    var params = {
      "api-key": apiKey,
      "language": "en-Us",
      "page": 1,
      "with_genres": id
    };
    try{
      Response response = await _dio.get(getMoviesUrl, queryParameters: params);
      return MovieResponse.fromJson(response.data);
    }  catch(error, stacktrace){
      print("Exceproin occured: $error stackTrace: $stacktrace");
      return MovieResponse.withError("$error");
    }
  }
}