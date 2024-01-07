part of 'carsoul_cubit.dart';

@immutable
abstract class CarsoulState {}

class CarsoulInitial extends CarsoulState {
  CarsoulInitial();
}

class CarsoulLoading extends CarsoulState {
  CarsoulLoading();
}

class CarsoulLoaded extends CarsoulState {
  late List<Ad> adsLists;
  CarsoulLoaded(this.adsLists);
}

class CarsoulError extends CarsoulState {
  CarsoulError();
}