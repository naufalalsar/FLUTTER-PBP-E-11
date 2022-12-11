import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:saku_in/drawer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ExchangeRatePage extends StatefulWidget {
  const ExchangeRatePage({super.key});

  @override
  State<ExchangeRatePage> createState() => _ExchangeRatePageState();
}

class _ExchangeRatePageState extends State<ExchangeRatePage> {
  final _formKey = GlobalKey<FormState>();
  String _sourceCurrency = '';
  String _targetCurrency = '';
  int _amount = 0;
  List<String> _currencyList = [
    'ARS',
    'AUD',
    'BGN',
    'BRL',
    'CNY',
    'EUR',
    'INR',
    'IDR',
    'JPY',
    'KRW',
    'MXN',
    'RUB',
    'SAR',
    'ZAR',
    'TRY',
    'GBP',
    'USD'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Konversi Mata Uang")),
        drawer: const TheSideBar(),
        body: Form(
            key: _formKey,
            child: SingleChildScrollView(
                child: Container(
                    padding: const EdgeInsets.all(20.0),
                    height: MediaQuery.of(context).size.height * 0.9,
                    child: Column(
                      children: [
                        const Text(
                          "Mata Uang Asal",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: DropdownButtonFormField<String>(
                              value: null,
                              icon: const Icon(Icons.keyboard_arrow_down),
                              hint: const Text("Pilih Mata Uang Asal"),
                              isExpanded: true,
                              items: _currencyList
                                  .map((String value) =>
                                      DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      ))
                                  .toList(),
                              onChanged: (value) {
                                setState(() {
                                  _sourceCurrency = value!;
                                });
                              },
                              onSaved: (value) {
                                setState(() {
                                  _sourceCurrency = value!;
                                });
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Ayo jangan nakal, pilih jenisnya!";
                                }

                                return null;
                              },
                            )),
                        const SizedBox(height: 20),
                        const Text(
                          "Mata Uang Tujuan",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: DropdownButtonFormField<String>(
                              value: null,
                              icon: const Icon(Icons.keyboard_arrow_down),
                              hint: const Text("Pilih Mata Uang Tujuan"),
                              isExpanded: true,
                              items: _currencyList
                                  .map((String value) =>
                                      DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      ))
                                  .toList(),
                              onChanged: (value) {
                                setState(() {
                                  _targetCurrency = value!;
                                });
                              },
                              onSaved: (value) {
                                setState(() {
                                  _targetCurrency = value!;
                                });
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Ayo jangan nakal, pilih jenisnya!";
                                }

                                return null;
                              },
                            )),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.all(4),
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: "Contoh: 69000",
                              labelText: "Amount",
                              // Menambahkan icon agar lebih intuitif
                              icon: const Icon(Icons.attach_money),
                              // Menambahkan circular border agar lebih rapi
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            // Menambahkan behavior saat nama diketik
                            onChanged: (String? value) {
                              setState(() {
                                _amount = int.parse(value!);
                              });
                            },
                            // Menambahkan behavior saat data disimpan
                            onSaved: (String? value) {
                              setState(() {
                                _amount = int.parse(value!);
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
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            TextButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.black),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text(
                                'Kembali',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            const Spacer(),
                            TextButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.black),
                              ),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  var url = Uri.parse(
                                      "https://saku-in.up.railway.app/kurs/calculate");
                                  var response = await http.post(url, body: {
                                    "source_currency": _sourceCurrency,
                                    "target_currency": _targetCurrency,
                                    "amount": _amount.toString(),
                                  });
                                  var decoded = json.decode(response.body);
                                  var result = decoded["result"];

                                  if (response.statusCode == 200) {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return Dialog(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          elevation: 15,
                                          child: Container(
                                            child: ListView(
                                              padding: const EdgeInsets.all(20),
                                              shrinkWrap: true,
                                              children: <Widget>[
                                                const Text(
                                                  "Hasil Konversi",
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                const SizedBox(height: 20),
                                                Text(
                                                  "$_amount $_sourceCurrency = $result $_targetCurrency",
                                                  style: const TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                const SizedBox(height: 20),
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text('Kembali'),
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
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          elevation: 15,
                                          child: ListView(
                                            padding: const EdgeInsets.only(
                                                top: 20, bottom: 20),
                                            shrinkWrap: true,
                                            children: <Widget>[
                                              Center(
                                                  child: Column(
                                                children: const [
                                                  Text('Gagal Konversi'),
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 20),
                                                      child: Text(
                                                          "Saldo tidak boleh negatif!")),
                                                ],
                                              )),
                                              const SizedBox(height: 20),
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text('Kembali'),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  }
                                }
                              },
                              child: const Text(
                                "Konversi",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )))));
  }
}
