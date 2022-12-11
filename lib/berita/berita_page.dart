import 'package:flutter/material.dart';
import 'package:saku_in/berita/berita_parser.dart';
import 'package:saku_in/drawer.dart';
import 'package:saku_in/berita/berita_model.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

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
    final request = context.read<CookieRequest>();
    return Scaffold(
      appBar: AppBar(title: const Text('Detail Berita')),
      drawer: TheSideBar(),
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              thisBerita.fields.title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
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
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextButton(
            child: const Text("Back"),
            onPressed: () {
              Navigator.pop(context);
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.blue),
            ),
          ),
          if(request.jsonData['username'] != null) TextButton(
              child: const Text("Delete"),
              onPressed: () {
                deleteBerita(thisBerita.pk);
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
                              padding:
                                  const EdgeInsets.only(top: 20, bottom: 20),
                              shrinkWrap: true,
                              children: <Widget>[

                                Text("Berhasil menghapus berita!", style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                                TextButton(

                                  style:  ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.green),),


                                 
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const BeritaPage()),
                                    );
                                  },
                                  child: Text('OK'),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                    },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red),
              ),
            ),
        ],
      ),
    );
  }
}

class MyFormPage extends StatefulWidget {
  const MyFormPage({super.key});

  @override
  State<MyFormPage> createState() => _MyFormPageState();
}

class _MyFormPageState extends State<MyFormPage> {
  final _formKey = GlobalKey<FormState>();
  String title = "";
  String content = "";
  String category = 'uang';
  List<String> listCategory = ['uang', 'bank', 'ekonomi', 'kripto', 'saham'];
  String writer = "";
  String source = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Berita"),
      ),
      // Menambahkan drawer menu
      drawer: TheSideBar(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(children: [
              Padding(
                // Menggunakan padding sebesar 8 pixels
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Title",
                    // Menambahkan circular border agar lebih rapi
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  // Menambahkan behavior saat nama diketik
                  onChanged: (String? value) {
                    setState(() {
                      title = value!;
                    });
                  },
                  // Menambahkan behavior saat data disimpan
                  onSaved: (String? value) {
                    setState(() {
                      title = value!;
                    });
                  },
                  // Validator sebagai validasi form
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Title tidak boleh kosong!';
                    }
                    if (value.length >= 200) {
                      return 'Title terlalu panjang!';
                    }
                  },
                ),
              ),
              Padding(
                // Menggunakan padding sebesar 8 pixels
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Content",
                    // Menambahkan circular border agar lebih rapi
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  // Menambahkan behavior saat nama diketik
                  onChanged: (String? value) {
                    setState(() {
                      content = value!;
                    });
                  },
                  // Menambahkan behavior saat data disimpan
                  onSaved: (String? value) {
                    setState(() {
                      content = value!;
                    });
                  },
                  // Validator sebagai validasi form
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Content tidak boleh kosong!';
                    }
                  },
                ),
              ),
              ListTile(
                title: const Text(
                  'Category',
                ),
                trailing: DropdownButton(
                    value: category,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: listCategory.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        category = value!;
                      });
                    }),
              ),
              Padding(
                // Menggunakan padding sebesar 8 pixels
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Writer",
                    // Menambahkan circular border agar lebih rapi
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  // Menambahkan behavior saat nama diketik
                  onChanged: (String? value) {
                    setState(() {
                      writer = value!;
                    });
                  },
                  // Menambahkan behavior saat data disimpan
                  onSaved: (String? value) {
                    setState(() {
                      writer = value!;
                    });
                  },
                  // Validator sebagai validasi form
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Writer tidak boleh kosong!';
                    }
                    if (value.length >= 200) {
                      return 'Writer terlalu panjang!';
                    }
                  },
                ),
              ),
              Padding(
                // Menggunakan padding sebesar 8 pixels
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Source",
                    // Menambahkan circular border agar lebih rapi
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  // Menambahkan behavior saat nama diketik
                  onChanged: (String? value) {
                    setState(() {
                      source = value!;
                    });
                  },
                  // Menambahkan behavior saat data disimpan
                  onSaved: (String? value) {
                    setState(() {
                      source = value!;
                    });
                  },
                  // Validator sebagai validasi form
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Source tidak boleh kosong!';
                    }
                    if (value.length >= 200) {
                      return 'Source terlalu panjang';
                    }
                  },
                ),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const BeritaPage()),
                    );
                  },
                  child: const Text("Kembali")),
              TextButton(
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
                              padding:
                                  const EdgeInsets.only(top: 20, bottom: 20),
                              shrinkWrap: true,
                              children: <Widget>[
                                Center(
                                    child: const Text(
                                  'Berhasil Menambah Data!',
                                  style: TextStyle(fontSize: 20),
                                )),
                                TextButton(
                                  style: TextButton.styleFrom(
                                    backgroundColor: Colors.yellow,
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('Kembali Menambah Berita'),
                                ),
                                TextButton(
                                  style: TextButton.styleFrom(
                                    backgroundColor: Colors.red,
                                  ),
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const BeritaPage()),
                                    );
                                  },
                                  child: Text('Kembali Ke Tampilan Berita'),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                    createBerita(title, content, category, writer, source);
                    setState(() {
                      _formKey.currentState?.reset();
                    });
                  }
                },
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

class _MyDataState extends State<BeritaPage> {
  @override
  Widget build(BuildContext context) {
    final request = context.read<CookieRequest>();
    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text("Berita"),if(request.jsonData['username'] != null)ElevatedButton.icon(
                        onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MyFormPage()));
            },
                        icon: const Icon(Icons.add_box),
                        label: const Text('Tambah Berita'),
                      ),],
                  
                
        ),
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
