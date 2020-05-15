import 'package:dio/dio.dart';

extension DioExtension on Response {
  bool get isSuccess {
    return this.statusCode != null && this.statusCode == 200;
  }
}
