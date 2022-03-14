// To parse this JSON data, do
//
//     final SelectedDrinkCategoriesModel = SelectedDrinkCategoriesModelFromJson(jsonString);

import 'dart:convert';

String? error;
SelectedDrinkCategoriesModel selectedDrinkCategoriesModelFromJson(String str) =>
    SelectedDrinkCategoriesModel.fromJson(json.decode(str));

String selectedDrinkCategoriesModelToJson(SelectedDrinkCategoriesModel data) =>
    json.encode(data.toJson());

class SelectedDrinkCategoriesModel {
  SelectedDrinkCategoriesModel({
    required this.drinks,
  });

  late final List<Drink> drinks;

  SelectedDrinkCategoriesModel.withError(String errorMessage) {
    error = errorMessage;
  }

  factory SelectedDrinkCategoriesModel.fromJson(Map<String, dynamic> json) =>
      SelectedDrinkCategoriesModel(
        drinks: List<Drink>.from(json["drinks"].map((x) => Drink.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "drinks": List<dynamic>.from(drinks.map((x) => x.toJson())),
      };
}

class Drink {
  Drink({
    required this.strDrink,
    required this.strDrinkThumb,
    required this.idDrink,
  });

  final String strDrink;
  final String strDrinkThumb;
  final String idDrink;

  factory Drink.fromJson(Map<String, dynamic> json) => Drink(
        strDrink: json["strDrink"],
        strDrinkThumb: json["strDrinkThumb"],
        idDrink: json["idDrink"],
      );

  Map<String, dynamic> toJson() => {
        "strDrink": strDrink,
        "strDrinkThumb": strDrinkThumb,
        "idDrink": idDrink,
      };
}
