// Source:
// https://medium.com/flutter-community/handling-network-calls-like-a-pro-in-flutter-31bd30c86be1

import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:marketplace/api/api.dart';
import 'package:marketplace/utils/constants.dart' as AppConst;
import 'package:marketplace/utils/extensions.dart' as AppExt;

class ApiProvider {
  ApiProvider._() {
    _baseUrl = _defaultBaseUrl;
  }

  static ApiProvider _instance;
  factory ApiProvider() => _instance ??= ApiProvider._();

  final String _defaultBaseUrl = AppConst.API_URL;
  String _baseUrl;

  void setBaseUrl(String baseUrl) => _baseUrl = baseUrl;

  String get baseUrl => _baseUrl;
  String get defaultBaseUrl => _defaultBaseUrl;

  Future<dynamic> get(dynamic url, {Map<String, String> headers}) async {
    var responseJson;
    if (await AppExt.hasConnection()) {
      final response =
          await http.get(Uri.parse(_baseUrl + url), headers: headers);

      responseJson = _returnResponse(response);
    } else {
      throw NetworkException();
    }

    return responseJson;
  }

  Future<dynamic> getWithoutBaseurl(dynamic url,
      {Map<String, String> headers}) async {
    var responseJson;
    try {
      final response = await http.get(Uri.parse(url), headers: headers);

      responseJson = _returnResponse(response);
    } on SocketException {
      throw NetworkException();
    }
    return responseJson;
  }

  Future<dynamic> post(String url,
      {dynamic body, Map<String, String> headers}) async {
    var responseJson;
    if (await AppExt.hasConnection()) {
      final response = await http.post(Uri.parse(_baseUrl + (url)),
          body: body, headers: headers);

      responseJson = _returnResponse(response);
    } else {
      throw NetworkException("Tidak ada koneksi internet");
    }
    return responseJson;
  }

  Future<dynamic> put(String url,
      {dynamic body, Map<String, String> headers}) async {
    var responseJson;

    if (await AppExt.hasConnection()) {
      final response = await http.put(Uri.parse(_baseUrl + url),
          body: body, headers: headers);

      responseJson = _returnResponse(response);
    } else {
      throw NetworkException("Tidak ada koneksi internet");
    }
    return responseJson;
  }

  Future<dynamic> delete(String url, {Map<String, String> headers}) async {
    var responseJson;
    if (await AppExt.hasConnection()) {
      final response =
          await http.delete(Uri.parse(_baseUrl + url), headers: headers);

      responseJson = _returnResponse(response);
    } else {
      throw NetworkException("Tidak ada koneksi internet");
    }
    return responseJson;
  }

  dynamic _returnResponse(http.Response response) {
    // var responseJsonModif = json.decode(response.body.toString());
    // final error = responseJson['message'] ?? 'Terjadi kesalahan';
    final error = 'TERJADI KESALAHAN !!!!!!!!!!!';

    if (kDebugMode) {
      String responseJsonStr = response.body;
      String endpointPath = response.request.url.path;
      String endpointStr = response.request.url.toString();
      String endpointMethod = response.request.method;

      debugPrint('\x1B[31m\n->\x1B[0m');
      debugPrint('\x1B[32m[$endpointMethod] $endpointStr\x1B[0m');
      debugPrint('\x1B[33m$responseJsonStr\x1B[0m');
    }

    // return responseJson;

    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());

        final statusCode = responseJson['status'] ?? null;
        final message = responseJson['message'] ?? 'Terjadi kesalahan';
        final String firstCode = statusCode != null ? statusCode[0] : null;

        if (statusCode != null && firstCode != "2") {
          switch (firstCode) {
            case "4":
              throw ClientException(message);
            case "5":
              throw ServerException(message);
            default:
              throw GeneralException(message);
          }
        }

        return responseJson;
      case 400:
        throw GeneralException('Terjadi kesalahan, [400]');
      // throw BadRequestException(response.body.toString());
      case 401:
        var responseJson401 = json.decode(response.body.toString());
        final error = responseJson401['message'] ?? 'Terjadi kesalahan , 401';
        // throw GeneralException('Terjadi kesalahan, [401]');
        throw error;
      case 403:
        throw UnauthorisedException(jsonDecode(response.body.toString()));
      // throw UnauthorisedException(jsonDecode(response.body.toString()));
      case 404:
        throw GeneralException('Terjadi kesalahan, [404]');
      case 500:
        throw ServerException(error);
      default:
        throw FetchDataException(
            'Terjadi kesalahan pada server : ${response.statusCode}');
    }
  }
}
