import 'dart:io';

import 'package:dio/dio.dart';
import 'package:marketplace/api/api.dart';
import 'package:marketplace/api/api_provider.dart';
import 'package:marketplace/data/models/new_models/search_kecamatan.dart';
import 'package:marketplace/utils/constants.dart' as AppConst;
import 'package:marketplace/utils/extensions.dart' as AppExt;

class KecamatanRepository {
  final ApiProvider _provider = ApiProvider();
  final String _baseUrl = AppConst.API_URL;
  final String _adsKey = AppConst.API_ADS_KEY;

  Dio dio = new Dio();

  Future<SearchKecamatan> fetchKecamatan({String keyword}) async {
    if (await AppExt.hasConnection()) {
      final formSearch = new FormData.fromMap({
        "keyword": keyword,
      });
      var response = await dio.post(
        "$_baseUrl/locations/search/subdistrict",
        data: formSearch,
        options: Options(
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            'ADS-Key': _adsKey
          },
        ),
      );

      if (response.statusCode == 200) {
        return SearchKecamatan.fromJson(response.data);
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
