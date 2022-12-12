import 'package:flutter/material.dart';
import 'package:saku_in/drawer.dart';
import 'package:saku_in/forum/util/fetch_forum_data.dart';
import 'package:saku_in/forum/page/forum_detail.dart';
import 'package:saku_in/forum/page/create_forum.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

class ForumPage extends StatefulWidget {
  const ForumPage({super.key});

  @override
  State<ForumPage> createState() => _MyDataState();
}

class _MyDataState extends State<ForumPage> {
  @override
  Widget build(BuildContext context) {
    final request = context.read<CookieRequest>();
    return Scaffold(
        appBar: AppBar(
          title:  Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text("Forum"),   if(request.jsonData['username'] != null)  ElevatedButton.icon(
                        onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => FormForum()));
            },
                        icon: const Icon(Icons.add_box),
                        label: const Text('Tambah Forum'),
                      ),],
                    
        ),
        ),
        // Menambahkan drawer menu
        backgroundColor: const Color(0xff03fca1),
        drawer: TheSideBar(),
       
        body: 
            FutureBuilder(
                future: fetchToDo(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.data == null) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    if (!snapshot.hasData) {
                      return Column(
                        children: const [
                          Text(
                            "Tidak ada forum :(",
                            style:
                                TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                          ),
                          SizedBox(height: 8),
                        ],
                      );
                    } else {
                      return ListView.builder(
                        shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (_, index) => ListTile(
                              title: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ForumDetail(
                                              data: snapshot.data![index])));
                                },
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 12),
                                  padding: const EdgeInsets.all(20.0),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15.0),
                                      boxShadow: const [
                                        BoxShadow(
                                            color: Color.fromARGB(255, 255, 255, 255), blurRadius: 7.0)
                                      ]),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${snapshot.data![index].fields.judul}",
                                        style: const TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "${snapshot.data![index].fields.isi}",
                                        style: const TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "${snapshot.data![index].fields.tanggal}",
                                        style: const TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )));
                    }
                  }
                }),
          
        );
  }
  }
