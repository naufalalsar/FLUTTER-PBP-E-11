import 'package:flutter/material.dart';
import 'package:saku_in/berita/berita_parser.dart';
import 'package:saku_in/drawer.dart';
import 'package:saku_in/berita/berita_model.dart';

class BeritaPage extends StatefulWidget {
  const BeritaPage({super.key});

  @override
  State<BeritaPage> createState() => _MyDataState();
}

class DetailBerita extends StatelessWidget {
  final Berita thisBerita;

  const DetailBerita({Key? key, required this.thisBerita}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail Berita')),
      drawer: TheSideBar(),
      body:Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           Text(
          thisBerita.fields.title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Text(thisBerita.fields.content),
        const SizedBox(height: 10),
        Text("Category : " + thisBerita.fields.category),
        const SizedBox(height: 10),
        Text("Added : " + thisBerita.fields.date.toString().substring(0, 10)),
        const SizedBox(height: 10),
        Text("Writer : " + thisBerita.fields.writer),
        const SizedBox(height: 10),
        Text("Source : " + thisBerita.fields.source),
        const SizedBox(height: 10),
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

class _MyDataState extends State<BeritaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Berita"),
        ),
        // Menambahkan drawer menu
        drawer: TheSideBar(),
        body: FutureBuilder(
          future: fetchBerita(),
          builder: ((context, snapshot) {
            if (snapshot.data == null) {
              return const Center(child: CircularProgressIndicator());
            } else {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final item = snapshot.data!.elementAt(index);
                    return ListTile(
                      shape: ContinuousRectangleBorder(
                          side: BorderSide(color: Colors.black, width: 1),
                      ),
                      title: Text(item.fields.title),
                      subtitle: Text(item.fields.category),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailBerita(
                                      thisBerita: item,
                                    )));
                      },
                    );
                  },
                );
              } else {
                return Column(
                  children: const [
                    Text("No News Yet :("),
                    SizedBox(height: 8),
                  ],
                );
              }
            }
          }),
        ));
  }
}
