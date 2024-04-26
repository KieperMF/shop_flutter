
class Product{
  int? id;
  String? name;
  String? imagem;
  String? price;
  String? amount;
  String? description;
  String? category;

  Product({
    this.id,
    this.category,
     this.name,
     this.imagem,
     this.price,
     this.amount,
     this.description
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'category': category,
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
      id: json['id'],
      category: json['category'],
      imagem: json['urlImage'],
      amount: json['amount'],
      price: json['price'],
      description: json['description']
    );
  }
}