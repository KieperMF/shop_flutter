import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shop_flutter/models/product_model.dart';

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

  getUserPic() async {
    String uid = user!.uid;
    String? responseImage;
    final storage =
        FirebaseFirestore.instance.collection('profiles_pic').doc(uid);

    try {
      await storage.get().then(
        (DocumentSnapshot doc) {
          final data = doc.data() as Map<String, dynamic>;
          debugPrint('sucess get profile pic: ${data.values.last}');
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

  void saveProfilePic(String? profilePic) async {
    String uid = user!.uid;
    final CollectionReference storageRef =
        FirebaseFirestore.instance.collection('profiles_pic');
    try {
      await storageRef.doc(uid).set({'profile_pic': profilePic});
      debugPrint('Succes on save profile pic');
    } catch (e) {
      debugPrint('erro save profile pic: $e');
    }
  }

  addProduct(Product product) async {
    try {
      final CollectionReference storageRef =
          FirebaseFirestore.instance.collection('products');
      await storageRef.add(product.toMap());
      debugPrint('sucesso adicionar produto');
    } catch (e) {
      debugPrint('erro adicionar produto: $e');
    }
  }

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

  getUser() {
    user = firebaseAuth.currentUser;
    return firebaseAuth.currentUser;
  }
}
