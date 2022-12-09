import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:saku_in/kurs/model/exchange.dart';

Future<List<Exchange>> fetchExchange() async {
  var url = Uri.parse("https://saku-in.up.railway.app/kurs/json/IDR");

  var response = await http.get(
    url,
    headers: {
      "Access-Control-Allow-Origin": "*",
      "Content-Type": "application/json"
    },
  );
  var data = jsonDecode(utf8.decode(response.bodyBytes));

  List<Exchange> exchange = [];
  for (var d in data) {
    if (d != null) {
      exchange.add(Exchange.fromJson(d));
    }
  }

  return exchange;
}
