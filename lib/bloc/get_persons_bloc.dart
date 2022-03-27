import 'package:rxdart/subjects.dart';
import 'package:untitled/model/person_response.dart';
import 'package:untitled/repository/repository.dart';

class PersonListBloc{
  final MovieRepository _repository = MovieRepository();
  final BehaviorSubject<PersonResponse> _subject = BehaviorSubject<PersonResponse>();

  getMovies() async{
    PersonResponse response = await _repository.getPerson();
    _subject.sink.add(response);
  }

  dispose(){
    _subject.close();
  }
  BehaviorSubject<PersonResponse> get subject => _subject;
}
final personsBloc = PersonListBloc();