import 'package:equatable/equatable.dart';

abstract class FoodCategoryEvent extends Equatable {
  const FoodCategoryEvent();

  @override
  List<Object> get props => [];
}

class GetFoodCategoryList extends FoodCategoryEvent {}
