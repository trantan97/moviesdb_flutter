import 'package:equatable/equatable.dart';

class Video extends Equatable {
  String id;
  String key;
  String name;
  int size;
  String type;

  @override
  List<Object> get props => [id, name];

  static Video fromJson(Map<String, dynamic> json) {
    return Video()
      ..id = json["id"]
      ..name = json["name"]
      ..key = json["key"]
      ..size = json["size"]
      ..type = json["type"];
  }
}
