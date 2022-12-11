import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:saku_in/dompet/model/aruskas.dart';

Future<List<ArusKas>> fetchArusKas() async {
  var url =
      Uri.parse("https://saku-in.up.railway.app/dompet/arus_kas/arus_kas_json");

  var response = await http.get(
    url,
    headers: {
      "Access-Control-Allow-Origin": "*",
      "Content-Type": "application/json"
    },
  );
  var data = jsonDecode(utf8.decode(response.bodyBytes));

  List<ArusKas> aruskas = [];
  for (var d in data) {
    if (d != null) {
      aruskas.add(ArusKas.fromJson(d));
    }
  }
  print(aruskas);

  return aruskas;
}
