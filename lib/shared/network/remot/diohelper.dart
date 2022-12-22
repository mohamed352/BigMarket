// ignore: camel_case_types
import 'package:dio/dio.dart';

// ignore: camel_case_types
class Dio_Helper {
  static Dio? dio;
  static intal() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
         //headers: {
          //'Content-Type': 'application/json',
        //},
       
      ),
    );
  }

  static Future<Response> get({
    required String url,
    Map<String, dynamic>? qery,
    String lang = 'en',
    String? token,
  }) async {
    dio?.options.headers = 
     {
      'lang': lang,
      'Authorization': token??'',
       'Content-Type': 'application/json',

    };
    return await dio!.get(url, queryParameters: qery);
  }

  static Future<Response> post({
    required String url,
     Map<String, dynamic>? qery,
    required  Map<String, dynamic> data,
    String lang = 'en',
    String? token,
  }) async {
    dio?.options.headers = {
      'lang': lang,
      'Authorization': token??'',
      'Content-Type': 'application/json',
    };

    return await dio!.post(url, queryParameters: qery, data: data);
  }
  static Future<Response> put({
    required String url,
     Map<String, dynamic>? qery,
    required  Map<String, dynamic> data,
    String lang = 'en',
    String? token,
  }) async {
    dio?.options.headers = {
      'lang': lang,
      'Authorization': token??'',
      'Content-Type': 'application/json',
    };

    return await dio!.put(url, queryParameters: qery, data: data);
  }
}
