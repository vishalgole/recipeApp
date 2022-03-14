import 'package:equatable/equatable.dart';
import 'package:recipe_app/src/model/detailed_food_model.dart';

abstract class DetailedFoodState extends Equatable {
  const DetailedFoodState();

  @override
  List<Object> get props => [];
}

class DetailedFoodStateInitial extends DetailedFoodState {}

class DetailedFoodStateLoading extends DetailedFoodState {}

class DetailedFoodStateLoaded extends DetailedFoodState {
  final DetailedFoodModel foodModel;
  const DetailedFoodStateLoaded(this.foodModel);
}

class DetailedFoodStateError extends DetailedFoodState {
  String? message;
  DetailedFoodStateError(this.message);
}
