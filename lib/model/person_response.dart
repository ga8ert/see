import 'package:untitled/model/person.dart';

class PersonResponse{
  final List<Person> person;
  final String error;

  PersonResponse(
      this.error,
      this.person
      );
  PersonResponse.fromJson(Map<String, dynamic> json)
      : person =
    (json["results"] as List).map((i) => Person.fromJson(i)).toList(),
        error = "";

  PersonResponse.withError(String errorValue)
      : person = [],
        error = errorValue;
}