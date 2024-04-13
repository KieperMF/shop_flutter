
class Product{
  String? name;
  String? imagem;
  String? price;
  String? amount;

  Product({
     this.name,
     this.imagem,
     this.price,
     this.amount
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'urlImage': imagem,
      'price': price,
      'amount' : amount
    };
  }

  factory Product.fromJson(Map<dynamic, dynamic>json){
    return Product(
      name:json['name'],
      imagem: json['imageUrl'],
      amount: json['amount'],
      price: json['price']
    );
  }
}