import 'package:equatable/equatable.dart';
import 'package:recipe_app/src/model/selected_category_model.dart';

abstract class SelectedCategoryState extends Equatable {
  const SelectedCategoryState();
  @override
  List<Object?> get props => [];
}

class SelectedCategoryStateInitial extends SelectedCategoryState {}

class SelectedCategoryStateLoading extends SelectedCategoryState {}

class SelectedCategoryStateLoaded extends SelectedCategoryState {
  final SelectedCategoriesModel categoriesModel;
  const SelectedCategoryStateLoaded(this.categoriesModel);
}

class SelectedCategoryStateError extends SelectedCategoryState {
  final String? message;
  const SelectedCategoryStateError(this.message);
}
