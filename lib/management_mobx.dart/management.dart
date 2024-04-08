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
  String? userPic;

  @action
  Future pickImageFromGallery() async{
    final responseImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    selectedImage = responseImage!.path;
    service.saveProfilePic(selectedImage);
    debugPrint(selectedImage);
  }

  @action
  getUser() async{
    user = service.getUser();
    userPic = await service.getUserPic();
    debugPrint('profile pic: $userPic');
    debugPrint(user!.displayName);
  }
  
}