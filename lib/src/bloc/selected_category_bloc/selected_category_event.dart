import 'package:equatable/equatable.dart';

abstract class SelectedCategoryEvent extends Equatable {
  const SelectedCategoryEvent();

  @override
  List<Object> get props => [];
}

class GetSelectedCategoryList extends SelectedCategoryEvent {
  String? category;
  GetSelectedCategoryList(this.category);
}
