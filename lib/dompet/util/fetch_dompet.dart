import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:saku_in/dompet/model/dompet.dart';

Future<Dompet> fetchDompet() async {
  var url = Uri.parse("https://saku-in.up.railway.app/dompet/dompet_json/json");

  var response = await http.get(
    url,
    headers: {
      "Access-Control-Allow-Origin": "*",
      "Content-Type": "application/json"
    },
  );
  var data = jsonDecode(utf8.decode(response.bodyBytes));

  Dompet dompet = Dompet.fromJson(data);
  print(dompet);

  return dompet;
}
