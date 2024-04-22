import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';
import 'package:shop_flutter/controllers/db_controller.dart';
import 'package:shop_flutter/models/product_model.dart';

part 'management.g.dart';

class Management = ManagementBase with _$Management;

abstract class ManagementBase with Store {
  final service = DbController();

  String adminId = "qElhXpEEuvTPWxU8jaK1pU9Zojf2";

  @observable
  User? user;

  @observable
  String? selectedImage;

  @observable
  ObservableList<Product> products = ObservableList.of([]);

  @observable
  ObservableList<Product> cartProducts = ObservableList.of([]);

  @observable
  Product? product;

  @observable
  String? userPic;

  @action
  Future pickImageFromGallery() async {
    final responseImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    selectedImage = responseImage!.path;
    service.saveProfilePic(selectedImage);
  }

  @action
  Future pickProductFromGallery() async {
    final responseImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    selectedImage = responseImage!.path;
  }

  @action
  getCartProducts() async {
    List<Product> prods = await service.getCartProducts();
    cartProducts.addAll(prods);
  }

  @action
  getUser() async {
    user = service.getUser();
    userPic = await service.getUserPic();
  }

  @action
  addProduct(Product product) async {
    final resp = await service.addProduct(product);
    return resp;
  }

  @action
  getProduct() async {
    List<Product> prods = await service.getProduct();
    products.addAll(prods);
  }

  @action
  addCart(Product product) async {
    final resp = await service.addToCartVerif(product);
    return resp;
  }

  @action
  deleteFromCart(Product product) async {
    final resp = await service.deleteFromCart(product);
    cartProducts.clear();
    getCartProducts();
    return resp;
  }
}
