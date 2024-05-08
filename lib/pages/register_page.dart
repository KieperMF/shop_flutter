import 'package:flutter/material.dart';
import 'package:shop_flutter/controllers/user_controller.dart';
import 'package:shop_flutter/management_mobx.dart/management.dart';
import 'package:shop_flutter/page_controller/navigation_bar.dart';

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
  final management = Management();
  bool obscurePassword = true;
  final service = UserController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(12, 74, 110, 1.0),
          title: const Text('Cadastro', style: TextStyle(color: Colors.white),),
        ),
        backgroundColor: const Color.fromRGBO(8, 47, 73, 1.0),
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
                      cursorColor: Colors.white,
                      controller: nameController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        suffixIcon: Icon(Icons.person, color: Colors.white,),
                          hintText: 'Informe seu nome',
                          hintStyle: TextStyle(color: Colors.white)),
                      validator: (String? value) {
                        if (value == null) {
                          return 'Preencha seu nome';
                        }
                        else if (value.length < 2) {
                          return 'O nome é muito curto';
                        }
                        return null;
                      },
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
                    child: TextFormField(
                      cursorColor: Colors.white,
                      controller: emailController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        suffixIcon: Icon(Icons.email, color: Colors.white,),
                          hintText: 'Email',
                          hintStyle: TextStyle(color: Colors.white)),
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
                    child: TextFormField(
                      cursorColor: Colors.white,
                      controller: passwordController,
                      style: const TextStyle(color: Colors.white),
                      obscureText: obscurePassword,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility, color: Colors.white,),
                            onPressed: () {
                              setState(() {
                                obscurePassword = !obscurePassword;
                              });
                            },
                          ),
                          hintText: 'Senha',
                          hintStyle: const TextStyle(color: Colors.white)),
                      validator: (String? value) {
                        if (value == null) {
                          return 'A senha não pode ser vazia';
                        }
                        if (value.length < 6) {
                          return 'A senha é muito curta';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                ElevatedButton(
                    onPressed: () async {
                      bool response = await service.registerVerif(
                          name: nameController.text,
                          email: emailController.text,
                          password: passwordController.text);
                      if (response == false) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Erro ao cadastrar'), duration: Duration(milliseconds: 700),));
                      } else {
                        nameController.clear();
                        emailController.clear();
                        passwordController.clear();
                        management.getUser();
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Cadastrado com Sucesso'), duration: Duration(milliseconds: 700),));
                        Future.delayed(const Duration(milliseconds: 1000), () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const NavigationBarWidget()));
                        });
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
      ),
    );
  }
}
