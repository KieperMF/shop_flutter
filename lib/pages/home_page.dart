import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:shop_flutter/management_mobx.dart/management.dart';
import 'package:shop_flutter/pages/edit_page.dart';
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
    await management.getProduct();
    //debugPrint('produtos: ${management.products.first}');
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
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 200,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: management.products.length,
                      itemBuilder: (context, index){
                        management.product = management.products.elementAt(index);
                        return Column(
                          children: [
                            SizedBox(height: 150,child: Image.network('${management.product!.imagem}')),
                            Text('${management.product!.name}')
                          ],
                        );
                      }),
                  )
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
              const SizedBox(
                height: 30,
              ),
              management.userPic != null
                  ? SizedBox(
                      width: 100,
                      height: 100,
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5)),
                          child: Image.network('${management.userPic!}')),
                    )
                  : const SizedBox(
                      height: 100,
                      width: 100,
                      child: Icon(
                        Icons.account_box,
                        size: 100,
                      ),
                    ),
              const SizedBox(
                height: 20,
              ),
              if (management.userPic == null) ...[
                SizedBox(
                  child: TextButton(
                      onPressed: () {
                        management.pickImageFromGallery();
                      },
                      child: const Text('Selecione uma foto de perfil')),
                ),
              ],
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text('${management.user!.displayName}'),
                ),
              ),
              if (management.user!.uid == management.adminId) ...[
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: TextButton(
                      child: const Text('Adicionar Produtos'),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const EditPage()));
                      },
                    ),
                  ),
                ),
              ],
            ],
          );
        }),
      ),
    );
  }
}
