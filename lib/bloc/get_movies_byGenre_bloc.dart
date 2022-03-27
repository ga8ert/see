import 'package:rxdart/subjects.dart';
import 'package:untitled/model/movie_response.dart';
import 'package:untitled/repository/repository.dart';

class MovieListByGenryBloc{
  final MovieRepository _repository = MovieRepository();
  final BehaviorSubject<MovieResponse> _subject = BehaviorSubject<MovieResponse>();

  getMoviesByGenre(int id) async{
    MovieResponse response = await _repository.getMovieByGenre(id);
    _subject.sink.add(response);
  }

  dispose(){
    _subject.close();
  }
  BehaviorSubject<MovieResponse> get subject => _subject;
}
final moviesByGenreBloc = MovieListByGenryBloc();