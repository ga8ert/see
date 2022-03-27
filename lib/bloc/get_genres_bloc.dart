import 'package:rxdart/subjects.dart';
import 'package:untitled/model/genre_response.dart';
import 'package:untitled/repository/repository.dart';

class GenresListBloc{
  final MovieRepository _repository = MovieRepository();
  final BehaviorSubject<GenreResponse> _subject = BehaviorSubject<GenreResponse>();

  getGenres() async{
    GenreResponse response = await _repository.getGenres();
    _subject.sink.add(response);
  }

  dispose(){
    _subject.close();
  }
  BehaviorSubject<GenreResponse> get subject => _subject;
}
final moviesBloc = GenresListBloc();