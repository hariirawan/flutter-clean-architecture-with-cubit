import 'package:http/http.dart' as http;

class ChatService {
  final baseUrl = "https://catfact.ninja/fact";

  Future<String> fetchRandomFact(dynamic params) async {
    Uri uri;

    if (isNumeric(params)) {
      uri = Uri.parse("$baseUrl?max_length=$params");
    } else {
      uri = Uri.parse(baseUrl);
    }

    final response = await http.get(uri);

    return response.body;
  }

  bool isNumeric(String str) {
    RegExp numeric = RegExp(r'^-?[0-9]+$');
    return numeric.hasMatch(str);
  }
}
