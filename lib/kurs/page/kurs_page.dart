import 'package:flutter/material.dart';
import 'package:saku_in/drawer.dart';
import 'package:saku_in/kurs/page/detail_kurs_page.dart';
import 'package:saku_in/kurs/util/fetch_exchange.dart';

class KursPage extends StatefulWidget {
  const KursPage({super.key});

  @override
  State<KursPage> createState() => _MyDataState();
}

class _MyDataState extends State<KursPage> {
  final _fetchExchange = fetchExchange();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Kurs"),
        ),
        backgroundColor: const Color(0xff03fca1),
        // Menambahkan drawer menu
        drawer: const TheSideBar(),
        body: Padding(
          padding: const EdgeInsets.all(32.0),
          child: FutureBuilder(
              future: _fetchExchange,
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  if (!snapshot.hasData) {
                    return Column(
                      children: const [
                        Text(
                          "Tidak ada to do list :(",
                          style:
                              TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                        ),
                        SizedBox(height: 8),
                      ],
                    );
                  } else {
                    return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DetailKursPage(
                                            data: snapshot.data[index])));
                              },
                              child: Card(
                                child: ListTile(
                                  title: Text(
                                      "${snapshot.data[index].fields.sourceCurrency.code} ${snapshot.data[index].fields.sourceCurrency.name}"),
                                  subtitle: Text(
                                      "Amount in IDR: ${snapshot.data[index].fields.amount}"),
                                ),
                              ));
                        });
                  }
                }
              }),
        ));
  }
}
