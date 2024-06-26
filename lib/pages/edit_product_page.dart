import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:shop_flutter/management_mobx.dart/management.dart';
import 'package:shop_flutter/models/product_model.dart';

class EditProductPage extends StatefulWidget {
  const EditProductPage({super.key});

  @override
  State<EditProductPage> createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  final managment = Management();
  List<bool> _isVisibleList = [];
  List<String> list = <String>['Eletrônico', 'Games', 'Periférico', 'Decoração', 'Livros'];
  String dropdownValue = 'Eletrônico';
  List<TextEditingController> nameController = [];
  List<TextEditingController> priceController = [];
  List<TextEditingController> amountController = [];
  List<TextEditingController> categoryController = [];
  List<TextEditingController> descriptionController = [];

  void _toggleVisibility(int index) {
    setState(() {
      _isVisibleList[index] = !_isVisibleList[index];
    });
  }

  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() async {
    await managment.getProduct();
    setState(() {
      _isVisibleList =
          List.generate(managment.products.length, (index) => false);
      nameController = List.generate(
          managment.products.length, (index) => TextEditingController());
      priceController = List.generate(
          managment.products.length, (index) => TextEditingController());
      amountController = List.generate(
          managment.products.length, (index) => TextEditingController());
      categoryController = List.generate(
          managment.products.length, (index) => TextEditingController());
      descriptionController = List.generate(
          managment.products.length, (index) => TextEditingController());
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Observer(builder: (context) {
        return Scaffold(
            appBar: AppBar(
              backgroundColor: const Color.fromRGBO(12, 74, 110, 1.0),
              title: const Text(
                'Editar Produtos',
                style: TextStyle(color: Colors.white),
              ),
            ),
            backgroundColor: const Color.fromRGBO(8, 47, 73, 1.0),
            body: SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: 350,
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemCount: managment.products.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                GestureDetector(
                                  onTap: () => _toggleVisibility(index),
                                  child: Container(
                                      color: const Color.fromRGBO(12, 74, 110, 1.0),
                                      padding: const EdgeInsets.all(12),
                                      child: Padding(
                                        padding: const EdgeInsets.all(16),
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              height: 150,
                                              width: 150,
                                              child: Container(
                                                decoration: const BoxDecoration(
                                                    color: Colors.white),
                                                child: Image.network(
                                                    "${managment.products[index].imagem}"),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            SizedBox(
                                              width: 120,
                                              child: Text(
                                                '${managment.products[index].name}',
                                                style: const TextStyle(
                                                    fontSize: 20),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )),
                                ),
                                AnimatedContainer(
                                  duration: const Duration(milliseconds: 800),
                                  curve: Curves.easeInOut,
                                  height: _isVisibleList[index] ? 470 : 0,
                                  width: 450,
                                  color: const Color.fromRGBO(12, 74, 110, 1.0),
                                  child: _isVisibleList[index]
                                      ? SingleChildScrollView(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          child: Column(children: [
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            SizedBox(
                                              width: 180,
                                              child: TextField(
                                                cursorColor: Colors.white,
                                                controller:
                                                    nameController[index],
                                                style: const TextStyle(
                                                    color: Colors.white),
                                                decoration: InputDecoration(
                                                    hintText:
                                                        '${managment.products[index].name}',
                                                    hintStyle: const TextStyle(
                                                        color: Colors.white),
                                                    border: const OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                Colors.black),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    16)))),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            SizedBox(
                                              width: 180,
                                              child: TextField(
                                                cursorColor: Colors.white,
                                                controller:
                                                    amountController[index],
                                                keyboardType:
                                                    TextInputType.number,
                                                style: const TextStyle(
                                                    color: Colors.white),
                                                decoration: InputDecoration(
                                                    hintText:
                                                        'Quantidade: ${managment.products[index].amount}',
                                                    hintStyle: const TextStyle(
                                                        color: Colors.white),
                                                    border: const OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                Colors.white),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    16)))),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            SizedBox(
                                              width: 180,
                                              child: TextField(
                                                cursorColor: Colors.white,
                                                controller:
                                                    priceController[index],
                                                keyboardType:
                                                    TextInputType.number,
                                                style: const TextStyle(
                                                    color: Colors.white),
                                                decoration: InputDecoration(
                                                    hintText:
                                                        'Preço: ${managment.products[index].price}',
                                                    hintStyle: const TextStyle(
                                                        color: Colors.white),
                                                    border: const OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                Colors.black),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    16)))),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            SizedBox(
                                              width: 180,
                                              child: DropdownButton<String>(
                                                dropdownColor: const Color.fromRGBO(8, 47, 73, 1.0),
                                                value: managment.products[index].category,
                                                icon: const Icon(Icons.arrow_downward, color: Colors.white,),
                                                elevation: 16,
                                                style: const TextStyle(color: Colors.white),
                                                underline: Container(
                                                  height: 2,
                                                  color: Colors.grey,
                                                ),
                                                onChanged: (String? value) {
                                                  setState(() {
                                                    dropdownValue = value!;
                                                    managment.products[index].category = value;
                                                  });
                                                },
                                                items: list.map<DropdownMenuItem<String>>((String value) {
                                                  return DropdownMenuItem<String>(
                                                    value: value,
                                                    child: Text(value),
                                                  );
                                                }).toList(),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            SizedBox(
                                              width: 180,
                                              child: TextField(
                                                cursorColor: Colors.white,
                                                controller:
                                                    descriptionController[
                                                        index],
                                                style: const TextStyle(
                                                    color: Colors.white),
                                                decoration: const InputDecoration(
                                                    labelStyle: TextStyle(
                                                        color: Colors.white),
                                                    hintText: 'Descrição',
                                                    hintStyle: TextStyle(
                                                        color: Colors.white),
                                                    border: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                Colors.black),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    16)))),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  height: 30,
                                                  child: ElevatedButton(
                                                      onPressed: () {
                                                        showDialog(
                                                            context: context,
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              return AlertDialog(
                                                                title: const Text(
                                                                    'Deseja excluir este Produto'),
                                                                actions: [
                                                                  TextButton(
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.of(context)
                                                                            .pop();
                                                                      },
                                                                      child: const Text(
                                                                          'Cancelar')),
                                                                  Observer(builder:
                                                                      (context) {
                                                                    return TextButton(
                                                                        onPressed:
                                                                            () async {
                                                                          await managment.deleteProduct(
                                                                              managment.products[index],
                                                                              index);
                                                                          setState(
                                                                              () {
                                                                            _isVisibleList[index] =
                                                                                false;
                                                                          });
                                                                          Navigator.of(context)
                                                                              .pop();
                                                                          ScaffoldMessenger.of(context)
                                                                              .showSnackBar(const SnackBar(
                                                                            content:
                                                                                Text('Produto Deletado'),
                                                                            duration:
                                                                                Duration(milliseconds: 600),
                                                                          ));
                                                                        },
                                                                        child: const Text(
                                                                            'Deletar'));
                                                                  })
                                                                ],
                                                              );
                                                            });
                                                      },
                                                      style: const ButtonStyle(
                                                          backgroundColor:
                                                              MaterialStatePropertyAll(
                                                                  Colors
                                                                      .yellow)),
                                                      child: Image.asset(
                                                          'assets/trash_icon.png')),
                                                ),
                                                const SizedBox(
                                                  width: 20,
                                                ),
                                                SizedBox(
                                                  height: 30,
                                                  child: ElevatedButton(
                                                      onPressed: () async {
                                                        Product product = Product(
                                                            amount:amountController[index].text,
                                                            category: categoryController[index].text,
                                                            description:descriptionController[index].text,
                                                            name:nameController[index].text,
                                                            price:priceController[index].text);
                                                        await managment.updateProduct(product,managment.products[index]);
                                                        if (await managment.updateProduct(product,managment.products[index])) {
                                                          managment.getProduct();
                                                          ScaffoldMessenger.of(context).
                                                          showSnackBar(const SnackBar(
                                                            duration: Duration(milliseconds: 500), 
                                                            content: Text("Produto atualizado")));
                                                        }
                                                      },
                                                      style: const ButtonStyle(
                                                          backgroundColor:
                                                              MaterialStatePropertyAll(
                                                                  Colors
                                                                      .yellow)),
                                                      child: const Icon(
                                                        Icons.edit,
                                                        color: Colors.black,
                                                      )),
                                                ),
                                              ],
                                            ),
                                          ]),
                                        )
                                      : null,
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                              ],
                            );
                          }),
                    )
                  ],
                ),
              ),
            ), );
      }),
    );
  }
}
