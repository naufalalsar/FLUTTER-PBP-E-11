import 'package:flutter/material.dart';
import 'package:saku_in/drawer.dart';
import 'package:saku_in/dompet/util/fetch_dompet.dart';
import 'package:saku_in/dompet/page/aruskas_form.dart';
import 'package:saku_in/dompet/page/aruskas_list.dart';

class DompetPage extends StatefulWidget {
  const DompetPage({super.key});

  @override
  State<DompetPage> createState() => _MyDataState();
}

class _MyDataState extends State<DompetPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Dompet"),
        ),
        // Menambahkan drawer menu
        drawer: TheSideBar(),
        body: FutureBuilder(
          future: fetchDompet(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData) {
              return Column(
                children: [
                  ListTile(
                      title: Text("Saldo:", style: TextStyle(fontSize: 16)),
                      subtitle: Text("${snapshot.data.saldo}",
                          style: TextStyle(fontSize: 20)),
                      trailing: Icon(Icons.account_balance_wallet)),
                  const Divider(
                    height: 3,
                  ),
                  ListTile(
                    title: Text("Pemasukan:", style: TextStyle(fontSize: 16)),
                    subtitle: Text("${snapshot.data.pemasukan}",
                        style: TextStyle(fontSize: 20, color: Colors.green)),
                    trailing: Icon(Icons.monetization_on),
                  ),
                  const Divider(
                    height: 3,
                  ),
                  ListTile(
                    title: Text("Pengeluaran:", style: TextStyle(fontSize: 16)),
                    subtitle: Text("${snapshot.data.pengeluaran}",
                        style: TextStyle(fontSize: 20, color: Colors.red)),
                    trailing: Icon(Icons.shopping_bag),
                  ),
                  const Divider(
                    height: 3,
                  ),
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ArusKasForm()));
                        },
                        icon: const Icon(Icons.add),
                        label: const Text('Tambah'),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ArusKasData()));
                        },
                        icon: const Icon(Icons.history),
                        label: const Text('Riwayat'),
                      ),
                    ],
                  ),
                ],
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ));
  }
}
