import 'package:flutter/material.dart';
import 'package:shop_flutter/management_mobx.dart/management.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final management = Management();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title:const Text('Carrinho'),),
        body:Center(
              child: Column(
                children: [
                ],
              ),
            ),
    );
  }
}