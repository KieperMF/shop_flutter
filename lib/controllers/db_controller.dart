import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:shop_flutter/models/product_model.dart';

Product? productSelected;

class DbController {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  User? user;

  _login({required String email, required String password}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      debugPrint('erro primeiro login: $e');
    }
  }

  Future<bool> loginVerif(
      {required String email, required String password}) async {
    try {
      await _login(email: email, password: password);
      debugPrint('${firebaseAuth.currentUser!.displayName}');
      if (firebaseAuth.currentUser!.displayName != null) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      debugPrint('erro login: $e');
      return false;
    }
  }

  _registerUser(
      {required String email,
      required String password,
      required String name}) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      await userCredential.user!.updateDisplayName(name);
    } catch (e) {
      debugPrint('erro cadastro: $e');
    }
  }

  Future<bool> registerVerif(
      {required String email,
      required String password,
      required String name}) async {
    try {
      await _registerUser(email: email, password: password, name: name);
      if (firebaseAuth.currentUser!.displayName != null) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  saveChangedPic(String? profilePic) async{
    String uid = user!.uid;
    String? imageUrl = await _uploadProfilePic(File('$profilePic'), uid);

    if (imageUrl != null) {
      final CollectionReference profilesRef =
          FirebaseFirestore.instance.collection('profiles');
      try {
        await profilesRef.doc(uid).update({'profile_pic': imageUrl});
        debugPrint('Sucesso ao mudar a imagem de perfil');
      } catch (e) {
        debugPrint('Erro ao mudar a imagem de perfil: $e');
      }
    }
  }

  //sobe imagem para e depois retorna a url dela
  _uploadProfilePic(File imageFile, String userId) async {
    try {
      Reference storageReference =
          FirebaseStorage.instance.ref().child('profile_pics').child(userId);

      UploadTask uploadTask = storageReference.putFile(imageFile);
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);

      String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      debugPrint('Erro ao fazer upload da imagem: $e');
      return null;
    }
  }

  //salva a imagem do usuario
  void saveProfilePic(String? profilePic) async {
    String uid = user!.uid;
    String? imageUrl = await _uploadProfilePic(File('$profilePic'), uid);

    if (imageUrl != null) {
      final CollectionReference profilesRef =
          FirebaseFirestore.instance.collection('profiles');
      try {
        await profilesRef.doc(uid).set({'profile_pic': imageUrl});
        debugPrint('Sucesso ao salvar a imagem de perfil');
      } catch (e) {
        debugPrint('Erro ao salvar a imagem de perfil: $e');
      }
    }
  }

  //adiciona o produto para o firebase
  addProduct(Product product) async {
    
    String id = product.id.toString();
    product.imagem =
        await _uploadProductPic(File('${product.imagem}'), product);
    try {
      final storageRef =
          FirebaseFirestore.instance.collection('products').doc('${product.name} $id');
      await storageRef.set(
        product.toMap(),
      );
      debugPrint('sucesso adicionar produto');
      return true;
    } catch (e) {
      debugPrint('erro adicionar produto: $e');
    }
  }

  //subir a imagem do produto para o firestorage e depois retorna para o firestore database
  _uploadProductPic(File imageFile, Product product) async {
    try {
      Reference storageReference =
          FirebaseStorage.instance.ref().child('product_pic').child('${product.name}-${product.id!.toString()}');

      UploadTask uploadTask = storageReference.putFile(imageFile);
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);

      String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      debugPrint('Erro ao fazer upload da imagem: $e');
      return null;
    }
  }

  //pega a imagem do usuario
  getUserPic() async {
    String? responseImage;
    final storage = FirebaseFirestore.instance
        .collection('profiles')
        .doc(firebaseAuth.currentUser!.uid);

    try {
      await storage.get().then(
        (DocumentSnapshot doc) {
          final data = doc.data() as Map<String, dynamic>;
          responseImage = data.values.last.toString();
        },
        onError: (e) => debugPrint("Error getting document: $e"),
      );
      return responseImage;
    } catch (e) {
      debugPrint('erro get profile pic: $e');
      return null;
    }
  }

  //pega o usuario atual logado
  getUser() {
    user = firebaseAuth.currentUser;
    return firebaseAuth.currentUser;
  }

  //adiciona o produto ao carrinho
  _addToCart(Product product) async {
    try {
      final ref = FirebaseFirestore.instance
          .collection(
              'cartProducts_${firebaseAuth.currentUser!.displayName}_${firebaseAuth.currentUser!.uid}')
          .doc('${product.name} ${product.id!.toString()}');
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
          .doc('${product.name} ${product.id!}');
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
