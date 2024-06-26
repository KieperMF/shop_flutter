// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'management.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$Management on ManagementBase, Store {
  late final _$userAtom = Atom(name: 'ManagementBase.user', context: context);

  @override
  User? get user {
    _$userAtom.reportRead();
    return super.user;
  }

  @override
  set user(User? value) {
    _$userAtom.reportWrite(value, super.user, () {
      super.user = value;
    });
  }

  late final _$totalAtom = Atom(name: 'ManagementBase.total', context: context);

  @override
  double get total {
    _$totalAtom.reportRead();
    return super.total;
  }

  @override
  set total(double value) {
    _$totalAtom.reportWrite(value, super.total, () {
      super.total = value;
    });
  }

  late final _$selectedImageAtom =
      Atom(name: 'ManagementBase.selectedImage', context: context);

  @override
  String? get selectedImage {
    _$selectedImageAtom.reportRead();
    return super.selectedImage;
  }

  @override
  set selectedImage(String? value) {
    _$selectedImageAtom.reportWrite(value, super.selectedImage, () {
      super.selectedImage = value;
    });
  }

  late final _$productsAtom =
      Atom(name: 'ManagementBase.products', context: context);

  @override
  ObservableList<Product> get products {
    _$productsAtom.reportRead();
    return super.products;
  }

  @override
  set products(ObservableList<Product> value) {
    _$productsAtom.reportWrite(value, super.products, () {
      super.products = value;
    });
  }

  late final _$eletrocicProductsAtom =
      Atom(name: 'ManagementBase.eletrocicProducts', context: context);

  @override
  ObservableList<Product> get eletrocicProducts {
    _$eletrocicProductsAtom.reportRead();
    return super.eletrocicProducts;
  }

  @override
  set eletrocicProducts(ObservableList<Product> value) {
    _$eletrocicProductsAtom.reportWrite(value, super.eletrocicProducts, () {
      super.eletrocicProducts = value;
    });
  }

  late final _$gameProductsAtom =
      Atom(name: 'ManagementBase.gameProducts', context: context);

  @override
  ObservableList<Product> get gameProducts {
    _$gameProductsAtom.reportRead();
    return super.gameProducts;
  }

  @override
  set gameProducts(ObservableList<Product> value) {
    _$gameProductsAtom.reportWrite(value, super.gameProducts, () {
      super.gameProducts = value;
    });
  }

  late final _$peripheralsProductsAtom =
      Atom(name: 'ManagementBase.peripheralsProducts', context: context);

  @override
  ObservableList<Product> get peripheralsProducts {
    _$peripheralsProductsAtom.reportRead();
    return super.peripheralsProducts;
  }

  @override
  set peripheralsProducts(ObservableList<Product> value) {
    _$peripheralsProductsAtom.reportWrite(value, super.peripheralsProducts, () {
      super.peripheralsProducts = value;
    });
  }

  late final _$decorationProductsAtom =
      Atom(name: 'ManagementBase.decorationProducts', context: context);

  @override
  ObservableList<Product> get decorationProducts {
    _$decorationProductsAtom.reportRead();
    return super.decorationProducts;
  }

  @override
  set decorationProducts(ObservableList<Product> value) {
    _$decorationProductsAtom.reportWrite(value, super.decorationProducts, () {
      super.decorationProducts = value;
    });
  }

  late final _$booksAtom = Atom(name: 'ManagementBase.books', context: context);

  @override
  ObservableList<Product> get books {
    _$booksAtom.reportRead();
    return super.books;
  }

  @override
  set books(ObservableList<Product> value) {
    _$booksAtom.reportWrite(value, super.books, () {
      super.books = value;
    });
  }

  late final _$cartProductsAtom =
      Atom(name: 'ManagementBase.cartProducts', context: context);

  @override
  ObservableList<Product> get cartProducts {
    _$cartProductsAtom.reportRead();
    return super.cartProducts;
  }

  @override
  set cartProducts(ObservableList<Product> value) {
    _$cartProductsAtom.reportWrite(value, super.cartProducts, () {
      super.cartProducts = value;
    });
  }

  late final _$productAtom =
      Atom(name: 'ManagementBase.product', context: context);

  @override
  Product? get product {
    _$productAtom.reportRead();
    return super.product;
  }

  @override
  set product(Product? value) {
    _$productAtom.reportWrite(value, super.product, () {
      super.product = value;
    });
  }

  late final _$userPicAtom =
      Atom(name: 'ManagementBase.userPic', context: context);

  @override
  String? get userPic {
    _$userPicAtom.reportRead();
    return super.userPic;
  }

  @override
  set userPic(String? value) {
    _$userPicAtom.reportWrite(value, super.userPic, () {
      super.userPic = value;
    });
  }

  late final _$amountSelectionIncrementAsyncAction =
      AsyncAction('ManagementBase.amountSelectionIncrement', context: context);

  @override
  Future amountSelectionIncrement(int index) {
    return _$amountSelectionIncrementAsyncAction
        .run(() => super.amountSelectionIncrement(index));
  }

  late final _$amountSelectionDecrementAsyncAction =
      AsyncAction('ManagementBase.amountSelectionDecrement', context: context);

  @override
  Future amountSelectionDecrement(int index) {
    return _$amountSelectionDecrementAsyncAction
        .run(() => super.amountSelectionDecrement(index));
  }

  late final _$pickImageFromGalleryAsyncAction =
      AsyncAction('ManagementBase.pickImageFromGallery', context: context);

  @override
  Future<dynamic> pickImageFromGallery() {
    return _$pickImageFromGalleryAsyncAction
        .run(() => super.pickImageFromGallery());
  }

  late final _$deleteProductAsyncAction =
      AsyncAction('ManagementBase.deleteProduct', context: context);

  @override
  Future deleteProduct(Product product, int index) {
    return _$deleteProductAsyncAction
        .run(() => super.deleteProduct(product, index));
  }

  late final _$updateProductAsyncAction =
      AsyncAction('ManagementBase.updateProduct', context: context);

  @override
  Future updateProduct(Product productTyped, Product prodFromIndex) {
    return _$updateProductAsyncAction
        .run(() => super.updateProduct(productTyped, prodFromIndex));
  }

  late final _$pickProductFromGalleryAsyncAction =
      AsyncAction('ManagementBase.pickProductFromGallery', context: context);

  @override
  Future<dynamic> pickProductFromGallery() {
    return _$pickProductFromGalleryAsyncAction
        .run(() => super.pickProductFromGallery());
  }

  late final _$getCartProductsAsyncAction =
      AsyncAction('ManagementBase.getCartProducts', context: context);

  @override
  Future getCartProducts() {
    return _$getCartProductsAsyncAction.run(() => super.getCartProducts());
  }

  late final _$getUserAsyncAction =
      AsyncAction('ManagementBase.getUser', context: context);

  @override
  Future getUser() {
    return _$getUserAsyncAction.run(() => super.getUser());
  }

  late final _$addProductAsyncAction =
      AsyncAction('ManagementBase.addProduct', context: context);

  @override
  Future addProduct(Product product) {
    return _$addProductAsyncAction.run(() => super.addProduct(product));
  }

  late final _$getProductAsyncAction =
      AsyncAction('ManagementBase.getProduct', context: context);

  @override
  Future getProduct() {
    return _$getProductAsyncAction.run(() => super.getProduct());
  }

  late final _$addCartAsyncAction =
      AsyncAction('ManagementBase.addCart', context: context);

  @override
  Future addCart(Product product) {
    return _$addCartAsyncAction.run(() => super.addCart(product));
  }

  late final _$deleteFromCartAsyncAction =
      AsyncAction('ManagementBase.deleteFromCart', context: context);

  @override
  Future deleteFromCart(Product product, int index) {
    return _$deleteFromCartAsyncAction
        .run(() => super.deleteFromCart(product, index));
  }

  @override
  String toString() {
    return '''
user: ${user},
total: ${total},
selectedImage: ${selectedImage},
products: ${products},
eletrocicProducts: ${eletrocicProducts},
gameProducts: ${gameProducts},
peripheralsProducts: ${peripheralsProducts},
decorationProducts: ${decorationProducts},
books: ${books},
cartProducts: ${cartProducts},
product: ${product},
userPic: ${userPic}
    ''';
  }
}
