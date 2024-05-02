import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:shop_flutter/controllers/product_controller.dart';
import 'package:shop_flutter/management_mobx.dart/management.dart';
import 'package:shop_flutter/pages/product_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final management = Management();

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
          backgroundColor: Colors.blueGrey[800],
          automaticallyImplyLeading: false,
          title: const Text('Shop Flutter', style: TextStyle(color: Colors.white),),
        ),
        backgroundColor: Colors.blueGrey[700],
        body: SingleChildScrollView(
          child: Observer(
            builder: (context) {
              return Center(
                child: Column(
                  children: [
                    const SizedBox(height: 15,),
                    const Padding(
                      padding: EdgeInsets.only(left: 16),
                      child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            "Eletrônicos",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          )),
                    ),
                    SizedBox(
                      height: 210,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          itemCount: management.eletrocicProducts.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(20),
                              child: Row(
                                children: [                             
                                  Container(
                                    color: Colors.white,
                                      height: 180,
                                      width: 180,
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
                                ],
                              ),
                            );
                          }),
                    ),
                    const SizedBox(height: 15,),
                    const Padding(
                      padding: EdgeInsets.only(left: 16),
                      child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            "Games",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          )),
                    ),
                    SizedBox(
                      height: 210,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          itemCount: management.gameProducts.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:const EdgeInsets.all(20),
                              child: Row(
                                children: [                             
                                  Container(
                                    color: Colors.white,
                                      height: 180,
                                      width: 180,
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
                                ],
                              ),
                            );
                          }),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 16),
                      child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            "Periféricos",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          )),
                    ),
                    SizedBox(
                      height: 210,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          itemCount: management.peripheralsProducts.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:const EdgeInsets.all(20),
                              child: Row(
                                children: [                             
                                  Container(
                                    color: Colors.white,
                                      height: 180,
                                      width: 180,
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
                                ],
                              ),
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
