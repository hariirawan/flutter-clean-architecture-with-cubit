import 'dart:convert';

Breeds breedsFromJson(String str) => Breeds.fromJson(json.decode(str));
String breedsToJson(Breeds data) => json.encode(data.toJson());

class Breeds {
  final int currentPage;
  final List<Breed> data;
  final int lastPage;

  Breeds({
    required this.currentPage,
    required this.data,
    required this.lastPage,
  });

  factory Breeds.fromJson(Map<String, dynamic> json) => Breeds(
        currentPage: json["current_page"],
        data: List<Breed>.from(json["data"].map((x) => Breed.fromJson(x))),
        lastPage: json["last_page"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "last_page": lastPage,
      };
}

class Breed {
  final String breed;
  final String country;
  final String origin;
  final String coat;
  final String pattern;

  Breed({
    required this.breed,
    required this.country,
    required this.origin,
    required this.coat,
    required this.pattern,
  });

  factory Breed.fromJson(Map<String, dynamic> json) => Breed(
        breed: json["breed"],
        country: json["country"],
        origin: json["origin"],
        coat: json["coat"],
        pattern: json["pattern"],
      );

  Map<String, dynamic> toJson() => {
        "breed": breed,
        "country": country,
        "origin": origin,
        "coat": coat,
        "pattern": pattern,
      };
}
