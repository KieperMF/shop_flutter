// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:shop_flutter/management_mobx.dart/management.dart';
import 'package:shop_flutter/models/product_model.dart';

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
    await management.getProduct();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          shape: Border.all(strokeAlign: BorderSide.strokeAlignOutside),
          backgroundColor: const Color.fromRGBO(12, 74, 110, 1.0),
          automaticallyImplyLeading: false,
          title: const Text('Carrinho', style: TextStyle(color: Colors.white),),
        ),
        backgroundColor: const Color.fromRGBO(8, 47, 73, 1.0),
        body: Observer(builder: (context) {
          return SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Subtotal: \$${management.total.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  management.cartProducts.isEmpty
                      ? const Text('Nenhum item no carrinho')
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemCount: management.cartProducts.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  const Divider(),
                                  Row(
                                    children: [
                                      IconButton(
                                          onPressed: () async {
                                            showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    title: const Text(
                                                      "Remover Produto do Carrinho?",
                                                      style: TextStyle(
                                                          fontSize: 18),
                                                    ),
                                                    actions: [
                                                      TextButton(
                                                        style: TextButton
                                                            .styleFrom(
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
                                                          final resp = await management
                                                              .deleteFromCart(
                                                                  management
                                                                          .cartProducts[
                                                                      index], index);
                                                          if (resp == true) {
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                                    const SnackBar(
                                                              content: Text(
                                                                  'Produto deletado do carrinho'),
                                                              duration: Duration(
                                                                  milliseconds:
                                                                      700),
                                                            ));
                                                          } else {
                                                            ScaffoldMessenger
                                                                    .of(context)
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
                                          icon: const Icon(Icons
                                              .disabled_by_default_rounded, color: Colors.white,)),
                                      management.cartProducts[index].imagem !=
                                              null
                                          ? SizedBox(
                                              height: 160,
                                              width: 160,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                   borderRadius: BorderRadius.circular(12),
                                                    color:
                                                        Colors.white),
                                                child: Image.network(
                                                    '${management.cartProducts[index].imagem}'),
                                              ))
                                          : const Padding(
                                              padding: EdgeInsets.all(32),
                                              child:
                                                  CircularProgressIndicator()),
                                      const SizedBox(width: 16,),
                                      SizedBox(
                                        width: 140,
                                        child: Column(
                                          children: [
                                            Text(
                                                '${management.cartProducts[index].name}', style:const TextStyle(color: Colors.white),),
                                            Text(
                                                '\$${double.parse('${management.cartProducts[index].price}').toStringAsFixed(2)}', style:const TextStyle(color: Colors.white),),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 25),
                                              child: Container(
                                                height: 40,
                                                width: 110,
                                                decoration: BoxDecoration(
                                                  color: Colors.black,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16),
                                                    border: Border.all(
                                                        color: Colors.black)),
                                                child: Row(
                                                  children: [
                                                    IconButton(
                                                        onPressed: () {
                                                          int amount = int.parse(
                                                              '${management.cartProducts[index].amount}');
                                                          if (amount >= 2) {
                                                            management
                                                                .amountSelectionDecrement(
                                                                    index);
                                                          }
                                                        },
                                                        icon: const Icon(
                                                            Icons.remove,
                                                            size: 16, color: Colors.white,)),
                                                    Text(
                                                        "${management.cartProducts[index].amount}", style: TextStyle(color: Colors.white),),
                                                    IconButton(
                                                        onPressed: () {
                                                          for (Product product
                                                              in management
                                                                  .products) {
                                                            if (management
                                                                    .cartProducts[
                                                                        index]
                                                                    .name ==
                                                                product.name) {
                                                              int count = int.parse(
                                                                  '${product.amount}');
                                                              if (int.parse(
                                                                      '${management.cartProducts[index].amount}') <
                                                                  count) {
                                                                management
                                                                    .amountSelectionIncrement(
                                                                        index);
                                                              }
                                                            }
                                                          }
                                                        },
                                                        icon: const Icon(
                                                          Icons.add,
                                                          size: 16,
                                                          color: Colors.white,
                                                        )),
                                                  ],
                                                ),
                                              ),
                                            )
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
      ),
    );
  }
}
