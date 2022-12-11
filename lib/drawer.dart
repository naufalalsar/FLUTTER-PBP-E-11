import 'package:flutter/material.dart';
import 'package:saku_in/dompet/page/dompet_page.dart';
import 'package:saku_in/forum/forum_page.dart';
import 'package:saku_in/berita/berita_page.dart';
import 'package:saku_in/kurs/page/kurs_page.dart';
import 'package:saku_in/donasi/donasi_page.dart';
import 'package:saku_in/auth/page/login_page.dart';
import 'package:saku_in/main.dart';

class TheSideBar extends StatelessWidget {
  const TheSideBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xff03fca1),
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
                    builder: (context) => const MyHomePage(title: "Saku In")),
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
          ListTile(
            title: const Text('Login'),
            onTap: () {
              // Route menu ke halaman form
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
