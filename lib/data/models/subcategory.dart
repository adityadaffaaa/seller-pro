import 'package:flutter/material.dart';

class CategorySubResponse {
  CategorySubResponse({
    @required this.data,
    @required this.message,
  });

  final CategorySub data;
  final String message;

  factory CategorySubResponse.fromJson(Map<String, dynamic> json) =>
      CategorySubResponse(
        data: json["data"] != null ? CategorySub.fromJson(json["data"]) : null,
        message: json["message"],
      );
}

class CategorySub {
  CategorySub({
    this.id,
    this.name,
    this.slug,
    this.icon,
    this.subcategories,
  });

  final int id;
  final String name;
  final String slug;
  final String icon;
  final List<Subcategories> subcategories;

  factory CategorySub.fromJson(Map<String, dynamic> json) => CategorySub(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        icon: json["icon"],
        subcategories: json.containsKey('subcategories') == null
            ? null
            : json["subcategories"] == null
                ? []
                : json["subcategories"].length == 0
                    ? []
                    : List<Subcategories>.from(json["subcategories"]
                        .map((x) => Subcategories.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "icon": icon,
        "Subcategories": subcategories,
      };
}

class Subcategories {
  final int id;
  final String name;
  final String slug;
  final String icon;

  Subcategories({
    this.id,
    this.name,
    this.slug,
    this.icon,
  });

  factory Subcategories.fromJson(Map<String, dynamic> json) => Subcategories(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        icon: json["icon"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "icon": icon,
      };
}
