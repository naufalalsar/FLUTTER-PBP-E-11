// To parse this JSON data, do
//
//     final exchange = exchangeFromJson(jsonString);

import 'dart:convert';

List<Exchange> exchangeFromJson(String str) =>
    List<Exchange>.from(json.decode(str).map((x) => Exchange.fromJson(x)));

String exchangeToJson(List<Exchange> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Exchange {
  Exchange({
    required this.model,
    required this.pk,
    required this.fields,
  });

  Model model;
  int pk;
  Fields fields;

  factory Exchange.fromJson(Map<String, dynamic> json) => Exchange(
        model: modelValues.map[json["model"]]!,
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
      );

  Map<String, dynamic> toJson() => {
        "model": modelValues.reverse[model],
        "pk": pk,
        "fields": fields.toJson(),
      };
}

class Fields {
  Fields({
    required this.sourceCurrency,
    required this.targetCurrency,
    required this.amount,
    required this.change1D,
    required this.change1W,
    required this.change1M,
    required this.change1Y,
    required this.change1DColor,
    required this.change1WColor,
    required this.change1MColor,
    required this.change1YColor,
    required this.lastUpdated,
  });

  Currency sourceCurrency;
  Currency targetCurrency;
  String amount;
  String change1D;
  String change1W;
  String change1M;
  String change1Y;
  ChangeColor change1DColor;
  ChangeColor change1WColor;
  ChangeColor change1MColor;
  ChangeColor change1YColor;
  DateTime lastUpdated;

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        sourceCurrency: currencyValues.map[json["source_currency"].toString()]!,
        targetCurrency: currencyValues.map[json["target_currency"].toString()]!,
        amount: json["amount"],
        change1D: json["change_1d"],
        change1W: json["change_1w"],
        change1M: json["change_1m"],
        change1Y: json["change_1y"],
        change1DColor: change1ColorValues.map[json["change_1d_color"]]!,
        change1WColor: change1ColorValues.map[json["change_1w_color"]]!,
        change1MColor: change1ColorValues.map[json["change_1m_color"]]!,
        change1YColor: change1ColorValues.map[json["change_1y_color"]]!,
        lastUpdated: DateTime.parse(json["last_updated"]),
      );

  Map<String, dynamic> toJson() => {
        "source_currency": currencyValues.reverse[sourceCurrency],
        "target_currency": currencyValues.reverse[targetCurrency],
        "amount": amount,
        "change_1d": change1D,
        "change_1w": change1W,
        "change_1m": change1M,
        "change_1y": change1Y,
        "change_1d_color": change1ColorValues.reverse[change1DColor],
        "change_1w_color": change1ColorValues.reverse[change1WColor],
        "change_1m_color": change1ColorValues.reverse[change1MColor],
        "change_1y_color": change1ColorValues.reverse[change1YColor],
        "last_updated":
            "${lastUpdated.year.toString().padLeft(4, '0')}-${lastUpdated.month.toString().padLeft(2, '0')}-${lastUpdated.day.toString().padLeft(2, '0')}",
      };
}

class Currency {
  Currency({
    required this.name,
    required this.code,
  });

  String name;
  String code;
}

enum ChangeColor { RED_600, GREEN_400 }

final change1ColorValues = EnumValues(
    {"green-400": ChangeColor.GREEN_400, "red-600": ChangeColor.RED_600});

enum Model { KURS_EXCHANGE }

final modelValues = EnumValues({"kurs.exchange": Model.KURS_EXCHANGE});

final currencyValues = EnumValues<Currency>({
  "1": Currency(code: "ARS", name: "Argentine Peso"),
  "2": Currency(code: "AUD", name: "Australian Dollar"),
  "3": Currency(code: "BGN", name: "Bulgarian Lev"),
  "4": Currency(code: "BRL", name: "Brazilian Real"),
  "5": Currency(code: "CNY", name: "Chinese Yuan"),
  "6": Currency(code: "EUR", name: "Euro"),
  "7": Currency(code: "INR", name: "Indian Rupee"),
  "8": Currency(code: "IDR", name: "Indonesian Rupiah"),
  "9": Currency(code: "JPY", name: "Japanese Yen"),
  "10": Currency(code: "KRW", name: "Korean Won"),
  "11": Currency(code: "MXN", name: "Mexican Peso"),
  "12": Currency(code: "RUB", name: "Russian Ruble"),
  "13": Currency(code: "SAR", name: "Saudi Riyal"),
  "14": Currency(code: "ZAR", name: "South African Rand"),
  "15": Currency(code: "TRY", name: "Turkish Lira"),
  "16": Currency(code: "GBP", name: "British Pound"),
  "17": Currency(code: "USD", name: "United States Dollar"),
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    return reverseMap;
  }
}
