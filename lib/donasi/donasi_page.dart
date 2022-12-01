import 'package:flutter/material.dart';
import 'package:saku_in/drawer.dart';

class DonasiPage extends StatefulWidget {
  const DonasiPage({super.key});

  @override
  State<DonasiPage> createState() => _MyDataState();
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
        body: const Text("Donasi"));
  }
}