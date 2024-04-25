import 'package:flutter/material.dart';
import 'package:shop_flutter/controllers/db_controller.dart';
import 'package:shop_flutter/management_mobx.dart/management.dart';
import 'package:shop_flutter/pages/navigation_bar.dart';
import 'package:shop_flutter/pages/register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool obscurePassword = true;
  final service = DbController();
  final management = Management();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
          automaticallyImplyLeading: false,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 300,
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(5.0)),
                  child: TextField(
                    controller: emailController,
                    decoration:const InputDecoration(hintText: 'Email', hintStyle: TextStyle(color: Colors.black)),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 300,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: TextField(
                    controller: passwordController,
                    obscureText: obscurePassword,
                    decoration: InputDecoration(hintText: 'Senha',hintStyle:const TextStyle(color: Colors.black),
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                obscurePassword = !obscurePassword;
                              });
                            },
                            icon: Icon(obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility))),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              IconButton(
                  onPressed: () async {
                    bool response = await service.loginVerif(
                        email: emailController.text,
                        password: passwordController.text);
                    if (response == false) {
                      debugPrint('$response');
                      emailController.clear();
                      passwordController.clear();
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Credenciais Inválidas'), duration: Duration(milliseconds: 700),));
                    } else {
                      management.getUser();
                      emailController.clear();
                      passwordController.clear();
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Logado com sucesso'), duration: Duration(milliseconds: 700),));
                      Future.delayed(const Duration(milliseconds: 1000), () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const NavigationBarWidget()));
                      });
                    }
                  },
                  icon: const Icon(Icons.login)),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const RegisterPage()));
                  },
                  child: const Text(
                    'Não tem uma conta? Fazer Cadastro',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
