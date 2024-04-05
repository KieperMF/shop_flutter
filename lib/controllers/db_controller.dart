import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DbController {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  User? user;

  void _login({required String email, required String password}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      debugPrint('$e');
    }
  }

  Future<bool> loginVerif({required String email, required String password}) async {
    try {
      _login(email: email, password: password);
      return true;
    } catch (e) {
      debugPrint('erro login: $e');
      return false;
    }
  }

  void registerUser(
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

  getUser(){
   return firebaseAuth.currentUser;
  }
}
