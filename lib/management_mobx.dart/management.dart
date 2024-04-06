import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';
import 'package:shop_flutter/controllers/db_controller.dart';

part 'management.g.dart';

class Management = ManagementBase with _$Management;

abstract class ManagementBase with Store {
  final service = DbController();

  @observable
  User? user;
  
  @observable
  String? selectedImage;

  @observable
  Observable<File>? selectedImage1;

  @action
  Future pickImageFromGallery() async{
    final responseImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    selectedImage = responseImage!.path;
    debugPrint(selectedImage);
  }

  @action
  getUser() async{
    user = service.getUser();
    debugPrint(user!.displayName);
  }
  
}