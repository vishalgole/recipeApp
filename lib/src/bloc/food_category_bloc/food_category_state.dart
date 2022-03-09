import 'package:equatable/equatable.dart';
import 'package:recipe_app/src/model/food_category_model.dart';

abstract class FoodCategoryState extends Equatable {
  const FoodCategoryState();

  @override
  List<Object?> get props => [];
}

class FoodCategoryStateIniitial extends FoodCategoryState {}

class FoodCategoryStateLoading extends FoodCategoryState {}

class FoodCategoryStateLoaded extends FoodCategoryState {
  final FoodCategoriesModel foodCatModel;
  const FoodCategoryStateLoaded(this.foodCatModel);
}

class FoodCategoryStateError extends FoodCategoryState {
  final String? message;
  const FoodCategoryStateError(this.message);
}
