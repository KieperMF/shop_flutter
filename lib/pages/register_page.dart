import 'package:flutter/material.dart';
import 'package:shop_flutter/controllers/db_controller.dart';
import 'package:shop_flutter/pages/home_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool obscurePassword = true;
  final service = DbController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro'),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 300,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: TextFormField(
                    controller: nameController,
                    style: const TextStyle(color: Colors.black),
                    decoration: const InputDecoration(
                        hintText: 'Informe seu nome',
                        hintStyle: TextStyle(color: Colors.black)),
                    validator: (String? value) {
                      if (value == null) {
                        return 'Preencha seu nome';
                      }
                      if (value.length < 2) {
                        return 'O nome é muito curto';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              SizedBox(
                width: 300,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: TextFormField(
                    controller: emailController,
                    style: const TextStyle(color: Colors.black),
                    decoration: const InputDecoration(
                        hintText: 'Email',
                        hintStyle: TextStyle(color: Colors.black)),
                    validator: (String? value) {
                      if (value == null) {
                        return 'O E-mail não pode ser vazio';
                      }
                      if (!value.contains('@')) {
                        return 'E-mail Inválido';
                      }
                      if (value.length < 5) {
                        return 'O E-mail é muito curto';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              SizedBox(
                width: 300,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: TextFormField(
                    controller: passwordController,
                    style: const TextStyle(color: Colors.black),
                    obscureText: obscurePassword,
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility),
                          onPressed: () {
                            setState(() {
                              obscurePassword = !obscurePassword;
                            });
                          },
                        ),
                        hintText: 'Senha',
                        hintStyle: const TextStyle(color: Colors.black)),
                    validator: (String? value) {
                      if (value == null) {
                        return 'A senha não pode ser vazia';
                      }
                      if (value.length < 5) {
                        return 'A senha é muito curta';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              const SizedBox(height: 25,),
              ElevatedButton(
                  onPressed: () {
                    try {
                      service.registerUser(
                          name: nameController.text,
                          email: emailController.text,
                          password: passwordController.text);
                      nameController.clear();
                      emailController.clear();
                      passwordController.clear();
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const HomePage()));
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Erro ao cadastrar')));
                    }
                  },
                  style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.blue)),
                  child: const Text(
                    'Cadastrar',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}