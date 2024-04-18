import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:shop_flutter/controllers/db_controller.dart';
import 'package:shop_flutter/management_mobx.dart/management.dart';
import 'package:shop_flutter/pages/login_page.dart';
import 'package:shop_flutter/pages/product_page.dart';

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
    await management.getProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 200,
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics:const BouncingScrollPhysics(),
                        itemCount: management.products.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              SizedBox(
                                  height: 200,
                                  child: TextButton(
                                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white)),
                                    onPressed: (){
                                      productSelected = management.products.elementAt(index);
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => const ProductPage()));
                                    },
                                    child: Image.network(
                                        '${management.products.elementAt(index).imagem}'),
                                  )),
                              Text('${management.products.elementAt(index).name}'),
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
    );
  }
}
