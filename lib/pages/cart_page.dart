// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:shop_flutter/management_mobx.dart/management.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final management = Management();

  @override
  void initState() {
    super.initState();
    loadProducts();
  }

  loadProducts() async {
    await management.getCartProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Carrinho'),
      ),
      body: Observer(builder: (context) {
        return SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                management.cartProducts.isEmpty
                    ? const Text('Nenhum item no carrinho')
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: management.cartProducts.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    IconButton(
                                        onPressed: () async {
                                          final resp = await management
                                              .deleteFromCart(management
                                                  .cartProducts[index]);
                                          if (resp == true) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                    content: Text(
                                                        'Produto deletado do carrinho')));
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                    content: Text(
                                                        'Erro ao deletar produto')));
                                          }
                                        },
                                        icon: const Icon(
                                            Icons.disabled_by_default_rounded)),
                                    SizedBox(
                                      height: 200,
                                      width: 200,
                                      child: Image.network(
                                          '${management.cartProducts[index].imagem}'),
                                    ),
                                    SizedBox(
                                      width: 140,
                                      child: Column(
                                        children: [
                                          Text(
                                              '${management.cartProducts[index].name}'),
                                          Text(
                                              '\$${management.cartProducts[index].price}'),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        })
              ],
            ),
          ),
        );
      }),
    );
  }
}
