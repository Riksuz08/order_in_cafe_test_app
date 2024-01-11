
class Cart{

    String name;

  int price;

  String imagePath;

  String rating;
  int quantity;


  Cart({
    required this.name,
    required this.price,
    required this.imagePath,
    required this.rating,
    required this.quantity

  });

String get _name => name;
int get _price => price;
String get _imagePath =>imagePath;
String get _rating => rating;
int get _quantity=> quantity;


  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      name: json['name'],
      price: json['price'],
      imagePath: json['imagePath'],
      rating: json['rating'],
      quantity: json['quantity'],
    );
  }

    Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
      'imagePath': imagePath,
      'rating': rating,
      'quantity': quantity,
    };
  }
}