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
  List<String> list = <String>['Eletrônico', 'Games', 'Periférico'];
  String dropdownValue = 'Eletrônico';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Adicionar Produtos'),
        ),
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
                  TextButton(
                      onPressed: () async {
                        final response = await ImagePicker()
                            .pickImage(source: ImageSource.gallery);
                        management.selectedImage = response!.path;
                      },
                      child: const Text('Selecionar imagem')),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 250,
                    child: TextField(
                      controller: prodNameController,
                      decoration: const InputDecoration(
                          hintText: 'Informe o nome do produto'),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: 250,
                    child: TextField(
                      controller: prodPriceController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          hintText: 'Informe o preço do produto'),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: 250,
                    child: TextField(
                      controller: amountController,
                      decoration: const InputDecoration(
                          hintText: 'Informe a quantidade'),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: 250,
                    child: TextField(
                      controller: prodDescController,
                      decoration: const InputDecoration(
                          hintText: 'Descrição do produto'),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  DropdownButton<String>(
                    value: dropdownValue,
                    icon: const Icon(Icons.arrow_downward),
                    elevation: 16,
                    style: const TextStyle(color: Colors.black),
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
                          icon: const Icon(Icons.add))),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}