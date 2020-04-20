import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
class GeneralServices{
  final Dio _dio = Dio()
    ..options.baseUrl = 'http://165.22.19.197:8080/accessing-data-mysql/'
    ..options.connectTimeout = 5000
    ..options.receiveTimeout = 3000;
  final cookieJar=CookieJar();
  GeneralServices(){
 _dio.interceptors.add(CookieManager(cookieJar));
  }
  get dio=>_dio;
}