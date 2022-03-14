import 'package:equatable/equatable.dart';

abstract class DetailedFoodEvent extends Equatable {
  const DetailedFoodEvent();

  @override
  List<Object> get props => [];
}

class GetDetailedFoodData extends DetailedFoodEvent {
  String? selectedId;
  GetDetailedFoodData(this.selectedId);
}
