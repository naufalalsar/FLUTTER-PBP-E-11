import 'package:flutter/material.dart';
import 'package:saku_in/drawer.dart';
import 'package:saku_in/forum/util/fetch_forum_data.dart';
import 'package:saku_in/forum/model/forum.dart';
import 'package:saku_in/forum/page/forum_page.dart';

class ForumDetail extends StatelessWidget {
  final  Forum data;
  const ForumDetail ({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail'),
      ),
      backgroundColor: const Color(0xff03fca1),
      drawer: TheSideBar(),
      body: Container(
        margin: new EdgeInsets.symmetric(vertical: 20.0),
        child: Column(
          children: [
            Center(
              child: Text(data.fields.judul,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32)),
            ),
            Row(
              children: [
                Text("Tanggal Pembuatan : ",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text(data.fields.tanggal.toString(),
                    style:
                        TextStyle(fontWeight: FontWeight.normal, fontSize: 16)),
              ],
            ),
            Row(
              children: [
                Text("Isi : ",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text(data.fields.isi,
                    style:
                        TextStyle(fontWeight: FontWeight.normal, fontSize: 16)),
              ],
            ),
          TextButton(
            child: const Text("Delete"),
            onPressed: () {
              deleteForum(data.pk);
              Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ForumPage()),
                    );
                  },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.red),
            ),
          ),],
        ),
      ),
      persistentFooterButtons: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            minimumSize: const Size.fromHeight(40),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(
            'Back',
            style: TextStyle(fontSize: 12),
          ),
        ),
      ],
    );
    
  }
}