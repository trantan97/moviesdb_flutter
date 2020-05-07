import 'package:equatable/equatable.dart';

class Genre extends Equatable {
  int id;
  String name;

  @override
  List<Object> get props => [id, name];

  static Genre fromJson(Map<String, dynamic> json) {
    return Genre()
      ..id = json["id"]
      ..name = json["name"];
  }
}
