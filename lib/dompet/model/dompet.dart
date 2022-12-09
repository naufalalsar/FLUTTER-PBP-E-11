// To parse this JSON data, do
//
//     final dompet = dompetFromJson(jsonString);

import 'dart:convert';

Dompet dompetFromJson(String str) => Dompet.fromJson(json.decode(str));

String dompetToJson(Dompet data) => json.encode(data.toJson());

class Dompet {
  Dompet({
    required this.saldo,
    required this.pemasukan,
    required this.pengeluaran,
    required this.total,
    required this.isPositive,
  });

  int saldo;
  int pemasukan;
  int pengeluaran;
  int total;
  bool isPositive;

  factory Dompet.fromJson(Map<String, dynamic> json) => Dompet(
        saldo: json["saldo"],
        pemasukan: json["pemasukan"],
        pengeluaran: json["pengeluaran"],
        total: json["total"],
        isPositive: json["is_positive"],
      );

  Map<String, dynamic> toJson() => {
        "saldo": saldo,
        "pemasukan": pemasukan,
        "pengeluaran": pengeluaran,
        "total": total,
        "is_positive": isPositive,
      };
}
