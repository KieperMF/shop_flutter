import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:shop_flutter/management_mobx.dart/management.dart';
import 'package:shop_flutter/pages/edit_page.dart';

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
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Perfil'),
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
                          width: 100,
                          height: 100,
                          child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5)),
                              child: Image.network(management.userPic!)),
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
          ),
        );
      }),
    );
  }
}
