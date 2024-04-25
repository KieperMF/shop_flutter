import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:shop_flutter/management_mobx.dart/management.dart';
import 'package:shop_flutter/pages/edit_page.dart';
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
          automaticallyImplyLeading: false,
          title: const Text('Perfil'),
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
        body: Observer(builder: (context) {
          return Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                _loading
                    ? const Padding(
                        padding: EdgeInsets.all(32),
                        child: CircularProgressIndicator())
                    : management.userPic != null
                        ? SizedBox(
                            width: 150,
                            height: 150,
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5)),
                              child: Image.network(
                                management.userPic!,
                                height: 150,
                              ),
                            ),
                          )
                        : const SizedBox(
                            height: 150,
                            width: 150,
                            child: Icon(
                              Icons.account_box,
                              size: 150,
                            ),
                          ),
                const SizedBox(
                  height: 20,
                ),
                if(management.userPic != null)...[
                  IconButton(
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
                    icon: const Icon(Icons.edit)),
                ],
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
            ),
          );
        }),
      ),
    );
  }
}
