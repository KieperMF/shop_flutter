import 'package:flutter/material.dart';
import 'package:shop_flutter/pages/register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          children: [
            TextField(),
            TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const RegisterPage()));
                },
                child: const Text(
                  'Fazer Cadastro',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                )),
          ],
        ),
      ),
    );
  }
}
