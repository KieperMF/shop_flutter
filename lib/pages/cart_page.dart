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
  double total = 0;

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
                Text(
                  'Subtotal: \$${management.total}',
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(
                  height: 20,
                ),
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
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: const Text(
                                                    "Remover Produto do Carrinho?",
                                                    style:
                                                        TextStyle(fontSize: 18),
                                                  ),
                                                  actions: [
                                                    TextButton(
                                                      style:
                                                          TextButton.styleFrom(
                                                        textStyle:
                                                            Theme.of(context)
                                                                .textTheme
                                                                .labelLarge,
                                                      ),
                                                      child: const Text(
                                                        'Cancelar',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black),
                                                      ),
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    ),
                                                    TextButton(
                                                      child: const Text(
                                                        'Remover',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black),
                                                      ),
                                                      onPressed: () async {
                                                        final resp =
                                                            await management
                                                                .deleteFromCart(
                                                                    management
                                                                            .cartProducts[
                                                                        index]);
                                                        if (resp == true) {
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                                  const SnackBar(
                                                            content: Text(
                                                                'Produto deletado do carrinho'),
                                                            duration: Duration(
                                                                milliseconds:
                                                                    700),
                                                          ));
                                                        } else {
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                                  const SnackBar(
                                                            content: Text(
                                                                'Erro ao deletar produto'),
                                                            duration: Duration(
                                                                milliseconds:
                                                                    700),
                                                          ));
                                                        }
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    ),
                                                  ],
                                                );
                                              });
                                        },
                                        icon: const Icon(
                                            Icons.disabled_by_default_rounded)),
                                    SizedBox(
                                      height: 150,
                                      width: 150,
                                      child: Container(
                                        decoration: BoxDecoration(color: Colors.grey.shade400),
                                        child: Image.network(
                                          '${management.cartProducts[index].imagem}'),)
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
