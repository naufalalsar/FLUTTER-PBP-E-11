import 'package:flutter/material.dart';
import 'package:saku_in/drawer.dart';

class KursPage extends StatefulWidget {
  const KursPage({super.key});

  @override
  State<KursPage> createState() => _MyDataState();
}

class _MyDataState extends State<KursPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Kurs"),
        ),
        // Menambahkan drawer menu
        drawer: TheSideBar(),
        body: const Text("Kurs"));
  }
}
