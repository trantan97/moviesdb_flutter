import 'package:equatable/equatable.dart';

class Company extends Equatable {
  int id;
  String name;
  String logoPath;
  String country;

  @override
  List<Object> get props => [id, name];

  static Company fromJson(Map<String, dynamic> json) {
    return Company()
      ..id = json["id"]
      ..name = json["name"]
      ..logoPath = json["logo_path"]
      ..country = json["origin_country"];
  }
}
