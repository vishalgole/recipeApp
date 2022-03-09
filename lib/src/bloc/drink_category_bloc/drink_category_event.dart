import 'package:equatable/equatable.dart';

abstract class DrinkCategoryEvent extends Equatable {
  const DrinkCategoryEvent();

  @override
  List<Object> get props => [];
}

class GetDrinkCategoryList extends DrinkCategoryEvent {}
