import 'package:http/http.dart' as http;

class BreedService {
  final baseUrl = "https://catfact.ninja/breeds";

  Future<String> fetchBreeds(int page) async {
    try {
      final response =
          await http.get(Uri.parse("$baseUrl?page=$page&limit=10"));
      return response.body;
    } catch (e) {
      return e.toString();
    }
  }
}
