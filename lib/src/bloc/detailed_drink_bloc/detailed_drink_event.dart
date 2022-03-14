import 'package:equatable/equatable.dart';

abstract class DetailedDrinkEvent extends Equatable {
  const DetailedDrinkEvent();
  @override
  List<Object> get props => [];
}

class GetDetailedDrinkData extends DetailedDrinkEvent {
  String? id;
  GetDetailedDrinkData(this.id);
}
