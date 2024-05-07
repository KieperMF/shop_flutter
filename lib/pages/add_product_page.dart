// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shop_flutter/management_mobx.dart/management.dart';
import 'package:shop_flutter/models/product_model.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final prodNameController = TextEditingController();
  final prodDescController = TextEditingController();
  final prodPriceController = TextEditingController();
  final amountController = TextEditingController();
  final management = Management();
  List<String> list = <String>[
    'Eletrônico',
    'Games',
    'Periférico',
    'Decoração',
    'Livros'
  ];
  String dropdownValue = 'Eletrônico';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(12, 74, 110, 1.0),
          title: const Text(
            'Adicionar Produtos',
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: const Color.fromRGBO(8, 47, 73, 1.0),
        body: SingleChildScrollView(
          child: Observer(builder: (context) {
            return Center(
              child: Column(
                children: [
                  management.selectedImage != null
                      ? SizedBox(
                          height: 150,
                          width: 150,
                          child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5)),
                              child:
                                  Image.file(File(management.selectedImage!))),
                        )
                      : const Icon(
                          Icons.image,
                          size: 100,
                        ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        final response = await ImagePicker()
                            .pickImage(source: ImageSource.gallery);
                        management.selectedImage = response!.path;
                      },
                      child: const Text(
                        'Selecionar imagem',
                        style: TextStyle(color: Colors.black),
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 250,
                    child: TextField(
                      cursorColor: Colors.white,
                      controller: prodNameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                          hintText: 'Informe o nome do produto', hintStyle: TextStyle(color: Colors.white)),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: 250,
                    child: TextField(
                      cursorColor: Colors.white,
                      controller: prodPriceController,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                          hintText: 'Informe o preço do produto', hintStyle: TextStyle(color: Colors.white)),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: 250,
                    child: TextField(
                      cursorColor: Colors.white,
                      controller: amountController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                          hintText: 'Informe a quantidade', hintStyle: TextStyle(color: Colors.white)),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: 250,
                    child: TextField(
                      cursorColor: Colors.white,
                      controller: prodDescController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                          hintText: 'Descrição do produto', hintStyle: TextStyle(color: Colors.white)),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  DropdownButton<String>(
                    value: dropdownValue,
                    dropdownColor: Colors.black,
                    icon: const Icon(Icons.arrow_downward, color: Colors.white,),
                    elevation: 16,
                    style: const TextStyle(color: Colors.white),
                    underline: Container(
                      height: 2,
                      color: Colors.black,
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        dropdownValue = value!;
                      });
                    },
                    items: list.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  SizedBox(
                      width: 250,
                      child: IconButton(
                          onPressed: () async {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text(
                                        "Deseja Adicionar esse produto?"),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text("Cancelar")),
                                      TextButton(
                                          onPressed: () async {
                                            int idP = await management
                                                    .getProductLength() +
                                                1;
                                            Product product = Product(
                                                category: dropdownValue,
                                                id: idP,
                                                description:
                                                    prodDescController.text,
                                                name: prodNameController.text,
                                                imagem:
                                                    management.selectedImage!,
                                                price: prodPriceController.text,
                                                amount: amountController.text);
                                            final resp = await management
                                                .addProduct(product);
                                            if (resp == true) {
                                              prodDescController.clear();
                                              prodNameController.clear();
                                              prodPriceController.clear();
                                              amountController.clear();
                                              management.selectedImage = null;
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                content: Text(
                                                    'Produto adicionado com sucesso'),
                                                duration:
                                                    Duration(milliseconds: 700),
                                              ));
                                              Navigator.of(context).pop();
                                              await management.getProduct();
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                content: Text(
                                                    'Erro ao adicionar produto'),
                                                duration:
                                                    Duration(milliseconds: 700),
                                              ));
                                            }
                                          },
                                          child: const Text("Adicionar"))
                                    ],
                                  );
                                });
                          },
                          icon: const Icon(Icons.add, color: Colors.white,))),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
