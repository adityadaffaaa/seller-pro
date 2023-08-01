import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:marketplace/api/api.dart';
import 'package:marketplace/data/models/models.dart';
import 'package:marketplace/data/models/user.dart';
import 'package:marketplace/data/repositories/authentication_repository.dart';
import 'package:meta/meta.dart';
import 'package:marketplace/utils/constants.dart' as AppConst;
import 'package:marketplace/utils/extensions.dart' as AppExt;

class UserRepository {
  final ApiProvider _provider = ApiProvider();
  final AuthenticationRepository _authenticationRepository =
      AuthenticationRepository();
  final String _baseUrl = AppConst.API_URL;
  final String _adsKey = AppConst.API_ADS_KEY;

  Future<SignUpResponse> signUp({
    @required String name,
    @required String phoneNumber,
  }) async {
    SignUpRequest body = SignUpRequest(name: name, phonenumber: phoneNumber);
    final response = await _provider
        .post("/register", body: jsonEncode(body.toJson()), headers: {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.contentTypeHeader: 'application/json',
      'ADS-Key': _adsKey
    });
    return SignUpResponse.fromJson(response);
  }

  Future<GeneralResponse> upgradeUser() {}

  Future<UserResponse> fetchUser() async {
    final _token = await _authenticationRepository.getToken();
    final response = await _provider.get("/user/profile", headers: {
      HttpHeaders.authorizationHeader: 'Bearer $_token',
      'ADS-Key': _adsKey
    });
    return UserResponse.fromJson(response);
  }

  Future<CheckUserResponse> fetchCheckUser(
      {@required String phoneNumber}) async {
    Map<String, String> queryParams = {
      'phonenumber': '$phoneNumber',
    };
    String queryString = Uri(queryParameters: queryParams).query;
    var requestUrl = '/check-user?' + queryString;
    final response = await _provider.get(requestUrl, headers: {
      HttpHeaders.contentTypeHeader: 'text/plain',
      'ADS-Key': _adsKey
    });
    return CheckUserResponse.fromJson(response);
  }

  Future<RecipentResponse> fetchRecipent(String token) async {
    final _token = await _authenticationRepository.getToken();
    final response = await _provider.get(
      "/user/recipient",
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $_token',
        HttpHeaders.contentTypeHeader: 'application/json',
        'ADS-Key': _adsKey
      },
    );
    return RecipentResponse.fromJson(response);
  }

  Future<GeneralResponse> editProfile({@required String name}) async {
    final token = await _authenticationRepository.getToken();
    final response = await _provider.post(
      "/user/profile/edit",
      body: jsonEncode({"name": name}),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
        HttpHeaders.contentTypeHeader: 'application/json',
        'ADS-Key': _adsKey
      },
    );
    return GeneralResponse.fromJson(response);
  }

  Future<GeneralResponse> uploadAvatar({@required String image}) async {
    if (await AppExt.hasConnection()) {
      final _token = await _authenticationRepository.getToken();
      Dio dio = new Dio();
      FormData formData = new FormData.fromMap({
        "avatar": await MultipartFile.fromFile(image, filename: "avatar"),
      });
      var response = await dio.post(
        "$_baseUrl/user/avatar",
        data: formData,
        options: Options(
          headers: {'Authorization': 'Bearer $_token', 'ADS-Key': _adsKey},
        ),
      );
      if (response.statusCode == 200) {
        return GeneralResponse.fromJson(response.data);
      } else if (response.statusCode == 500) {
        throw ServerException(response.data.toString());
      } else {
        throw GeneralException(response.data.toString());
      }
    } else {
      throw NetworkException();
    }
  }

  Future<GeneralResponse> uploadAvatarWeb(image) async {
    final _token = await _authenticationRepository.getToken();

    Uint8List data = await image.readAsBytes();
    List<int> list = data.cast<int>();

    Dio dio = new Dio();
    FormData formData = new FormData.fromMap({
      "avatar": MultipartFile.fromBytes(list, filename: "avatar"),
    });

    var response = await dio.post(
      "$_baseUrl/user/avatar",
      data: formData,
      options: Options(
        headers: {'Authorization': 'Bearer $_token', 'ADS-Key': _adsKey},
      ),
    );
    if (response.statusCode == 200) {
      return GeneralResponse.fromJson(response.data);
    } else if (response.statusCode == 500) {
      throw ServerException(response.data.toString());
    } else {
      throw GeneralException(response.data.toString());
    }
  }
}
