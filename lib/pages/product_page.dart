// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:shop_flutter/controllers/db_controller.dart';
import 'package:shop_flutter/management_mobx.dart/management.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final management = Management();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Produto'),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 200,
              width: 200,
              child: Image.network("${productSelected!.imagem}"),
            ),
            Text('${productSelected!.name}'),
            const SizedBox(
              height: 20,
            ),
            Text('${productSelected!.description}'),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.yellow)),
                onPressed: () async {
                  final resp = await management.addCart(productSelected!);
                  if (resp == true) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Produto adicionado ao carrinho'), duration: Duration(milliseconds: 700),));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content:
                            Text('Erro ao adicionar produto ao carrinho'), duration: Duration(milliseconds: 700),));
                  }
                },
                child: const Text(
                  'Adiconar ao Carrinho',
                  style: TextStyle(color: Colors.black),
                )),
          ],
        ),
      ),
    );
  }
}
