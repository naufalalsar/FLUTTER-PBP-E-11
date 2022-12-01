import 'package:flutter/material.dart';
import 'package:saku_in/drawer.dart';

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
        body: const Text("Dompet"));
  }
}