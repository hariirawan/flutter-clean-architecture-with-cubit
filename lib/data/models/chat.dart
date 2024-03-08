import 'dart:convert';

Chat chatFromJson(String str) => Chat.fromJson(json.decode(str));

String chatToJson(Chat data) => json.encode(data.toJson());

class Chat {
  final String fact;
  final int? length;
  final DateTime? createdAt;

  Chat({required this.fact, this.length, this.createdAt});

  factory Chat.fromJson(Map<String, dynamic> json) => Chat(
      fact: json["fact"] ?? "",
      length: json["length"] ?? 0,
      createdAt: json["created_at"] ?? DateTime.now());

  Map<String, dynamic> toJson() =>
      {"fact": fact, "length": length, "cretaed_at": createdAt};
}
