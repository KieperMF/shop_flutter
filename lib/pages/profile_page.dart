import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:shop_flutter/management_mobx.dart/management.dart';
import 'package:shop_flutter/pages/add_product_page.dart';
import 'package:shop_flutter/pages/edit_product_page.dart';
import 'package:shop_flutter/pages/login_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final management = Management();
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    load();
  }

  Future<void> load() async {
    await management.getUser();
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          shape: Border.all(strokeAlign: BorderSide.strokeAlignOutside),
          backgroundColor: const Color.fromRGBO(12, 74, 110, 1.0),
          automaticallyImplyLeading: false,
          title: const Text('Perfil', style: TextStyle(color: Colors.white),),
          actions: [
            IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const LoginPage()));
              },
              icon: const Icon(Icons.logout, color: Colors.white,),
            ),
          ],
        ),
        backgroundColor: const Color.fromRGBO(8, 47, 73, 1.0),
        body: Observer(builder: (context) {
          return Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                _loading
                    ? const CircleAvatar(maxRadius: 80, child: CircularProgressIndicator(color: Colors.red,))
                    : management.userPic != null
                        ? CircleAvatar(
                          backgroundImage: 
                          NetworkImage(
                            management.userPic!),
                          maxRadius: 80,)
                        : const SizedBox(
                            height: 120,
                            width: 120,
                            child: Icon(
                              Icons.account_box,
                              size: 150,
                            ),
                          ),
                const SizedBox(
                  height: 20,
                ),
                if (management.userPic != null) ...[
                  ElevatedButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                content: const Text("Trocar foto de perfil?"),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Cancelar')),
                                  TextButton(
                                      onPressed: () {
                                        management.pickImageFromGallery();
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Confirmar')),
                                ],
                              );
                            });
                      },
                      child: const Text(
                        'Trocar foto de perfil',style: TextStyle(color: Colors.black),
                      )),
                ],
                if (management.userPic == null) ...[
                  SizedBox(
                    child: ElevatedButton(
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
                    child: Text('${management.user!.displayName}', 
                    style:const TextStyle(
                      color: Colors.white, 
                    fontSize: 20),),
                  ),
                ),
                if (management.user!.uid == management.adminId) ...[
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:const MaterialStatePropertyAll(Color.fromARGB(255, 67, 139, 167)),
                            minimumSize:
                                MaterialStateProperty.all(const Size(200, 37))),
                        child: const Text('Adicionar Produtos', style: TextStyle(color: Colors.white),),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const AddProductPage()));
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const EditProductPage()));
                          },
                          style: ButtonStyle(
                            backgroundColor:const MaterialStatePropertyAll(Color.fromARGB(255, 67, 139, 167)),
                              minimumSize: MaterialStateProperty.all(
                                  const Size(200, 37))),
                          child: const Text("Editar Produtos", style: TextStyle(color: Colors.white),)),
                    ),
                  )
                ],
              ],
            ),
          );
        }),
      ),
    );
  }
}
