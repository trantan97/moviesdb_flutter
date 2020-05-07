import 'package:equatable/equatable.dart';

class Actor extends Equatable{
  String id;
  String name;
  String profilePath;
  String character;
  String birthDay;
  String biography;
  String placeOfBirth;
  String popularity;
  String gender;
  String knownForDepartment;

  @override
  List<Object> get props => [id, name];

  static Actor fromJson(Map<String, dynamic> json){
    return Actor()
        ..id = json["id"]
        ..name = json["name"]
        ..profilePath = json["profile_path"]
        ..character = json["character"]
        ..birthDay = json["birthday"]
        ..biography = json["biography"]
        ..placeOfBirth = json["place_of_birth"]
        ..popularity = json["popularity"]
        ..gender = json["gender"]
        ..knownForDepartment = json["known_for_department"];
  }
}