import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:shop_flutter/controllers/db_controller.dart';
import 'package:shop_flutter/management_mobx.dart/management.dart';
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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          shape: Border.all(strokeAlign: BorderSide.strokeAlignOutside),
          backgroundColor: Colors.grey[500],
          automaticallyImplyLeading: false,
          title: const Text('Home Page'),
        ),
        body: SingleChildScrollView(
          child: Observer(
            builder: (context) {
              return Center(
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 16),
                      child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            "Eletrônicos",
                            style: TextStyle(fontSize: 20),
                          )),
                    ),
                    SizedBox(
                      height: 210,
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          itemCount: management.eletrocicProducts.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [                             
                                SizedBox(
                                    height: 180,
                                    width: 200,
                                    child: TextButton(
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.white)),
                                      onPressed: () {
                                        productSelected = management
                                            .eletrocicProducts
                                            .elementAt(index);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const ProductPage()));
                                      },
                                      child: Image.network(
                                          '${management.eletrocicProducts.elementAt(index).imagem}'),
                                    )),
                                Text(
                                    '${management.eletrocicProducts.elementAt(index).name}'),
                                    
                              ],
                            );
                          }),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 16),
                      child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            "Games",
                            style: TextStyle(fontSize: 20),
                          )),
                    ),
                    SizedBox(
                      height: 210,
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          itemCount: management.gameProducts.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [                             
                                SizedBox(
                                    height: 180,
                                    width: 200,
                                    child: TextButton(
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.white)),
                                      onPressed: () {
                                        productSelected = management
                                            .gameProducts
                                            .elementAt(index);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const ProductPage()));
                                      },
                                      child: Image.network(
                                          '${management.gameProducts.elementAt(index).imagem}'),
                                    )),
                                Text(
                                    '${management.gameProducts.elementAt(index).name}'),
                                    
                              ],
                            );
                          }),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 16),
                      child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            "Periféricos",
                            style: TextStyle(fontSize: 20),
                          )),
                    ),
                    SizedBox(
                      height: 210,
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          itemCount: management.peripheralsProducts.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [                             
                                SizedBox(
                                    height: 180,
                                    width: 200,
                                    child: TextButton(
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.white)),
                                      onPressed: () {
                                        productSelected = management
                                            .peripheralsProducts
                                            .elementAt(index);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const ProductPage()));
                                      },
                                      child: Image.network(
                                          '${management.peripheralsProducts.elementAt(index).imagem}'),
                                    )),
                                Text(
                                    '${management.peripheralsProducts.elementAt(index).name}'),
                                    
                              ],
                            );
                          }),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
