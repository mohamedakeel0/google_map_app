import 'dart:convert';
import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(BaseOptions(
      baseUrl: 'https://ibtikarsoft.net/',
      receiveDataWhenStatusError: true,
    ));
  }

  static Future<Response> getdata(
      {required String url, required Map<String, dynamic> query}) async {
    return await dio.get(
      url,
      queryParameters: query,
    );

  }
}
