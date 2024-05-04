import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
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
          backgroundColor: const Color.fromRGBO(12, 74, 110, 1.0),
          automaticallyImplyLeading: false,
          title: const Text(
            'Shop Flutter',
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: const Color.fromRGBO(8, 47, 73, 1.0),
        body: SingleChildScrollView(
          child: Observer(
            builder: (context) {
              return Center(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    const Padding(  
                      padding: EdgeInsets.only(left: 16),
                      child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            "Mais Vendidos",
                            style: TextStyle(fontSize: 24, color: Colors.white),
                          )),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    CarouselSlider.builder(
                        itemCount: management.eletrocicProducts.length,
                        itemBuilder: (BuildContext context, int itemIndex,
                            int pageViewIndex) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              border: Border.all(color:const Color.fromRGBO(75, 85, 99,1), width: 2),
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.white),
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            child: management.eletrocicProducts.isNotEmpty ? 
                            Image.network("${management.eletrocicProducts[itemIndex].imagem}") : 
                                const Icon(Icons.image, size: 200,));
                        },
                        options: CarouselOptions(
                          height: 230,
                          autoPlay: true,
                          autoPlayCurve: Curves.easeInSine,
                          autoPlayAnimationDuration:
                              const Duration(milliseconds: 1500),
                        )),
                    const SizedBox(
                      height: 15,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 16),
                      child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            "Livros",
                            style: TextStyle(fontSize: 22, color: Colors.white),
                          )),
                    ),
                    SizedBox(
                      height: 210,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          itemCount: management.books.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(20),
                              child: Row(
                                children: [
                                  Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(color: const Color.fromRGBO(75, 85, 99,1), width: 2),
                                          borderRadius:
                                              BorderRadius.circular(16)),
                                      height: 180,
                                      width: 180,
                                      child: TextButton(
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.white)),
                                        onPressed: () {
                                          productSelected =
                                              management.books.elementAt(index);
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const ProductPage()));
                                        },
                                        child: Image.network(
                                            '${management.books.elementAt(index).imagem}'),
                                      )),
                                ],
                              ),
                            );
                          }),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 16),
                      child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            "Games",
                            style: TextStyle(fontSize: 22, color: Colors.white),
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
                              padding: const EdgeInsets.all(20),
                              child: Row(
                                children: [
                                  Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(color: const Color.fromRGBO(75, 85, 99,1), width: 2),
                                          borderRadius:
                                              BorderRadius.circular(16)),
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
                            "Eletrônicos",
                            style: TextStyle(fontSize: 22, color: Colors.white),
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
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(color: const Color.fromRGBO(75, 85, 99,1), width: 2),
                                          borderRadius:
                                              BorderRadius.circular(16)),
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
                    const Padding(
                      padding: EdgeInsets.only(left: 16),
                      child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            "Periféricos",
                            style: TextStyle(fontSize: 22, color: Colors.white),
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
                              padding: const EdgeInsets.all(20),
                              child: Row(
                                children: [
                                  Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(color: const Color.fromRGBO(75, 85, 99,1), width: 2),
                                          borderRadius:
                                              BorderRadius.circular(16)),
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
                    const Padding(
                      padding: EdgeInsets.only(left: 16),
                      child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            "Decoração",
                            style: TextStyle(fontSize: 22, color: Colors.white),
                          )),
                    ),
                    SizedBox(
                      height: 210,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          itemCount: management.decorationProducts.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(20),
                              child: Row(
                                children: [
                                  Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(color: const Color.fromRGBO(75, 85, 99,1), width: 2),
                                          borderRadius:
                                              BorderRadius.circular(16)),
                                      height: 180,
                                      width: 180,
                                      child: TextButton(
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.white)),
                                        onPressed: () {
                                          productSelected = management
                                              .decorationProducts
                                              .elementAt(index);
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const ProductPage()));
                                        },
                                        child: Image.network(
                                            '${management.decorationProducts.elementAt(index).imagem}'),
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
