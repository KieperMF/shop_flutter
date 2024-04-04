

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:shop_flutter/controllers/db_controller.dart';

part 'management.g.dart';

class Management = ManagementBase with _$Management;

abstract class ManagementBase with Store {
  final service = DbController();

  @observable
  User? user;

  @action
  getUser() async{
    user = service.firebaseAuth.currentUser;
    debugPrint(user!.displayName);
  }
}