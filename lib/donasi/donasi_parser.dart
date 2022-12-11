import 'package:saku_in/donasi/donasi_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<Donasi>> fetchDonasi() async {
  var url = Uri.parse('https://saku-in.up.railway.app/donation/json/');
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
  List<Donasi> listDonasi = [];
  for (var d in data) {
    if (d != null) {
      listDonasi.add(Donasi.fromJson(d));
    }
  }

  return listDonasi;
}

createDonasi(title, description, target) async {
  final response = await http.post(
      Uri.parse(
          'https://saku-in.up.railway.app/donation/add-donation-flutter/'),
      body: {
        'title': title,
        'description': description,
        'target': target,
      });
  return response;
}
