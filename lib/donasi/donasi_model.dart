// To parse this JSON data, do
//
//     final myWatchList = myWatchListFromJson(jsonString);

import 'dart:convert';

List<Donasi> donasiFromJson(String str) =>
    List<Donasi>.from(json.decode(str).map((x) => Donasi.fromJson(x)));

String donasiToJson(List<Donasi> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Donasi {
  Donasi({
    required this.model,
    required this.pk,
    required this.fields,
  });

  String model;
  int pk;
  Fields fields;

  factory Donasi.fromJson(Map<String, dynamic> json) => Donasi(
        model: json["model"],
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
      );

  Map<String, dynamic> toJson() => {
        "model": model,
        "pk": pk,
        "fields": fields.toJson(),
      };
}

class Fields {
  Fields({
    this.user = 1,
    required this.title,
    required this.description,
    required this.target,
    required this.achieved,
    required this.isOngoing,
  });

  int user;
  String title;
  String description;
  int target;
  int achieved;
  bool isOngoing;

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        user: json["user"],
        title: json["title"],
        description: json["description"],
        target: json["target"],
        achieved: json["achieved"],
        isOngoing: json["is_ongoing"],
      );

  Map<String, dynamic> toJson() => {
        "user": user,
        "title": title,
        "description": description,
        "target": target,
        "achieved": achieved,
        "is_ongoing": isOngoing,
      };
}
