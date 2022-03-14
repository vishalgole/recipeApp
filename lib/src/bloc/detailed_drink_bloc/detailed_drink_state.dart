import 'package:equatable/equatable.dart';
import 'package:recipe_app/src/model/detailed_drink_model.dart';

abstract class DetailedDrinkState extends Equatable {
  const DetailedDrinkState();

  @override
  List<Object?> get props => [];
}

class DetailedDrinkStateInitial extends DetailedDrinkState {}

class DetailedDrinkStateLoading extends DetailedDrinkState {}

class DetailedDrinkStateLoaded extends DetailedDrinkState {
  final DetailedDrinkModel drinkModel;
  const DetailedDrinkStateLoaded(this.drinkModel);
}

class DetailedDrinkStateError extends DetailedDrinkState {
  final String? messsage;
  const DetailedDrinkStateError(this.messsage);
}
