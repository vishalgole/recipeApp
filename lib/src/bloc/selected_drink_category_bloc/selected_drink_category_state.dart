import 'package:equatable/equatable.dart';
import 'package:recipe_app/src/model/selected_drink_category_model.dart';

abstract class SelectedDrinkCategoryState extends Equatable {
  const SelectedDrinkCategoryState();
  @override
  List<Object?> get props => [];
}

class SelectedDrinkCategoryInitial extends SelectedDrinkCategoryState {}

class SelectedDrinkCategoryLoading extends SelectedDrinkCategoryState {}

class SelectedDrinkCategoryLoaded extends SelectedDrinkCategoryState {
  final SelectedDrinkCategoriesModel categoriesModel;
  const SelectedDrinkCategoryLoaded(this.categoriesModel);
}

class SelectedDrinkCategoryError extends SelectedDrinkCategoryState {
  final String? message;
  const SelectedDrinkCategoryError(this.message);
}
