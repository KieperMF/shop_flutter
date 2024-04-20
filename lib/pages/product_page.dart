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
            TextButton(onPressed: (){
              management.addCart(productSelected!);
            }, child: const Text('Adiconar ao Carrinho')),
          ],
        ),
      ),
    );
  }
}
