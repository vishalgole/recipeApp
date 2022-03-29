// To parse this JSON data, do
//
//     final detailedFoodModel = detailedFoodModelFromJson(jsonString);

import 'dart:convert';

String? error;
DetailedFoodModel detailedFoodModelFromJson(String str) =>
    DetailedFoodModel.fromJson(json.decode(str));

String detailedFoodModelToJson(DetailedFoodModel data) =>
    json.encode(data.toJson());

class DetailedFoodModel {
  DetailedFoodModel({
    required this.meals,
  });

  late final List<Map<String, String>> meals;

  DetailedFoodModel.withError(String? message) {
    error = message;
  }

  factory DetailedFoodModel.fromJson(Map<String, dynamic> json) =>
      DetailedFoodModel(
        meals: List<Map<String, String>>.from(json["meals"].map((x) =>
            Map.from(x).map((k, v) => MapEntry<String, String>(k, v ?? null)))),
      );

  Map<String, dynamic> toJson() => {
        "meals": List<dynamic>.from(meals.map((x) => Map.from(x)
            .map((k, v) => MapEntry<String, dynamic>(k, v ?? null)))),
      };
}
