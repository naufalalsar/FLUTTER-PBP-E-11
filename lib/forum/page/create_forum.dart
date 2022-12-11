import 'package:saku_in/main.dart';
import 'package:saku_in/drawer.dart';
import 'package:saku_in/forum/model/forum.dart';
import 'package:saku_in/forum/page/forum_detail.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FormForum extends StatefulWidget {
  const FormForum({super.key});

  @override
  State<FormForum> createState() => _FormForumState();
}

class _FormForumState extends State<FormForum> {
  final _formKey = GlobalKey<FormState>();
  String _title = "";
  String _content = "";
  DateTime _date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Forum'),
      ),
      backgroundColor: const Color(0xff03fca1),
      drawer: TheSideBar(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "Contoh: Ekonomi",
                      labelText: "Judul",
                      // Menambahkan icon agar lebih intuitif
                      icon: const Icon(Icons.chat_bubble),
                      // Menambahkan circular border agar lebih rapi
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    // Menambahkan behavior saat nama diketik
                    onChanged: (String? value) {
                      setState(() {
                        _title = value!;
                      });
                    },
                    // Menambahkan behavior saat data disimpan
                    onSaved: (String? value) {
                      setState(() {
                        _title = value!;
                      });
                    },
                    // Validator sebagai validasi form
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Judul tidak boleh kosong!';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "Contoh: Kenaikan BBM",
                      labelText: "Isi",
                      // Menambahkan icon agar lebih intuitif
                      icon: const Icon(Icons.forum),
                      // Menambahkan circular border agar lebih rapi
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    // Menambahkan behavior saat nama diketik
                    onChanged: (String? value) {
                      setState(() {
                        _content = value!;
                      });
                    },
                    // Menambahkan behavior saat data disimpan
                    onSaved: (String? value) {
                      setState(() {
                        _content = value!;
                      });
                    },
                    // Validator sebagai validasi form
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Isi tidak boleh kosong!';
                      }
                      return null;
                    },
                  ),
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.black),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Kembali"),
                    ),
                    TextButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.black),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          var url = Uri.parse(
                              "https://saku-in.up.railway.app/forum/create_forum/");
                          var response = await http.post(url, body: {
                            "judul": _title,
                            "isi": _content,
                          });
                          if (response.statusCode == 200) {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return Dialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  elevation: 15,
                                  child: Container(
                                    child: ListView(
                                      padding: const EdgeInsets.only(
                                          top: 20, bottom: 20),
                                      shrinkWrap: true,
                                      children: <Widget>[
                                        Center(
                                            child: Column(
                                          children: [
                                            const Text(
                                                'Berhasil menambahkan forum!'),
                                            Padding(
                                                padding:
                                                    EdgeInsets.only(top: 20),
                                                child: Column(children: [
                                                  Text('Judul: $_title'),
                                                  Text('Isi: $_content'),
                                                ])),
                                          ],
                                        )),
                                        SizedBox(height: 20),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text('Kembali'),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          } else {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return Dialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  elevation: 15,
                                  child: Container(
                                    child: ListView(
                                      padding: const EdgeInsets.only(
                                          top: 20, bottom: 20),
                                      shrinkWrap: true,
                                      children: <Widget>[
                                        Center(
                                            child: Column(
                                          children: [
                                            const Text(
                                                'Gagal menambahkan forum!'),
                                          ],
                                        )),
                                        SizedBox(height: 20),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text('Kembali'),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                        }
                      },
                      child: const Text(
                        "Simpan",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
