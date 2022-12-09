import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:saku_in/dompet/util/create_aruskas.dart';
import 'package:saku_in/main.dart';
import 'package:saku_in/drawer.dart';
import 'package:saku_in/dompet/model/dompet.dart';
import 'package:saku_in/dompet/model/aruskas.dart';
import 'package:saku_in/drawer.dart';
import 'package:http/http.dart' as http;

class ArusKasForm extends StatefulWidget {
  const ArusKasForm({super.key});

  @override
  State<ArusKasForm> createState() => _ArusKasFormState();
}

class _ArusKasFormState extends State<ArusKasForm> {
  final _formKey = GlobalKey<FormState>();
  String _title = "";
  int _nominal = 0;
  int _type = 0;
  DateTime _date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Catatan Arus Kas'),
      ),
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
                      hintText: "Contoh: Topup Gensin Impek",
                      labelText: "Judul",
                      // Menambahkan icon agar lebih intuitif
                      icon: const Icon(Icons.note_alt),
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
                      hintText: "Contoh: 69000",
                      labelText: "Nominal",
                      // Menambahkan icon agar lebih intuitif
                      icon: const Icon(Icons.attach_money),
                      // Menambahkan circular border agar lebih rapi
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    // Menambahkan behavior saat nama diketik
                    onChanged: (String? value) {
                      setState(() {
                        _nominal = int.parse(value!);
                      });
                    },
                    // Menambahkan behavior saat data disimpan
                    onSaved: (String? value) {
                      setState(() {
                        _nominal = int.parse(value!);
                      });
                    },
                    // Validator sebagai validasi form
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Nominal tidak boleh kosong!';
                      }
                      if (int.parse(value) == 0) {
                        return 'Nominal tidak boleh nol!';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButtonFormField<String>(
                    value: null,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    hint: const Text("Pilih jenis"),
                    items: [
                      DropdownMenuItem(
                        value: "Pemasukan",
                        child: Text("Pemasukan"),
                      ),
                      DropdownMenuItem(
                        value: "Pengeluaran",
                        child: Text("Pengeluaran"),
                      ),
                    ],
                    onChanged: (String? value) {
                      setState(() {
                        _type = value == "Pemasukan" ? 1 : -1;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Ayo jangan nakal, pilih jenisnya!";
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
                              "https://saku-in.up.railway.app/dompet/create_arus_kas/");
                          var response = await http.post(url, body: {
                            "keterangan": _title,
                            "nominal": _nominal.toString(),
                            "tipe": _type.toString(),
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
                                                'Berhasil menambahkan budget!'),
                                            Padding(
                                                padding:
                                                    EdgeInsets.only(top: 20),
                                                child: Column(children: [
                                                  Text('Keterangan: $_title'),
                                                  Text('Nominal: $_nominal'),
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
                                                'Gagal menambahkan budget!'),
                                            Padding(
                                                padding:
                                                    EdgeInsets.only(top: 20),
                                                child: Column(children: [
                                                  Text(
                                                      "Saldo tidak boleh negatif!")
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
