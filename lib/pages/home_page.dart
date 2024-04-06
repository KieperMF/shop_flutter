import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_picker/image_picker.dart';
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
        automaticallyImplyLeading: false,
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
      body: Observer(
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
                  height: 400,
                  child: management.selectedImage != null
                      ? Image.file(File(management.selectedImage!))
                      : const Text('Selecione uma imagem'),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Future _pickImageFromGallery() async {
    final responseImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      selectedImage = File(responseImage!.path);
    });
  }
}
