import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:saku_in/drawer.dart';
import 'package:saku_in/auth/page/register_page.dart';
import 'package:saku_in/main.dart';
import 'package:saku_in/toast.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  bool isPasswordVisible = false;

  void clear() {
    // Clean up the controller when the widget is disposed.
    usernameController.clear();
    passwordController.clear();

    // super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final request = context.read<CookieRequest>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      // Menambahkan drawer menu
      drawer: TheSideBar(),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(height: 40),
              TextFormField(
                controller: usernameController,
                decoration: const InputDecoration(
                  icon: Icon(Icons.person),
                  hintText: 'Username',
                  labelText: 'Username',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                obscureText: false,
              ),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  icon: Icon(Icons.lock),
                  hintText: 'Password',
                  labelText: 'Password',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    print("login");
                    final response = await request.login(
                        "https://saku-in.up.railway.app/authentication/login/", {
                      'username': usernameController.text,
                      'password': passwordController.text,
                    }).then((response) => {
                          if (response['status'])
                            {
                              request.jsonData = response['user_data'],
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => 
                                          const MyHomePage(title: 'Saku In'))),
                            }
                          else
                            {toast(context, true, response['message'])}
                        });
                  }
                },
                child: const Text('Login'),
              ),
              // register button that redirects to register page
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RegisterPage()),
                  );
                },
                child: const Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
