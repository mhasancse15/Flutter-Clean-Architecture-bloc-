import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiClient {
  final Dio _dio = Dio();

  ApiClient() {
    _dio.options.baseUrl = "http://jsonplaceholder.typicode.com";
    _dio.options.headers["Content-Type"] = "application/json";

    _dio.interceptors.add(PrettyDioLogger());
  }

  Dio get sendRequest => _dio;
}