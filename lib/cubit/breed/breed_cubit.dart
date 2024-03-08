import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cat_facts/data/models/breeds.dart';
import 'package:cat_facts/data/repositories/breed_repository.dart';

part 'breed_state.dart';

class BreedCubit extends Cubit<BreedState> {
  final BreedRepository repository;

  BreedCubit(this.repository) : super(BreedInitial());

  int page = 1;
  int lastPage = 1;

  void loadBreeds() {
    if (state is BreedLoading) return;

    final currentState = state;

    var oldBreeds = Breeds(currentPage: 1, data: [], lastPage: 1);

    if (currentState is BreedLoaded) {
      oldBreeds = currentState.breeds;
    }

    emit(BreedLoading(oldBreeds, isFirstFetch: page == 1));

    repository.fetchBreeds(page).then((value) {
      page += 1;
      lastPage = value.lastPage;

      final breeds = (state as BreedLoading).oldBreeds;
      breeds.data.addAll(value.data);
      emit(BreedLoaded(breeds));
    });
  }
}
