// To parse this JSON data, do
//
//     final forum = forumFromJson(jsonString);

import 'dart:convert';

List<Forum> forumFromJson(String str) => List<Forum>.from(json.decode(str).map((x) => Forum.fromJson(x)));

String forumToJson(List<Forum> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Forum {
    Forum({
        required this.model,
        required this.pk,
        required this.fields,
    });

    String model;
    int pk;
    Fields fields;

    factory Forum.fromJson(Map<String, dynamic> json) => Forum(
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
        required this.judul,
        required this.isi,
        required this.tanggal,
        required this.komenPertama,
    });

    String judul;
    String isi;
    DateTime tanggal;
    String komenPertama;

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        judul: json["judul"],
        isi: json["isi"],
        tanggal: DateTime.parse(json["tanggal"]),
        komenPertama: json["komenPertama"],
    );

    Map<String, dynamic> toJson() => {
        "judul": judul,
        "isi": isi,
        "tanggal": tanggal.toIso8601String(),
        "komenPertama": komenPertama,
    };
}
