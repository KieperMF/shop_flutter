import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

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

  Future<bool> loginVerif({required String email, required String password}) async {
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

  Future<bool> registerVerif({required String email,required String password,required String name}) async{
    try{
      await _registerUser(email: email,password: password,name: name);
      if (firebaseAuth.currentUser!.displayName != null) {
        return true;
      } else {
        return false;
      }
    }catch(e){
      return false;
    }
  }

  void saveProfilePic(String? profilePic) async{
    String uid = user!.uid;
    final storageRef = FirebaseStorage.instance.ref().child('profiles/$uid/profile_pic');
    try{
      await storageRef.putFile(File(profilePic!));
      debugPrint('Succes on save profile pic');
    }catch(e){
      debugPrint('erro save profile pic: $e');
    } 
  }

  getUserPic()async{
    String uid = user!.uid;
    final storageRef = FirebaseStorage.instance.ref().child('profiles/$uid/profile_pic');

    try{
      String request = await storageRef.getDownloadURL();
      debugPrint('sucess get profile pic');
      return request;
    }catch(e){
      debugPrint('erro get profile pic: $e');
      return null;
    }
  }

  getUser() {
    user = firebaseAuth.currentUser;
    return firebaseAuth.currentUser;
  }
}
