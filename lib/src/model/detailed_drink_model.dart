// To parse this JSON data, do
//
//     final detailedDrinkModel = detailedDrinkModelFromJson(jsonString);

import 'dart:convert';

String? error;
DetailedDrinkModel detailedDrinkModelFromJson(String str) =>
    DetailedDrinkModel.fromJson(json.decode(str));

String detailedDrinkModelToJson(DetailedDrinkModel data) =>
    json.encode(data.toJson());

class DetailedDrinkModel {
  DetailedDrinkModel({
    required this.drinks,
  });

  late final List<Map<String, String>> drinks;

  DetailedDrinkModel.withError(String errorMessage) {
    error = errorMessage;
  }

  factory DetailedDrinkModel.fromJson(Map<String, dynamic> json) =>
      DetailedDrinkModel(
        drinks: List<Map<String, String>>.from(json["drinks"].map((x) =>
            Map.from(x).map(
                (k, v) => MapEntry<String, String>(k, v == null ? null : v)))),
      );

  Map<String, dynamic> toJson() => {
        "drinks": List<dynamic>.from(drinks.map((x) => Map.from(x).map(
            (k, v) => MapEntry<String, dynamic>(k, v == null ? null : v)))),
      };
}
