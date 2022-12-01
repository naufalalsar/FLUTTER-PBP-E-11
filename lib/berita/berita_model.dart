// To parse this JSON data, do
//
//     final berita = beritaFromJson(jsonString);

import 'dart:convert';

List<Berita> beritaFromJson(String str) => List<Berita>.from(json.decode(str).map((x) => Berita.fromJson(x)));

String beritaToJson(List<Berita> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Berita {
    Berita({
        required this.model,
        required this.pk,
        required this.fields,
    });

    String model;
    int pk;
    Fields fields;

    factory Berita.fromJson(Map<String, dynamic> json) => Berita(
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
        required this.user,
        required this.title,
        required this.content,
        required this.category,
        required this.date,
        required this.writer,
        required this.source,
    });

    int user;
    String title;
    String content;
    String category;
    DateTime date;
    String writer;
    String source;

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        user: json["user"],
        title: json["title"],
        content: json["content"],
        category: json["category"],
        date: DateTime.parse(json["date"]),
        writer: json["writer"],
        source: json["source"],
    );

    Map<String, dynamic> toJson() => {
        "user": user,
        "title": title,
        "content": content,
        "category": category,
        "date": date.toIso8601String(),
        "writer": writer,
        "source": source,
    };
}
