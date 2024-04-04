import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:shop_flutter/controllers/db_controller.dart';
import 'package:shop_flutter/management_mobx.dart/management.dart';
import 'package:shop_flutter/pages/login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final service = DbController();
  User? user;
  final management = Management();

  @override
  void initState() {
    super.initState();
    load();
  }

  Future<void> load() async {
    management.user = await management.getUser();
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
                if(management.user !=null)...[
                  Text("Welcome ${management.user!.displayName}"),
                Text('${management.user!.email}'),
                ]else...[
                  Text('fodase'),
                ],
                
              ],
            ),
          );
        },
      ),
    );
  }
}
