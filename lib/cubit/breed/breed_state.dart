part of 'breed_cubit.dart';

abstract class BreedState {}

class BreedInitial extends BreedState {}

class BreedLoading extends BreedState {
  final Breeds oldBreeds;

  final bool isFirstFetch;

  BreedLoading(this.oldBreeds, {this.isFirstFetch = false});
}

class BreedLoaded extends BreedState {
  final Breeds breeds;

  BreedLoaded(this.breeds);
}
