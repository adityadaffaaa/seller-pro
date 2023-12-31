import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:marketplace/api/api.dart';
import 'package:marketplace/data/models/new_models/wallets.dart';
import 'package:marketplace/data/repositories/repositories.dart';
import 'package:marketplace/utils/constants.dart' as AppConst;
import 'package:marketplace/utils/extensions.dart' as AppExt;

class WalletRepository {
  final ApiProvider _provider = ApiProvider();
  final AuthenticationRepository _authenticationRepository =
      AuthenticationRepository();
  final String _adsKey = AppConst.API_ADS_KEY;
  final String _baseUrl = AppConst.API_URL;
  Dio dio = new Dio();

  Future<WalletHistoryResponse> getWalletHistoryList() async {
    final _token = await _authenticationRepository.getToken();
    final response = await _provider.get("/user/wallet/logs", headers: {
      HttpHeaders.authorizationHeader: 'Bearer $_token',
      'ADS-Key': _adsKey
    });

    return WalletHistoryResponse.fromJson(response);
  }

  Future<WalletNonWithdrawalDetailResponse> fetchWalletNonWithdrawalDetail(
      {@required int historyId}) async {
    final _token = await _authenticationRepository.getToken();
    final response = await _provider.get("/user/wallet/logs/$historyId",
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $_token',
          'ADS-Key': _adsKey
        });

    return WalletNonWithdrawalDetailResponse.fromJson(response);
  }

  Future<WalletWithdrawalDetailResponse> fetchWalletWithdrawalDetail(
      {@required int historyId}) async {
    final _token = await _authenticationRepository.getToken();
    final response = await _provider.get("/user/wallet/logs/$historyId",
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $_token',
          'ADS-Key': _adsKey
        });

    return WalletWithdrawalDetailResponse.fromJson(response);
  }

  Future<WalletWithdrawRuleResponse> fetchWihtdrawRule() async {
    final _token = await _authenticationRepository.getToken();
    final response = await _provider.get("/master/general", headers: {
      HttpHeaders.authorizationHeader: 'Bearer $_token',
      'ADS-Key': _adsKey
    });

    return WalletWithdrawRuleResponse.fromJson(response);
  }

  Future<WalletWithdrawResponse> withdrawWallet({
    @required int amount,
    @required int paymentMethodId,
    @required int accountNumber,
    @required String accountName,
  }) async {
    if (await AppExt.hasConnection()) {
      final token = await _authenticationRepository.getToken();
      var formData = new FormData.fromMap({
        "amount": amount,
        "payment_method_id": paymentMethodId,
        "account_number": accountNumber,
        "account_name": accountName,
      });
      debugPrint("formdata ${formData.fields}");
      var response = await dio.post(
        "$_baseUrl/user/wallet/withdraw",
        data: formData,
        options: Options(headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
          HttpHeaders.contentTypeHeader: 'text/plain',
          'ADS-Key': _adsKey
        }, validateStatus: (status) => true),
      );
      debugPrint("response $response");
      if (response.statusCode == 200) {
        return WalletWithdrawResponse.fromJson(response.data);
      } else if (response.statusCode == 500) {
        throw ServerException(response.data.toString());
      } else {
        throw GeneralException(response.data.toString());
      }
    } else {
      throw NetworkException();
    }
  }

  Future<void> withdrawWalletConfirmation({
    @required int logId,
    @required int confirmationCode,
  }) async {
    if (await AppExt.hasConnection()) {
      final token = await _authenticationRepository.getToken();
      var formData = new FormData.fromMap({
        "log_id": logId,
        "confirmation_code": confirmationCode,
      });
      debugPrint("formdata ${formData.fields}");
      var response = await dio.post(
        "$_baseUrl/user/wallet/withdraw/confirm",
        data: formData,
        options: Options(headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
          HttpHeaders.contentTypeHeader: 'text/plain',
          'ADS-Key': _adsKey
        }, validateStatus: (status) => true),
      );
      debugPrint("response $response");
      if (response.statusCode == 200) {
        debugPrint("myresponsesuccess ${response.data}");
      } else if (response.statusCode == 500) {
        throw ServerException(response.data.toString());
      } else {
        throw GeneralException(response.data.toString());
      }
    } else {
      throw NetworkException();
    }
  }

  Future<void> withdrawWalletResendOTP({
    @required int logId,
  }) async {
    if (await AppExt.hasConnection()) {
      final token = await _authenticationRepository.getToken();
      var formData = new FormData.fromMap({
        "log_id": logId,
      });
      debugPrint("formdata ${formData.fields}");
      var response = await dio.post(
        "$_baseUrl/user/wallet/withdraw",
        data: formData,
        options: Options(headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
          HttpHeaders.contentTypeHeader: 'text/plain',
          'ADS-Key': _adsKey
        }, validateStatus: (status) => true),
      );
      debugPrint("response $response");
      if (response.statusCode == 200) {
        debugPrint("myresponse ${response.data}");
      } else if (response.statusCode == 500) {
        throw ServerException(response.data.toString());
      } else {
        throw GeneralException(response.data.toString());
      }
    } else {
      throw NetworkException();
    }
  }

  Future<WalletPaymentResponse> orderWithSaldoPanen(
      {@required int amount}) async {
    if (await AppExt.hasConnection()) {
      var formData = new FormData.fromMap({
        "amount": amount,
      });
      final token = await _authenticationRepository.getToken();
      var response = await dio.post(
        "$_baseUrl/user/wallet/payment",
        data: formData,
        options: Options(headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
          HttpHeaders.contentTypeHeader: 'application/json',
          'ADS-Key': _adsKey
        }, validateStatus: (status) => true),
      );

      debugPrint("response $response");

      if (response.statusCode == 200) {
        return WalletPaymentResponse.fromJson(response.data);
      } else if (response.statusCode == 500) {
        throw ServerException(response.data.toString());
      } else {
        throw GeneralException(response.data.toString());
      }
    } else {
      throw NetworkException();
    }
  }

  Future<WalletPaymentResponse> orderWithSaldoPanenConfirmation(
      {@required int logId, @required int confirmationCode}) async {
    if (await AppExt.hasConnection()) {
      var formData = new FormData.fromMap(
          {"log_id": logId, "confirmation_code": confirmationCode});
      final token = await _authenticationRepository.getToken();
      var response = await dio.post(
        "$_baseUrl/user/wallet/payment/confirm",
        data: formData,
        options: Options(headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
          HttpHeaders.contentTypeHeader: 'application/json',
          'ADS-Key': _adsKey
        }, validateStatus: (status) => true),
      );

      debugPrint("response $response");

      if (response.statusCode == 200) {
        return WalletPaymentResponse.fromJson(response.data);
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
