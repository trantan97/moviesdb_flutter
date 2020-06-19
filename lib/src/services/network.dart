import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:moviesdb/src/constants.dart';

class Network {
  int _timeOut = 10000; //10 s
  Dio _dio;
  DioCacheManager _dioCacheManager;

  DioCacheManager get dioCacheManager {
    _dioCacheManager ??= DioCacheManager(CacheConfig(baseUrl: ApiConst.BASE_URL));
    return _dioCacheManager;
  }

  Network() {
    BaseOptions options = BaseOptions(connectTimeout: _timeOut, receiveTimeout: _timeOut);
    options.baseUrl = ApiConst.BASE_URL;
    _dio = Dio(options);
    _dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
    _dio.interceptors.add(dioCacheManager.interceptor);
  }

  Future<Response> get({String url, Map<String, dynamic> params, Options options}) async {
    try {
      params ??= {};
      options ??= buildCacheOptions(Duration(seconds: 60));

      params["api_key"] = ApiConst.API_KEY;
      return await _dio.get(url, queryParameters: params, options: options);
    } on DioError catch (e) {
      print("DioError: ${e.toString()}");
    }
  }
}
