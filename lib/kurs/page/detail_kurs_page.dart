import 'package:flutter/material.dart';
import 'package:saku_in/kurs/model/exchange.dart';

class DetailKursPage extends StatelessWidget {
  const DetailKursPage({super.key, required this.data});

  final Exchange data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xff03fca1),
        appBar: AppBar(
          title: const Text("Kurs"),
        ),
        body: Container(
            padding: const EdgeInsets.all(16.0),
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(data.fields.sourceCurrency.name,
                      style: const TextStyle(
                          fontSize: 30, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 30),
                Row(children: [
                  const Text(
                    "Amount in IDR: ",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    data.fields.amount.toString(),
                    style: const TextStyle(fontSize: 16),
                  )
                ]),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Text(
                      "Change 1d: ",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "${data.fields.change1D.toString()}%",
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Text(
                      "Change 1w: ",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "${data.fields.change1W.toString()}%",
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Text(
                      "Change 1m: ",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "${data.fields.change1M.toString()}%",
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Text(
                      "Change 1y: ",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "${data.fields.change1Y.toString()}%",
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ],
            )));
  }
}
