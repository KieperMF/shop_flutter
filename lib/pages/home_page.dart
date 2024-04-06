import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:shop_flutter/management_mobx.dart/management.dart';
import 'package:shop_flutter/pages/login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final management = Management();
  File? selectedImage;

  @override
  void initState() {
    super.initState();
    load();
  }

  Future<void> load() async {
    await management.getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const LoginPage()));
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Observer(
          builder: (context) {
            return Center(
              child: Column(
                children: [
                  Text("Welcome ${management.user!.displayName}"),
                  MaterialButton(
                      child: const Text(
                        'Selecione uma imagem',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      onPressed: () {
                        management.pickImageFromGallery();
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 200,
                    width: 200,
                    child: management.selectedImage != null
                        ? Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5)),
                            child: Image.file(File(management.selectedImage!)))
                        : const Text('Selecione uma imagem'),
                  ),
                  const SizedBox(height: 20,),
                ],
              ),
            );
          },
        ),
      ),
      drawer: Drawer(
        child: Observer(builder: (context) {
          return Column(
            children: [
              const SizedBox(height: 30,),
              management.selectedImage != null
                  ? SizedBox(
                    width: 100,
                    height: 100,
                    child: Container(
                        decoration:
                            BoxDecoration(borderRadius: BorderRadius.circular(5)),
                        child: Image.file(File(management.selectedImage!))),
                  )
                  : const SizedBox(
                      height: 100,
                      width: 100,
                      child:  Icon(Icons.account_box, size: 100,),
                    ),
                    const SizedBox(height: 20,),
                    SizedBox(
                      child: TextButton(onPressed: (){
                        management.pickImageFromGallery();
                      }, child:const Text('Selecione uma foto de perfil')),
                    ),
                    const SizedBox(height: 20,),
                    SizedBox(
                      child: Text('${management.user!.displayName}'),
                    )
            ],
          );
        }),
      ),
    );
  }
}
