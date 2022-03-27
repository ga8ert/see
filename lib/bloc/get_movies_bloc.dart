
import 'package:rxdart/rxdart.dart';
import 'package:untitled/model/movie_response.dart';
import 'package:untitled/repository/repository.dart';

class MovieListBloc{
  final MovieRepository _repository = MovieRepository();
  final BehaviorSubject<MovieResponse> _subject = BehaviorSubject<MovieResponse>();

  getMovies() async{
    MovieResponse response = await _repository.getMovies();
    _subject.sink.add(response);
  }

  dispose(){
    _subject.close();
  }
  BehaviorSubject<MovieResponse> get subject => _subject;
}
final moviesBloc = MovieListBloc();