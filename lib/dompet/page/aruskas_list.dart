import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:saku_in/main.dart';
import 'package:saku_in/drawer.dart';
import 'package:saku_in/dompet/model/dompet.dart';
import 'package:saku_in/dompet/model/aruskas.dart';
import 'package:saku_in/dompet/util/fetch_aruskas.dart';
import 'package:saku_in/drawer.dart';

class ArusKasData extends StatefulWidget {
  const ArusKasData({super.key});

  @override
  State<ArusKasData> createState() => _ArusKasDataState();
}

class _ArusKasDataState extends State<ArusKasData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Riwayat Arus Kas'),
      ),
      drawer: TheSideBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          FutureBuilder(
            future: fetchArusKas(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                print("masuk1");
                return Center(child: CircularProgressIndicator());
              } else {
                if (!snapshot.hasData || snapshot.data.isEmpty) {
                  return Center(
                      child: Text(
                    'Belum ada catatan arus kas 🗿, yuk buat dulu!\n😳😳😳',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ));
                } else {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: ListTile(
                              title:
                                  Text(snapshot.data[index].fields.keterangan),
                              subtitle: Text(
                                (snapshot.data[index].fields.tipe == 1
                                        ? '+'
                                        : '-') +
                                    'Rp. ' +
                                    snapshot.data[index].fields.nominal
                                        .toString(),
                                style: TextStyle(
                                    color: snapshot.data[index].fields.tipe == 1
                                        ? Colors.green
                                        : Colors.red),
                              ),
                              trailing: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    snapshot.data[index].fields.createdAt
                                        .toString()
                                        .split(' ')[0],
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                      snapshot.data[index].fields.tipe == 1
                                          ? 'Pemasukan'
                                          : 'Pengeluaran',
                                      style: TextStyle(
                                          color: snapshot.data[index].fields
                                                      .tipe ==
                                                  '1'
                                              ? Colors.green
                                              : Colors.red,
                                          fontSize: 12)),
                                ],
                              )),
                        ),
                      );
                    },
                  );
                }
              }
            },
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.5,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Kembali'),
            ),
          ),
        ],
      ),
    );
  }
}
