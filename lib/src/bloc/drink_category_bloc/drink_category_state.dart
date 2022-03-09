import 'package:equatable/equatable.dart';
import 'package:recipe_app/src/model/drink_category_model.dart';

abstract class DrinkCategoryState extends Equatable {
  const DrinkCategoryState();

  @override
  List<Object?> get props => [];
}

class DrinkCategoryStateInitial extends DrinkCategoryState {}

class DrinkCategoryStateLoading extends DrinkCategoryState {}

class DrinkCategoryStateLLoaded extends DrinkCategoryState {
  final DrinkCategoriesModel drinkCatModel;
  const DrinkCategoryStateLLoaded(this.drinkCatModel);
}

class DrinkCategoryStateError extends DrinkCategoryState {
  final String? message;
  const DrinkCategoryStateError(this.message);
}
