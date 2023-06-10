import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:to_let_go/util/constants.dart';

class BaseDio {

  //Get base dio for all api
  Future<Dio> getBaseDioForFCM() async {
    String baseURL = Constants.fcmBaseUrl;
    BaseOptions options = BaseOptions(
      baseUrl: baseURL,
      connectTimeout: const Duration(milliseconds: Constants.connectionTimeOut),
      responseType: ResponseType.json,
      headers: {
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: Constants.fcmKey
      },
    );

    Dio dio = Dio(options);
    dio.interceptors.add(LogInterceptor(
      request: kDebugMode,
      requestHeader: kDebugMode,
      requestBody: kDebugMode,
      responseHeader: kDebugMode,
      responseBody: kDebugMode,
    ));
    return dio;
  }
}
