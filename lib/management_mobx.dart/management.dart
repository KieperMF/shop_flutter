import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';
import 'package:shop_flutter/controllers/product_controller.dart';
import 'package:shop_flutter/controllers/user_controller.dart';
import 'package:shop_flutter/models/product_model.dart';

part 'management.g.dart';

class Management = ManagementBase with _$Management;

abstract class ManagementBase with Store {
  final productService = ProductController();
  final userService = UserController();

  String adminId = "qElhXpEEuvTPWxU8jaK1pU9Zojf2";

  @observable
  User? user;

  @observable
  double total = 0;

  @observable
  String? selectedImage;

  @observable
  ObservableList<Product> products = ObservableList.of([]);

  @observable
  ObservableList<Product> eletrocicProducts = ObservableList.of([]);

  @observable
  ObservableList<Product> gameProducts = ObservableList.of([]);

  @observable
  ObservableList<Product> peripheralsProducts = ObservableList.of([]);

  @observable
  ObservableList<Product> decorationProducts = ObservableList.of([]);

  @observable
  ObservableList<Product> books = ObservableList.of([]);

  @observable
  ObservableList<Product> cartProducts = ObservableList.of([]);

  @observable
  Product? product;

  @observable
  String? userPic;

  @action
  amountSelectionIncrement( int index)async{
    int increment = int.parse('${cartProducts[index].amount}') + 1;
    cartProducts[index].amount = increment.toString();
    total = double.parse('${cartProducts[index].price}') + total;
    await productService.addToCartVerif(cartProducts[index]);
  }

  @action
  amountSelectionDecrement( int index)async{
    int decrement = int.parse('${cartProducts[index].amount}') - 1;
    cartProducts[index].amount = decrement.toString();
    total = total - double.parse('${cartProducts[index].price}');
    await productService.addToCartVerif(cartProducts[index]);
  }

  @action
  Future pickImageFromGallery() async {
    final responseImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    userService.saveProfilePic(responseImage!.path);
    userPic = await userService.getUserPic();
  }

  @action
  deleteProduct(Product product, int index)async{
    await productService.deleteProduct(product);
    products.removeAt(index);
  }

  @action
  updateProduct(Product productTyped, Product prodFromIndex)async{
    Product product =  Product();
    product.name = productTyped.name != '' ? productTyped.name : prodFromIndex.name;
    product.price = productTyped.price != '' ? productTyped.price : prodFromIndex.price;
    product.amount = productTyped.amount != '' ? productTyped.amount : prodFromIndex.amount;
    product.description = productTyped.description != '' ? productTyped.description : prodFromIndex.description;
    debugPrint(product.description);
    product.category = productTyped.category != '' ? productTyped.category : prodFromIndex.category;
    product.id = prodFromIndex.id;
    product.imagem = prodFromIndex.imagem;
    final resp = await productService.updateProduct(product);
    return resp;
  }

  @action
  Future pickProductFromGallery() async {
    final responseImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    selectedImage = responseImage!.path;
  }

  @action
  getCartProducts() async {
    int i =0;
    List<Product> prods = await productService.getCartProducts();
    while(prods.length > i){
      total = (double.parse(prods[i].price!) * int.parse(prods[i].amount!)) + total;
      i++;
    }
    cartProducts.addAll(prods);
  }

  @action
  getUser() async {
    user = userService.getUser();
    userPic = await userService.getUserPic();
  }

  @action
  addProduct(Product product) async {
    final resp = await productService.addProduct(product);
    return resp;
  }

  @action
  getProduct() async {
    List<Product> prods = await productService.getProduct();
    for(Product prod in prods){
      if(prod.category == 'Eletrônico'){
        eletrocicProducts.add(prod);
      }else if(prod.category == 'Games'){
        gameProducts.add(prod);
      }else if(prod.category == 'Periférico'){
        peripheralsProducts.add(prod);
      }else if(prod.category == 'Decoração'){
        decorationProducts.add(prod);
      }else{
        books.add(prod);
      }
    }
    products.addAll(prods);
  }

  getProductLength() async {
    List<Product> prods = await productService.getProduct();
    products.addAll(prods);
    int i = prods.length;
    return i;
  }

  @action
  addCart(Product product) async {
    final resp = await productService.addToCartVerif(product);
    return resp;
  }

  @action
  deleteFromCart(Product product, int index) async {
    final resp = await productService.deleteFromCart(product);
    cartProducts.removeAt(index);
    int i =0;
    total = 0;
    while(cartProducts.length > i){
      total = (double.parse(cartProducts[i].price!) * int.parse(cartProducts[i].amount!)) + total;
      i++;
    }
    if(cartProducts.isEmpty){
      total = 0;
    }
    return resp;
  }
}
