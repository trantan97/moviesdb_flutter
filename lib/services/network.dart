import 'package:dio/dio.dart';
import 'package:moviesdb/constants.dart';

class Network {
  int _timeOut = 10000; //10 s
  Dio _dio;

  Network() {
    BaseOptions options = BaseOptions(connectTimeout: _timeOut, receiveTimeout: _timeOut);
    options.baseUrl = ApiConst.BASE_URL;
    _dio = Dio(options);
    _dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
  }

  Future<Response> get({String url, Map<String, dynamic> params}) async {
    try {
      params["api_key"] = ApiConst.API_KEY;
      return await _dio.get(url, queryParameters: params, options: Options(responseType: ResponseType.json));
    } on DioError catch (e) {
      print("DioError: ${e.toString()}");
    }
  }
}
