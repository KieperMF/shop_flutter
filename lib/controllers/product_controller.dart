import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:shop_flutter/models/product_model.dart';

Product? productSelected;

class ProductController {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  //adiciona o produto para o firebase
  addProduct(Product product) async {
    String id = product.id.toString();
    product.imagem =
        await _uploadProductPic(File('${product.imagem}'), product);
    try {
      final storageRef =
          FirebaseFirestore.instance.collection('products').doc(id);
      await storageRef.set(
        product.toMap(),
      );
      return true;
    } catch (e) {
      debugPrint('erro adicionar produto: $e');
    }
  }

  updateProduct(Product product)async{
    try {
      final ref = FirebaseFirestore.instance
          .collection(
              'products')
          .doc('${product.id!}');
      await ref.update(product.toMap());
      return true;
    } catch (e) {
      debugPrint('erro update $e');
      return false;
    }
  }

  //metodo para deletar um produto especifico
  deleteProduct(Product product)async{
    try {
      final ref = FirebaseFirestore.instance
          .collection(
              'products')
          .doc('${product.id!}');
      await ref.delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  //subir a imagem do produto para o firestorage e depois retorna para o firestore database
  _uploadProductPic(File imageFile, Product product) async {
    try {
      Reference storageReference =
          FirebaseStorage.instance.ref().child('product_pic').child(product.id!.toString());
      UploadTask uploadTask = storageReference.putFile(imageFile);
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);

      String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      debugPrint('Erro ao fazer upload da imagem: $e');
      return null;
    }
  }

  //adiciona o produto ao carrinho
  _addToCart(Product product) async {
    try {
      final ref = FirebaseFirestore.instance
          .collection(
              'cartProducts_${firebaseAuth.currentUser!.displayName}_${firebaseAuth.currentUser!.uid}')
          .doc(product.id!.toString());
      await ref.set(product.toMap());
      return true;
    } catch (e) {
      debugPrint('erro add to cart $e');
      return false;
    }
  }

  addToCartVerif(Product product) async {
    try {
      final resp = await _addToCart(product);
      return resp;
    } catch (e) {
      return false;
    }
  }

  //deleta o produto do carrinho do usuario
  deleteFromCart(Product product) async {
    try {
      final ref = FirebaseFirestore.instance
          .collection(
              'cartProducts_${firebaseAuth.currentUser!.displayName}_${firebaseAuth.currentUser!.uid}')
          .doc('${product.id!}');
      await ref.delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  //pegar todos os produtos da database
  getProduct() async {
    List<Product> products = [];
    Product? product;
    final CollectionReference storageRef =
        FirebaseFirestore.instance.collection('products');
    try {
      await storageRef.get().then((querySnapshot) {
        for (var docSnapshot in querySnapshot.docs) {
          final prodResp = docSnapshot.data() as Map;
          product = Product.fromJson(prodResp);
          products.add(product!);
        }
      });

      return products;
    } catch (e) {
      debugPrint('erro carregar produtos: $e');
    }
  }

  getCartProducts() async {
    List<Product> products = [];
    Product? product;
    final CollectionReference ref = FirebaseFirestore.instance.collection(
        'cartProducts_${firebaseAuth.currentUser!.displayName}_${firebaseAuth.currentUser!.uid}');
    try {
      await ref.get().then((querySnapshot) {
        for (var docSnapshot in querySnapshot.docs) {
          final prodResp = docSnapshot.data() as Map;
          product = Product.fromJson(prodResp);
          products.add(product!);
        }
      });
      return products;
    } catch (e) {
      debugPrint('erro pegar produtos do carrinho: $e');
    }
  }
}
