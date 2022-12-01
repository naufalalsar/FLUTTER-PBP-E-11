import 'package:saku_in/berita/berita_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<Berita>> fetchBerita() async {
  var url = Uri.parse('https://saku-in.up.railway.app/berita/json/');
  var response = await http.get(
    url,
    headers: {
      "Access-Control-Allow-Origin": "*",
      "Content-Type": "application/json",
    },
  );

  // melakukan decode response menjadi bentuk json
  var data = jsonDecode(utf8.decode(response.bodyBytes));

  // melakukan konversi data json menjadi object MyWatchList
  List<Berita> listWatchList = [];
  for (var d in data) {
    if (d != null) {
      listWatchList.add(Berita.fromJson(d));
    }
  }

  return listWatchList;
}
