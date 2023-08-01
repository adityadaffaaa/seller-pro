import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:marketplace/api/api.dart';
import 'package:marketplace/data/models/models.dart';
import 'package:marketplace/data/models/new_models/tracking.dart';
import 'package:marketplace/data/repositories/repositories.dart';
import 'package:marketplace/utils/constants.dart' as AppConst;
import 'package:marketplace/utils/extensions.dart' as AppExt;

class OrderRepository {
  final Dio dio = new Dio();
  final ApiProvider _provider = ApiProvider();
  final AuthenticationRepository _authRepo = AuthenticationRepository();

  Future<GeneralOrderResponse> addOrder(
      {@required List<int> itemId,
      @required int recipientId,
      @required List<String> shippingCode,
      @required List<int> ongkir,
      @required List<String> note,
      @required String verificationMethod,
      @required int paymentMethodId,
      int walletLogId,
      String walletLogToken}) async {
    if (await AppExt.hasConnection()) {
      final token = await _authRepo.getToken();
      var formData = new FormData.fromMap({
        "item_id[]": itemId,
        "recipient_id": recipientId,
        "shipping_code[]": shippingCode,
        "ongkir[]": ongkir,
        "note[]": note,
        "verification_method": verificationMethod,
        "payment_method_id": paymentMethodId,
        "wallet_log_id": walletLogId != 0 ? walletLogId : null,
        "wallet_log_token": walletLogToken != null ? walletLogToken : null
      });

      debugPrint("formdata ${formData.fields}");

      var response = await dio.post(
        "${AppConst.API_URL}/order/store",
        data: formData,
        options: Options(headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
          HttpHeaders.contentTypeHeader: 'application/json',
          'ADS-Key': AppConst.API_ADS_KEY,
        }, validateStatus: (status) => true),
      );

      // debugPrint("status code ${response.statusCode}");
      debugPrint("response $response");

      if (response.statusCode == 200) {
        return GeneralOrderResponse.fromJson(response.data);
      } else if (response.statusCode == 500) {
        throw ServerException(response.data.toString());
      } else {
        throw GeneralException(response.data.toString());
      }
    } else {
      throw NetworkException();
    }
  }

  Future<GeneralOrderResponse> addOrderNoAuth(
      {@required String slug,
      @required String name,
      @required String phoneNumber,
      @required String email,
      @required String address,
      @required int subdistrictId,
      @required String verificationMethod,
      @required int paymentMethodId,
      @required List<NewCart> carts,
      List<NoteTemp> notes,
      List<OngkirTemp> ongkirs,
      List<ShippingCodeTemp> shppingCodes}) async {
    debugPrint("CHECK NOTES" + notes.toString());
    debugPrint("CHECK ONGKIRS" + ongkirs.toString());
    debugPrint("CHECK SHIPPINGCODES" + shppingCodes.toString());
    debugPrint("CHECK PRODUCTS" +
        carts[0]
            .product
            .map((e) => ProductAddOrderNoAuth(
                productId: e.id,
                isVariant: e.variantSelected != null ? 1 : 0,
                variantId: e.variantSelected != null ? e.variantSelected.id : 0,
                quantity: e.quantity))
            .toList()
            .toString());

    List<CartTempAddOrderNoAuth> cartsTemp = [];
    for (int i = 0; i < carts.length; i++) {
      cartsTemp.add(CartTempAddOrderNoAuth(
          supplierId: carts[i].supplierId,
          ongkir: ongkirs[i].ongkir,
          shippingCode: shppingCodes[i].shippingCode,
          note: notes[i].note,
          products: carts[i]
              .product
              .map((e) => ProductAddOrderNoAuth(
                  productId: e.id,
                  isVariant: e.variantSelected != null ? 1 : 0,
                  variantId:
                      e.variantSelected != null ? e.variantSelected.id : 0,
                  quantity: e.quantity))
              .toList()));
    }
    Map<String, dynamic> body = {
      "slug": slug,
      "name": name,
      "phonenumber": phoneNumber,
      "email": email,
      "address": address,
      "subdistrict_id": subdistrictId,
      "verification_method": verificationMethod,
      "payment_method_id": paymentMethodId,
      "carts": cartsTemp,
    };
    final response = await _provider
        .post("/order/noauth/store", body: jsonEncode(body), headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      'ADS-Key': AppConst.API_ADS_KEY,
    });
    return GeneralOrderResponse.fromJson(response);
  }

  Future<GeneralResponse> cancelOrder({@required int paymentId}) async {
    final token = await _authRepo.getToken();
    final response =
        await _provider.post("/order/$paymentId/cancel-order", headers: {
      HttpHeaders.authorizationHeader: 'Bearer $token',
      HttpHeaders.contentTypeHeader: 'application/json',
      'ADS-Key': AppConst.API_ADS_KEY,
    });
    return GeneralResponse.fromJson(response);
  }

  Future<TrackingOrderResponse> fetchTrackingOrder(
      {@required int orderId, @required int isSupplier}) async {
    final token = await _authRepo.getToken();
    final response = await _provider
        .get("/order/$orderId/logs?is_supplier=$isSupplier", headers: {
      HttpHeaders.authorizationHeader: 'Bearer $token',
      HttpHeaders.contentTypeHeader: 'application/json',
      'ADS-Key': AppConst.API_ADS_KEY,
    });
    return TrackingOrderResponse.fromJson(response);
  }

  Future<TrackingOrderResponse> fetchTrackingOrderNoAuth(
      {@required int orderId}) async {
    final token = await _authRepo.getToken();
    final response =
        await _provider.get("/order/noauth/logs/$orderId", headers: {
      HttpHeaders.authorizationHeader: 'Bearer $token',
      HttpHeaders.contentTypeHeader: 'application/json',
      'ADS-Key': AppConst.API_ADS_KEY,
    });
    return TrackingOrderResponse.fromJson(response);
  }

  Future<InvoiceByOrderResponse> fetchInvoiceByOrder(
      {@required int orderId}) async {
    final token = await _authRepo.getToken();
    final response = await _provider.get("/order/$orderId/invoice", headers: {
      HttpHeaders.authorizationHeader: 'Bearer $token',
      HttpHeaders.contentTypeHeader: 'application/json',
      'ADS-Key': AppConst.API_ADS_KEY,
    });
    return InvoiceByOrderResponse.fromJson(response);
  }

  Future<GeneralOrderResponse> orderWifiTelkom({
    @required int productId,
    @required int paymentId,
    @required int variantId,
    @required int totalPayment,
  }) async {
    final token = await _authRepo.getToken();
    final Map<String, dynamic> body = {
      "product_id": productId,
      "payment_id": paymentId,
      "variant_id": variantId,
      "verification_method": "manual",
      "total_payment": totalPayment,
    };

    final response = await _provider.post(
      "/telkom/buy",
      body: jsonEncode(body),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
        HttpHeaders.contentTypeHeader: 'application/json',
        'ADS-Key': AppConst.API_ADS_KEY,
      },
    );

    return GeneralOrderResponse.fromJson(response);
  }

  Future<GeneralOrderResponse> orderWifiTelkomNoAuth({
    @required int productId,
    @required int paymentId,
    @required int variantId,
    @required int totalPayment,
    @required String slug,
    @required String name,
    @required String phoneNumber,
    @required String email,
    @required String address,
    @required int subdistrictId,
  }) async {
    final token = await _authRepo.getToken();
    final Map<String, dynamic> body = {
      "product_id": productId,
      "payment_id": paymentId,
      "variant_id": variantId,
      "verification_method": "manual",
      "total_payment": totalPayment,
      "name": name,
      "phonenumber": phoneNumber,
      "email": email,
      "address": address,
      "subdistrict_id": subdistrictId,
    };

    debugPrint(body.toString());

    final response = await _provider.post(
      "/telkom/buy/noauth/$slug",
      body: jsonEncode(body),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
        HttpHeaders.contentTypeHeader: 'application/json',
        'ADS-Key': AppConst.API_ADS_KEY,
      },
    );

    return GeneralOrderResponse.fromJson(response);
  }

  Future<GeneralResponse> orderIndibizNet({
    @required int productId,
    @required int variantId,
    @required String name,
    @required String phonenumber1,
    @required String phonenumber2,
    @required String gender,
    @required String bornPlace,
    @required String bornDate,
    @required String occupation,
    @required String motherName,
    @required String subdistrict,
    @required String district,
    @required String addressDetails,
    @required String rtNumber,
    @required String rwNumber,
    @required String postalCode,
    @required String latLong,
    @required String identityNumber,
    @required dynamic identityPhoto,
    @required dynamic identityBytes,
    @required dynamic selfiePhoto,
    @required dynamic selfieBytes,
    @required dynamic businessPhoto,
    @required dynamic businessBytes,
    @required String businessName,
    @required String npwpNumber,
    @required String billsToPay,
    @required String billsTotal,
  }) async {
    if (await AppExt.hasConnection()) {
      final token = await _authRepo.getToken();
      FormData formDataGeneral;


      /* final byteKTP = identityBytes.cast<int>();
      final byteSelfie = identityBytes.cast<int>();
      final byteUsaha = identityBytes.cast<int>(); */

      Uint8List dataKTP = kIsWeb ? Uint8List.fromList(identityBytes.cast<int>())  : null;
      List<int> logoWebKTP = kIsWeb ? dataKTP : null;

      Uint8List dataSelfie = kIsWeb ? Uint8List.fromList(selfieBytes.cast<int>())   : null;
      List<int> logoWebSelfie = kIsWeb ? dataSelfie : null;

      Uint8List dataUsaha = kIsWeb ? Uint8List.fromList(businessBytes.cast<int>()) : null;
      List<int> logoWebUsaha = kIsWeb ? dataUsaha : null;

      formDataGeneral = new FormData.fromMap({
        "product_id": productId,
        "variant_id": variantId,
        "nama_pelanggan": name,
        "no_telp": phonenumber1,
        "no_telp_2": phonenumber2,
        "jenis_kelamin": gender,
        "tempat_lahir": bornPlace,
        "tanggal_lahir": bornDate,
        "pekerjaan": occupation,
        "nama_ibu_kandung": motherName,
        "kecamatan": subdistrict,
        "desa_kelurahan": district,
        "detail_alamat": addressDetails,
        "no_rt": rtNumber,
        "no_rw": rwNumber,
        "kode_pos": postalCode,
        "lat_long": latLong,
        "no_identitas": identityNumber,
        "foto_identitas": identityPhoto != null || identityBytes != null
            ? kIsWeb
                ? MultipartFile.fromBytes(logoWebKTP, filename: "ktp")
                : await MultipartFile.fromFile(identityPhoto, filename: "ktp")
            : null,
        "foto_selfie": selfiePhoto != null || selfieBytes != null
            ? kIsWeb
                ? MultipartFile.fromBytes(logoWebSelfie, filename: "selfie")
                : await MultipartFile.fromFile(selfiePhoto, filename: "selfie")
            : null,
        "foto_usaha": businessPhoto != null || businessBytes != null
            ? kIsWeb
                ? MultipartFile.fromBytes(logoWebUsaha, filename: "usaha")
                : await MultipartFile.fromFile(businessPhoto, filename: "usaha")
            : null,
        "nama_usaha": businessName,
        "npwp": npwpNumber,
        "tagihan": billsToPay,
        "total_tagihan": billsTotal,
      });

      debugPrint('body withAuth FORM: ${formDataGeneral.fields}');
      debugPrint('body withAuth FILES: ${formDataGeneral.files}');

      var response = await dio.post(
        "${AppConst.API_URL}/subsciption",
        data: formDataGeneral,
        options: Options(headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
          HttpHeaders.contentTypeHeader: 'application/json',
          'ADS-Key': AppConst.API_ADS_KEY,
        }),
      );

      debugPrint('response: ${response.data}');

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

  Future<GeneralResponse> orderIndibizNetNoAuth({
    @required String slug,
    @required int productId,
    @required int variantId,
    @required String name,
    @required String phonenumber1,
    @required String phonenumber2,
    @required String gender,
    @required String bornPlace,
    @required String bornDate,
    @required String occupation,
    @required String motherName,
    @required String subdistrict,
    @required String district,
    @required String addressDetails,
    @required String rtNumber,
    @required String rwNumber,
    @required String postalCode,
    @required String latLong,
    @required String identityNumber,
    @required dynamic identityBytes,
    @required dynamic selfieBytes,
    @required dynamic businessBytes,
    @required String businessName,
    @required String npwpNumber,
    @required String billsToPay,
    @required String billsTotal,
  }) async {
    if (await AppExt.hasConnection()) {
      FormData formDataGeneral;

      final byteKTP = identityBytes.cast<int>();
      final byteSelfie = identityBytes.cast<int>();
      final byteUsaha = identityBytes.cast<int>();

      formDataGeneral = new FormData.fromMap({
        "product_id": productId,
        "variant_id": variantId,
        "nama_pelanggan": name,
        "no_telp": phonenumber1,
        "no_telp_2": phonenumber2,
        "jenis_kelamin": gender,
        "tempat_lahir": bornPlace,
        "tanggal_lahir": bornDate,
        "pekerjaan": occupation,
        "nama_ibu_kandung": motherName,
        "kecamatan": subdistrict,
        "desa_kelurahan": district,
        "detail_alamat": addressDetails,
        "no_rt": rtNumber,
        "no_rw": rwNumber,
        "kode_pos": postalCode,
        "lat_long": latLong,
        "no_identitas": identityNumber,
        "foto_identitas": identityBytes != null
            ? MultipartFile.fromBytes(byteKTP, filename: "ktp")
            : null,
        "foto_selfie": selfieBytes != null
            ? MultipartFile.fromBytes(byteSelfie, filename: "selfie")
            : null,
        "foto_usaha": businessBytes != null
            ? MultipartFile.fromBytes(byteUsaha, filename: "usaha")
            : null,
        "nama_usaha": businessName,
        "npwp": npwpNumber,
        "tagihan": billsToPay,
        "total_tagihan": billsTotal,
      });

      debugPrint('body NoAuth FORM: ${formDataGeneral.fields}');
      debugPrint('body NoAuth FILES: ${formDataGeneral.files}');

      var response = await dio.post(
        "${AppConst.API_URL}/subsciption/noauth/$slug",
        data: formDataGeneral,
        options: Options(validateStatus: (value) => true, headers: {
          // HttpHeaders.authorizationHeader: 'Bearer $token',
          HttpHeaders.contentTypeHeader: 'application/json',
          'ADS-Key': AppConst.API_ADS_KEY,
        }),
      );

      debugPrint('response: ${response.data}');

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
}
