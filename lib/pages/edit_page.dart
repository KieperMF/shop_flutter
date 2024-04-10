import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditPage extends StatefulWidget {
  const EditPage({super.key});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final prodNameController = TextEditingController();
  final prodPriceController = TextEditingController();
  String? productImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:const Text('Adicionar Produtos'),),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              IconButton(onPressed: () async {
                final response = await ImagePicker().pickImage(source: ImageSource.gallery);
                productImage = response!.path;
              }, icon:const Icon(Icons.add_box_rounded, size: 160,)),
              const SizedBox(height: 20,),
              SizedBox(
                width: 250,
                child: TextField(
                  controller: prodNameController,
                  decoration:const InputDecoration(hintText: 'Informe o nome do produto'),
                ),
              ),
              const SizedBox(height: 30,),
              SizedBox(
                width: 250,
                child: TextField(
                  controller: prodPriceController,
                  decoration:const InputDecoration(hintText: 'Informe o preço do produto'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}