import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:saku_in/donasi/donasi_model.dart';
import 'package:saku_in/donasi/donasi_page.dart';
import 'package:saku_in/donasi/donasi_parser.dart';

import 'package:saku_in/drawer.dart';

class MyFormPage extends StatefulWidget {
  const MyFormPage({super.key});

  @override
  State<MyFormPage> createState() => _MyFormPageState();
}

class _MyFormPageState extends State<MyFormPage> {
  final _formKey = GlobalKey<FormState>();
  String _judul = "";
  String _description = "";
  String nominal = "";

  // List<ModelBudget> listBudget = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Tambah Donasi')),
        drawer: const TheSideBar(),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  // JUDUL INPUT
                  // Menggunakan padding sebesar 8 pixels
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      // hintText: "Contoh: Pak Dengklek",
                      labelText: "Title",
                      // Menambahkan icon agar lebih intuitif
                      // icon: const Icon(Icons.people),
                      // Menambahkan circular border agar lebih rapi
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    // Menambahkan behavior saat nama diketik
                    onChanged: (String? value) {
                      setState(() {
                        _judul = value!;
                      });
                    },
                    // Menambahkan behavior saat data disimpan
                    onSaved: (String? value) {
                      setState(() {
                        _judul = value!;
                      });
                    },
                    // Validator sebagai validasi form
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Nama lengkap tidak boleh kosong!';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  // Deskripsi INPUT
                  // Menggunakan padding sebesar 8 pixels
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      // hintText: "Contoh: Pak Dengklek",
                      labelText: "Description",
                      // Menambahkan icon agar lebih intuitif
                      // icon: const Icon(Icons.people),
                      // Menambahkan circular border agar lebih rapi
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    // Menambahkan behavior saat nama diketik
                    onChanged: (String? value) {
                      setState(() {
                        _description = value!;
                      });
                    },
                    // Menambahkan behavior saat data disimpan
                    onSaved: (String? value) {
                      setState(() {
                        _description = value!;
                      });
                    },
                    // Validator sebagai validasi form
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Deskripsi tidak boleh kosong!';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  // Target INPUT
                  // Menggunakan padding sebesar 8 pixels
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    decoration: InputDecoration(
                      // hintText: "Contoh: Pak Dengklek",
                      labelText: "Target",
                      // Menambahkan icon agar lebih intuitif
                      // icon: const Icon(Icons.people),
                      // Menambahkan circular border agar lebih rapi
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    // Menambahkan behavior saat nama diketik
                    onChanged: (String? value) {
                      setState(() {
                        nominal = value!;
                      });
                    },
                    // Menambahkan behavior saat data disimpan
                    onSaved: (String? value) {
                      setState(() {
                        nominal = value!;
                      });
                    },
                    // Validator sebagai validasi form
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Target tidak boleh kosong!';
                      }
                      return null;
                    },
                  ),
                ),
                TextButton(
                    // ignore: sort_child_properties_last
                    child: const Text(
                      "Simpan",
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
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
                                    const Center(
                                        child: Text(
                                      'Berhasil Menambah Donasi!',
                                      style: TextStyle(fontSize: 20),
                                    )),
                                    TextButton(
                                      style: TextButton.styleFrom(
                                        backgroundColor: Colors.pink,
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child:
                                          const Text('Kembali Menambah Donasi'),
                                    ),
                                    TextButton(
                                      style: TextButton.styleFrom(
                                        backgroundColor: const Color.fromARGB(
                                            255, 182, 138, 135),
                                      ),
                                      onPressed: () {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const DonasiPage()),
                                        );
                                      },
                                      child: const Text(
                                          'Kembali Ke Daftar Donasi'),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                        createDonasi(_judul, _description, nominal);
                        setState(() {
                          _formKey.currentState?.reset();
                        });
                      }
                    }),
              ],
            ),
          ),
        ));
  }
}
