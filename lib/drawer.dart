import 'package:flutter/material.dart';
import 'package:saku_in/dompet/page/dompet_page.dart';
import 'package:saku_in/forum/forum_page.dart';
import 'package:saku_in/berita/berita_page.dart';
import 'package:saku_in/kurs/page/kurs_page.dart';
import 'package:saku_in/donasi/donasi_page.dart';
import 'package:saku_in/auth/page/login_page.dart';
import 'package:saku_in/main.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

class TheSideBar extends StatefulWidget {
  const TheSideBar({super.key});

  @override
  State<TheSideBar> createState() => _TheSideBarState();
}

class _TheSideBarState extends State<TheSideBar> {
  @override
  Widget build(BuildContext context) {
    final request = context.read<CookieRequest>();
    return Drawer(
      child: Column(
        children: [
          // Menambahkan clickable menu
          ListTile(
            title: Text(
              request.jsonData['username'] == null
                  ? "Not logged in"
                  : "Log in as ${request.jsonData['username']}",
            ),
          ),
          ListTile(
            title: const Text('Homepage'),
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
          !request.loggedIn
              ? ListTile(
                  title: const Text('Login'),
                  onTap: () {
                    // Route menu ke halaman form
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                    );
                  },
                )
              : ListTile(
                  title: const Text('Logout'),
                  onTap: () async {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => const MyApp()));
                    final response = await request.logout(
                        "https://saku-in.up.railway.app/authentication/logout");
                  },
                )
        ],
      ),
    );
  }
}
