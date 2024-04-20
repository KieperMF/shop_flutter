
class Product{
  String? name;
  String? imagem;
  String? price;
  String? amount;
  String? description;

  Product({
     this.name,
     this.imagem,
     this.price,
     this.amount,
     this.description
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'urlImage': imagem,
      'price': price,
      'amount' : amount,
      'description' : description
    };
  }

  factory Product.fromJson(Map<dynamic, dynamic>json){
    return Product(
      name:json['name'],
      imagem: json['urlImage'],
      amount: json['amount'],
      price: json['price'],
      description: json['description']
    );
  }
}