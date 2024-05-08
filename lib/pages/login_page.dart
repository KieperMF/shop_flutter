import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shop_flutter/controllers/user_controller.dart';
import 'package:shop_flutter/management_mobx.dart/management.dart';
import 'package:shop_flutter/page_controller/navigation_bar.dart';
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
  final service = UserController();
  final management = Management();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(12, 74, 110, 1.0),
          title: const Text('Login', style: TextStyle(color: Colors.white),),
          automaticallyImplyLeading: false,
        ),
        backgroundColor: const Color.fromRGBO(8, 47, 73, 1.0),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 300,
                width: 350,
                child: Card(
                  color: const Color.fromRGBO(7, 89, 133, 1.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 10,),
                      SizedBox(
                  width: 300,
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(5.0)),
                    child: TextField(
                      textAlign: TextAlign.center,
                      cursorColor: Colors.white,
                      controller: emailController,
                      style: const TextStyle(color: Colors.white),
                      decoration:const InputDecoration(hintText: 'Email', hintStyle: TextStyle(color: Colors.white), 
                      suffixIcon: Icon(Icons.email, color: Colors.white,)),
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
                      textAlign: TextAlign.center,
                      cursorColor: Colors.white,
                      controller: passwordController,
                      obscureText: obscurePassword,
                      style: const TextStyle(color: Colors.white,),
                      decoration: InputDecoration(hintText: 'Senha',hintStyle:const TextStyle(color: Colors.white),
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  obscurePassword = !obscurePassword;
                                });
                              },
                              icon: Icon(obscurePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility, color: Colors.white,))),
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
                    icon: const Icon(Icons.login, color: Colors.white,)),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
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
            ],
          ),
        ),
      ),
    );
  }
}
