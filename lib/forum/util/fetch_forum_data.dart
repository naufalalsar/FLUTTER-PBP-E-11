import 'package:saku_in/forum/model/forum.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<Forum>> fetchToDo() async {
  var url = Uri.parse('https://saku-in.up.railway.app/forum/jsonforum/');
  var response = await http.get(
    url,
    headers: {
      "Access-Control-Allow-Origin": "*",
      "Content-Type": "application/json",
    },
  );

  var data = jsonDecode(utf8.decode(response.bodyBytes));

  // melakukan konversi data json menjadi object ToDo
  List<Forum> listForum = [];
  for (var d in data) {
    if (d != null) {
      listForum.add(Forum.fromJson(d));
    }
  }

  return listForum;
}

void deleteForum(int id) async {
  final response = await http.post(
    Uri.parse('https://saku-in.up.railway.app/forum/deleteforum/$id'),
  );
}
