import 'package:flutter/material.dart';
import 'package:saku_in/drawer.dart';
import 'package:saku_in/auth/page/login_page.dart';
import 'package:saku_in/toast.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final repeatPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final request = context.read<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
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
              ),
              TextFormField(
                controller: passwordController,
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
                obscureText: true,
              ),
              TextFormField(
                controller: repeatPasswordController,
                decoration: const InputDecoration(
                  icon: Icon(Icons.lock),
                  hintText: 'Confirm Password',
                  labelText: 'Confirm Password',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                obscureText: true,
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () async {
                  // Validate returns true if the form is valid, or false otherwise.
                  if (_formKey.currentState!.validate()) {
                    final response = await request.post(
                        "https://saku-in.up.railway.app/authentication/register/",
                        {
                          'username': usernameController.text,
                          'password1': passwordController.text,
                          'password2': repeatPasswordController.text,
                        }).then((value) => {
                          if (value['status'])
                            {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginPage()),
                              ),
                            }
                          else
                            {toast(context, true, value['message'])}
                        });
                  }
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
