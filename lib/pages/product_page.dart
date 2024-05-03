// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:shop_flutter/controllers/product_controller.dart';
import 'package:shop_flutter/management_mobx.dart/management.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final management = Management();

   @override
  void initState() {
    super.initState();
    load();
  }

  Future<void> load() async {
    await management.getUser();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          shape: Border.all(strokeAlign: BorderSide.strokeAlignOutside),
          backgroundColor: const Color.fromRGBO(12, 74, 110, 1.0),
          title: const Text(
            'Produto', style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: const Color.fromRGBO(8, 47, 73, 1.0),
        body: Center(
          child: Column(
            children: [
              const SizedBox(height: 16,),
              SizedBox(
                height: 200,
                width: 200,
                child: Container(color: Colors.white, child: Image.network("${productSelected!.imagem}")),
              ),
              const SizedBox(height: 16,),
              Text(
                '${productSelected!.name}',
                style: const TextStyle(fontSize: 22, color: Colors.white),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                  width: 300,
                  child: Text(
                    '${productSelected!.description}',
                    style: const TextStyle(fontSize: 20, color: Colors.white),
                  )),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                  width: 300,
                  child: Text(
                    'Preço: ${double.parse('${productSelected!.price}').toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 20, color: Colors.white),
                  )),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                  width: 300,
                  child: Text(
                    'Quantidade disponível: ${productSelected!.amount}',
                    style: const TextStyle(fontSize: 20, color: Colors.white),
                  )),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.yellow)),
                  onPressed: () async {
                    productSelected!.amount = '1';
                    final resp = await management.addCart(productSelected!);
                    if (resp == true) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Produto adicionado ao carrinho'),
                        duration: Duration(milliseconds: 700),
                      ));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Erro ao adicionar produto ao carrinho'),
                        duration: Duration(milliseconds: 700),
                      ));
                    }
                  },
                  child: const Text(
                    'Adiconar ao Carrinho',
                    style: TextStyle(color: Colors.black),
                  )),
                
            ],
          ),
        ),
      ),
    );
  }
}
