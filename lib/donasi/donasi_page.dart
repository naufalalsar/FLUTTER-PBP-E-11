import 'package:flutter/material.dart';
import 'package:saku_in/donasi/donasi_model.dart';
import 'package:saku_in/donasi/donasi_parser.dart';
import 'package:saku_in/donasi/add_donasi_page.dart';

import 'package:saku_in/drawer.dart';

class DonasiPage extends StatefulWidget {
  const DonasiPage({super.key});

  @override
  State<DonasiPage> createState() => _MyDataState();
}

class DataDonasi extends StatelessWidget {
  final Donasi donasi;

  const DataDonasi({Key? key, required this.donasi}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail Berita')),
      drawer: const TheSideBar(),
      body: Container(
        alignment: Alignment.center,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          TextButton(
              // ignore: sort_child_properties_last
              child: const Text(
                "Tambah Donasi",
                style: TextStyle(color: Colors.white),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue),
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MyFormPage()));
              }),
          Text(
            donasi.fields.title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(donasi.fields.title),
          // const SizedBox(height: 10),
          // Text("Category : " + donasi.fields.category),
          // const SizedBox(height: 10),
          // Text("Added : " + donasi.fields.date.toString().substring(0, 10)),
          // const SizedBox(height: 10),
          // Text("Writer : " + donasi.fields.writer),
          // const SizedBox(height: 10),
          // Text("Source : " + donasi.fields.source),
          // const SizedBox(height: 10),
        ]),
      ),
      bottomNavigationBar: TextButton(
        child: const Text("Back"),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}

class _MyDataState extends State<DonasiPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Donasi"),
      ),
      // Menambahkan drawer menu
      drawer: TheSideBar(),
      body: Center(
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: const Text(
                  "Daftar Donasi",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                ),
              ),
            ),
            TextButton(
                // ignore: sort_child_properties_last
                child: const Text(
                  "Tambah Donasi",
                  style: TextStyle(color: Colors.white),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MyFormPage()));
                }),
            Expanded(
              flex: 10,
              child: FutureBuilder(
                  future: fetchDonasi(),
                  builder: (context, AsyncSnapshot snapshot) {
                    return ListView.builder(
                      padding: const EdgeInsets.all(7),
                      itemCount: snapshot.data?.length ?? 0,
                      itemBuilder: (_, index) => Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.all(5),
                          height: 100,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(color: Colors.black, blurRadius: 2.0)
                              ]),
                          child: InkWell(
                            // onTap: (){
                            //   Navigator.push(context,
                            //       MaterialPageRoute(builder: (context) =>
                            //       DonationDetail(detail: snapshot.data![index], args: args)));
                            // },
                            child: Column(
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: Column(
                                      children: [
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            snapshot.data[index]!.fields.title,
                                            textAlign: TextAlign.left,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 20),
                                          ),
                                        ),
                                        const Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            "   ",
                                            textAlign: TextAlign.left,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 1.5),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            "${snapshot.data[index]!.fields.achieved}/${snapshot.data[index]!.fields.target}",
                                            textAlign: TextAlign.left,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 11),
                                          ),
                                        ),
                                      ],
                                    )),
                                Expanded(
                                  flex: 1,
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: Text(
                                      snapshot.data[index]!.fields.description,
                                      textAlign: TextAlign.right,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
