// To parse this JSON data, do
//
//     final drinkCategoriesModel = drinkCategoriesModelFromJson(jsonString);

import 'dart:convert';

String? error;
DrinkCategoriesModel drinkCategoriesModelFromJson(String str) =>
    DrinkCategoriesModel.fromJson(json.decode(str));

String drinkCategoriesModelToJson(DrinkCategoriesModel data) =>
    json.encode(data.toJson());

class DrinkCategoriesModel {
  DrinkCategoriesModel({
    required this.drinks,
  });

  List<Drink>? drinks;

  DrinkCategoriesModel.withError(String errorMessage) {
    error = errorMessage;
  }

  factory DrinkCategoriesModel.fromJson(Map<String, dynamic> json) =>
      DrinkCategoriesModel(
        drinks: List<Drink>.from(json["drinks"].map((x) => Drink.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "drinks": List<dynamic>.from(drinks!.map((x) => x.toJson())),
      };
}

class Drink {
  Drink({
    required this.strCategory,
  });

  final String strCategory;

  factory Drink.fromJson(Map<String, dynamic> json) => Drink(
        strCategory: json["strCategory"],
      );

  Map<String, dynamic> toJson() => {
        "strCategory": strCategory,
      };
}
