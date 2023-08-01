import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:marketplace/api/api.dart';
import 'package:marketplace/data/models/new_models/location.dart';
import 'package:marketplace/data/repositories/repositories.dart';
import 'package:marketplace/utils/constants.dart' as AppConst;
import 'package:marketplace/utils/extensions.dart' as AppExt;

class LocationRepository {
  final ApiProvider _provider = ApiProvider();
  final String _adsKey = AppConst.API_ADS_KEY;
  final String _baseUrl = AppConst.API_URL;
  final AuthenticationRepository _authenticationRepository =
      AuthenticationRepository();
  Dio dio = new Dio();

  Future<GeneralRegionResponse> fetchProvinces() async {
    final response = await _provider.get("/master/provinces", headers: {
      HttpHeaders.contentTypeHeader: 'text/plain',
      'ADS-Key': _adsKey
    });

    return GeneralRegionResponse.fromJson(response);
  }

  Future<GeneralRegionResponse> fetchCities({@required int provinceId}) async {
    final response = await _provider
        .get("/master/cities?province_id=$provinceId", headers: {
      HttpHeaders.contentTypeHeader: 'text/plain',
      'ADS-Key': _adsKey
    });

    return GeneralRegionResponse.fromJson(response);
  }

  Future<GeneralLocationFilter> fetchLocationFilter(
      {@required String keyword}) async {
    final response = await _provider.get("/master/locations?keyword=$keyword",
        headers: {
          HttpHeaders.contentTypeHeader: 'text/plain',
          'ADS-Key': _adsKey
        });

    return GeneralLocationFilter.fromJson(response);
  }

  Future<GoogleMapsUrlResponse> fetchGoogleMapsUrl() async {
    if (await AppExt.hasConnection()) {
      final token = await _authenticationRepository.getToken();

      int value = 99999999;
      print(new Random().nextInt(value));

      var formData = new FormData.fromMap({
        "identifier": Random().nextInt(value),
      });
      debugPrint("formdata ${formData.fields}");
      var response = await dio.post(
        "$_baseUrl/get-map-url",
        data: formData,
        options: Options(headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
          HttpHeaders.contentTypeHeader: 'text/plain',
          'ADS-Key': _adsKey
        }, validateStatus: (status) => true),
      );
      debugPrint("response $response");
      if (response.statusCode == 200) {
        return GoogleMapsUrlResponse.fromJson(response.data);
      } else if (response.statusCode == 500) {
        throw ServerException(response.data.toString());
      } else {
        throw GeneralException(response.data.toString());
      }
    } else {
      throw NetworkException();
    }
  } 

  Future<GoogleMapsUrlResponse> fetchGoogleMapsUrlNoAuth({
    @required String phoneNumber
  }) async {
    if (await AppExt.hasConnection()) {

      int value = 99999999;
      print(new Random().nextInt(value));

      var formData = new FormData.fromMap({
        "identifier": Random().nextInt(value),
        "phonenumber":phoneNumber
      });
      debugPrint("formdata ${formData.fields}");
      var response = await dio.post(
        "$_baseUrl/no-auth/get-map-url",
        data: formData,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: 'text/plain',
          'ADS-Key': _adsKey
        }, validateStatus: (status) => true),
      );
      debugPrint("response $response");
      if (response.statusCode == 200) {
        return GoogleMapsUrlResponse.fromJson(response.data);
      } else if (response.statusCode == 500) {
        throw ServerException(response.data.toString());
      } else {
        throw GeneralException(response.data.toString());
      }
    } else {
      throw NetworkException();
    }
  }
}
