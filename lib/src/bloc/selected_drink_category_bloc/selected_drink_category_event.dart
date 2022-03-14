import 'package:equatable/equatable.dart';

abstract class SelectedDrinkCategoryEvent extends Equatable {
  const SelectedDrinkCategoryEvent();
  @override
  List<Object> get props => [];
}

class GetSelectedDrinkCategoryList extends SelectedDrinkCategoryEvent {
  String? category;
  GetSelectedDrinkCategoryList(this.category);
}
