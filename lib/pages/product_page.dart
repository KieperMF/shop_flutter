import 'package:flutter/material.dart';
import 'package:shop_flutter/controllers/db_controller.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Produto'),),
        body:Center(
              child: Column(
                children: [
                  Text('${productSelected!.name}')
                ],
              ),
            ),
    );
  }
}