import 'package:cat_facts/data/models/breeds.dart';
import 'package:cat_facts/data/services/breed_service.dart';

class BreedRepository {
  final BreedService service;

  BreedRepository(this.service);

  Future<Breeds> fetchBreeds(int page) async {
    final response = await service.fetchBreeds(page);

    return breedsFromJson(response);
  }
}
