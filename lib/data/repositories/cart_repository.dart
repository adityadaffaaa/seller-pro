import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:marketplace/api/api.dart';
import 'package:marketplace/data/models/models.dart';
import 'package:marketplace/data/repositories/repositories.dart';
import 'package:meta/meta.dart';
import 'package:marketplace/utils/constants.dart' as AppConst;

class CartRepository {
  final ApiProvider _provider = ApiProvider();
  final AuthenticationRepository _authenticationRepository =
      AuthenticationRepository();
  final gs = GetStorage();
  final String _adsKey = AppConst.API_ADS_KEY;

  // v2
  Future<AddCartResponse> addToCart({
    @required int productId,
    @required int sellerId,
    @required int isVariant,
    @required int variantId,
  }) async {
    final token = await _authenticationRepository.getToken();

    final Map<String, dynamic> body = {
      'product_id': productId,
      'is_variant': isVariant,
      'variant_id': isVariant == 0 ? null : variantId
    };

    final response =
        await _provider.post("/cart/store", body: jsonEncode(body), headers: {
      HttpHeaders.authorizationHeader: 'Bearer $token',
      HttpHeaders.contentTypeHeader: 'application/json',
      'ADS-Key':_adsKey
    });
    return AddCartResponse.fromJson(response);
  }

  Future<NewCartResponse> fetchCart({String param = ""}) async {
    final token = await _authenticationRepository.getToken();
    debugPrint("token $token");

    final response = await _provider.get("/cart/show$param", headers: {
      HttpHeaders.authorizationHeader: 'Bearer $token',
      HttpHeaders.contentTypeHeader: 'application/json',
      'ADS-Key':_adsKey
    });
    return NewCartResponse.fromJson(response);
  }

  Future<void> updateQuantity(
      {@required List<int> cartId, @required List<int> quantity}) async {
    final token = await _authenticationRepository.getToken();

    final Map<String, dynamic> body = {
      'cart_id': cartId.toList(),
      'quantity': quantity.toList(),
    };

    final response = await _provider
        .post("/cart/quantity", body: jsonEncode(body), headers: {
      HttpHeaders.authorizationHeader: 'Bearer $token',
      HttpHeaders.contentTypeHeader: 'application/json',
      'ADS-Key':_adsKey
    });

    debugPrint("RESPONSE: ${response.toString()}");
    // return UpdateCartQuantityResponse.fromJson(response);
  }

  Future<GeneralResponse> deleteCartItem({@required String cartId}) async {
    final token = await _authenticationRepository.getToken();
    debugPrint("cartId $cartId");

    final response =
        await _provider.delete("/cart/delete/?cart_id%5B%5D=$cartId", headers: {
      HttpHeaders.authorizationHeader: 'Bearer $token',
      HttpHeaders.contentTypeHeader: 'application/json',
      'ADS-Key':_adsKey
    });
    debugPrint("response ${response}");
    return GeneralResponse.fromJson(response);
  }

  Future<GeneralResponse> cartStockValidation(
      {@required int sellerId,
      @required List<int> productId,
      @required List<int> quantity}) async {
    final token = await _authenticationRepository.getToken();

    final Map<String, dynamic> body = {
      'product_id': productId.toList(),
      'quantity': quantity.toList(),
    };
    final response = await _provider
        .post("/cart/validation/stock", body: jsonEncode(body), headers: {
      // HttpHeaders.authorizationHeader: 'Bearer $token',
      HttpHeaders.contentTypeHeader: 'application/json',
      'ADS-Key':_adsKey
    });
    return GeneralResponse.fromJson(response);
  }

  Future<CountCartResponse> countCart() async {
    final token = await _authenticationRepository.getToken();

    final response = await _provider.get("/cart/count", headers: {
      HttpHeaders.authorizationHeader: 'Bearer $token',
      HttpHeaders.contentTypeHeader: 'application/json',
      'ADS-Key':_adsKey
    });
    return CountCartResponse.fromJson(response);
  }


}
