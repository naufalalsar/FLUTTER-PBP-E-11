import 'package:flutter/material.dart';
import 'package:saku_in/dompet/dompet_page.dart';
import 'package:saku_in/forum/forum_page.dart';
import 'package:saku_in/berita/berita_page.dart';
import 'package:saku_in/kurs/kurs_page.dart';
import 'package:saku_in/donasi/donasi_page.dart';
import 'package:saku_in/main.dart';

class TheSideBar extends StatelessWidget {
  const TheSideBar();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          // Menambahkan clickable menu
          ListTile(
            title: const Text('counter_7'),
            onTap: () {
              // Route menu ke halaman utama
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const MyHomePage(title: "counter_7")),
              );
            },
          ),
          ListTile(
            title: const Text('Berita'),
            onTap: () {
              // Route menu ke halaman form
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const BeritaPage()),
              );
            },
          ),
                ListTile(
            title: const Text('Forum'),
            onTap: () {
              // Route menu ke halaman form
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const ForumPage()),
              );
            },
          ),
                ListTile(
            title: const Text('Donasi'),
            onTap: () {
              // Route menu ke halaman form
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const DonasiPage()),
              );
            },
          ),
                ListTile(
            title: const Text('Kurs'),
            onTap: () {
              // Route menu ke halaman form
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const KursPage()),
              );
            },
          ),
                ListTile(
            title: const Text('Dompet'),
            onTap: () {
              // Route menu ke halaman form
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const DompetPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
