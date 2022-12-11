// To parse this JSON data, do
//
//     final arusKas = arusKasFromJson(jsonString);

import 'dart:convert';

List<ArusKas> arusKasFromJson(String str) =>
    List<ArusKas>.from(json.decode(str).map((x) => ArusKas.fromJson(x)));

String arusKasToJson(List<ArusKas> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ArusKas {
  ArusKas({
    required this.model,
    required this.pk,
    required this.fields,
  });

  String model;
  int pk;
  Fields fields;

  factory ArusKas.fromJson(Map<String, dynamic> json) => ArusKas(
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
    required this.nominal,
    required this.keterangan,
    required this.tipe,
    required this.createdAt,
  });

  int nominal;
  String keterangan;
  int tipe;
  DateTime createdAt;

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        nominal: json["nominal"],
        keterangan: json["keterangan"],
        tipe: json["tipe"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "nominal": nominal,
        "keterangan": keterangan,
        "tipe": tipe,
        "created_at": createdAt.toIso8601String(),
      };
}
