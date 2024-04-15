import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shop_flutter/management_mobx.dart/management.dart';
import 'package:shop_flutter/models/product_model.dart';

class EditPage extends StatefulWidget {
  const EditPage({super.key});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final prodNameController = TextEditingController();
  final prodPriceController = TextEditingController();
  final amountController = TextEditingController();
  String? productImage;
  final management = Management();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                            child: Image.file(File(management.selectedImage!))),
                      )
                    : const Icon(
                        Icons.add,
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
                    decoration:
                        const InputDecoration(hintText: 'Informe a quantidade'),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                    width: 250,
                    child: IconButton(
                        onPressed: () async{
                          Product product = Product(
                              name: prodNameController.text,
                              imagem: management.selectedImage!,
                              price: prodPriceController.text,
                              amount: amountController.text);
                          final resp = await management.addProduct(product);
                          
                          if(resp == true){
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Produto adicionado com sucesso')));
                            await management.getProduct();
                          }else{
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Erro ao adicionar produto')));
                          }
                        },
                        icon: const Icon(Icons.add))),
              ],
            ),
          );
        }),
      ),
    );
  }
}
