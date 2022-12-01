import 'package:flutter/material.dart';
import 'package:saku_in/drawer.dart';

class ForumPage extends StatefulWidget {
  const ForumPage({super.key});

  @override
  State<ForumPage> createState() => _MyDataState();
}

class _MyDataState extends State<ForumPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Forum"),
        ),
        // Menambahkan drawer menu
        drawer: TheSideBar(),
        body: const Text("Forum"));
  }
}