import 'package:flutter/foundation.dart';

class GeneralRegionResponse {
  GeneralRegionResponse({
    @required this.status,
    @required this.data,
  });

  final String status;
  final List<Region> data;

  factory GeneralRegionResponse.fromJson(Map<String, dynamic> json) =>
      GeneralRegionResponse(
        status: json["status"],
        data: json["data"].length == 0
            ? []
            : List<Region>.from(json["data"].map((x) => Region.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {"status": status, "data": data};
}

class GeneralLocationFilter {
  GeneralLocationFilter({
    @required this.status,
    @required this.data,
  });

  final String status;
  final LocationFilter data;

  factory GeneralLocationFilter.fromJson(Map<String, dynamic> json) =>
      GeneralLocationFilter(
        status: json["status"],
        data: LocationFilter.fromJson(json["data"])
      );
}

class LocationFilter {
  LocationFilter({
    @required this.city,
    @required this.province,
  });

  final List<City> city;
  final List<Province> province;

  factory LocationFilter.fromJson(Map<String, dynamic> json) =>
      LocationFilter(
        city: json["city"] == null
            ? []
            : List<City>.from(json["city"].map((x) => City.fromJson(x))),
        province: json["province"] == null
            ? []
            : List<Province>.from(json["province"].map((x) => Province.fromJson(x))),
      );
}


class Region {
  Region({
    @required this.id,
    @required this.name,
  });

  final int id;
  final String name;

  factory Region.fromJson(Map<String, dynamic> json) => Region(
        id: json["id"],
        name: json["name"],
      );
}

class Province {
  Province({
    @required this.id,
    @required this.name,
  });

  final int id;
  final String name;

  factory Province.fromJson(Map<String, dynamic> json) => Province(
        id: json["id"],
        name: json["name"],
      );
}

class City {
  City({
    @required this.id,
    @required this.name,
  });

  final int id;
  final String name;

  factory City.fromJson(Map<String, dynamic> json) => City(
        id: json["id"],
        name: json["name"],
      );
}

class Subdistrict {
  Subdistrict({
    @required this.id,
    @required this.name,
  });

  final int id;
  final String name;

  factory Subdistrict.fromJson(Map<String, dynamic> json) => Subdistrict(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class GoogleMapsUrlResponse {
    GoogleMapsUrl data;

    GoogleMapsUrlResponse({
        @required this.data,
    });

    factory GoogleMapsUrlResponse.fromJson(Map<String, dynamic> json) => GoogleMapsUrlResponse(
        data: GoogleMapsUrl.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "data": data.toJson(),
    };
}

class GoogleMapsUrl {
    String url;

    GoogleMapsUrl({
        @required this.url,
    });

    factory GoogleMapsUrl.fromJson(Map<String, dynamic> json) => GoogleMapsUrl(
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "url": url,
    };
}
