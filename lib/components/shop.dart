import 'package:flutter/material.dart';
import 'package:test_app_cafe/components/database_helper.dart';
import 'package:test_app_cafe/models/cart.dart';
import 'package:test_app_cafe/models/food.dart';
import 'package:hive_flutter/hive_flutter.dart';


@HiveType(typeId: 1)
class Shop extends ChangeNotifier{
  List<Food> _foodMenu = [
      Food(name:"Бургер",price: 450,imagePath: 'assets/burger.jpg',rating: "4.7",),
      Food(name:"Пицца",price: 550,imagePath: 'assets/pizza.jpg',rating: "4.3"),
      Food(name:"Суши",price: 800,imagePath: 'assets/sushi.jpeg',rating: "4.5"),
      Food(name:"Шаурма",price: 320,imagePath: 'assets/shaurma.jpg',rating: "4.6"),
      

  ];
    List<Food> _drinkMenu = [
      Food(name:"Coca-Cola",price: 150,imagePath: 'assets/cola.jpg',rating: "4.9"),
      Food(name:"Fanta",price: 150,imagePath: 'assets/fanta.jpg',rating: "4.9"),
      Food(name:"Sprite",price: 120,imagePath: 'assets/sprite.jpg',rating: "4.3"),
      Food(name:"Сок",price: 180,imagePath: 'assets/sok.jpg',rating: "4.8"),
      

  ];
 DatabaseHelper _databaseHelper = DatabaseHelper();
 Map<String, List<Cart>> _carts = {};


List<Food> get foodMenu => _foodMenu;
List<Food> get drinkMenu=> _drinkMenu;
 Map<String, List<Cart>> getCarts() {
    return _carts;
  }
Future<void> saveCartsToLocalStorage() async {
    await _databaseHelper.saveCarts(_carts);
  }
  Future<void> loadCartsFromLocalStorage() async {
    _carts = await _databaseHelper.loadCarts();
    notifyListeners();
  }
// add to cart
void addToCart(String getTable, Food foodItem, int quantity) async{
    // Check if the getTable exists in _carts
    if (! _carts.containsKey(getTable)) {
      _carts[getTable] = [];
    }

    // Check if the food item is already in the cart
    final existingCartItemIndex =
    _carts[getTable]!.indexWhere((item) => item.name == foodItem.name);

    if (existingCartItemIndex != -1) {
      // If the item is already in the cart, update its quantity
      _carts[getTable]![existingCartItemIndex].quantity += quantity;
    } else {
      // If the item is not in the cart, add it with the specified quantity
      _carts[getTable]!.add(
        Cart(
          name: foodItem.name,
          price: foodItem.price,
          imagePath: foodItem.imagePath,
          rating: foodItem.rating,
          quantity: quantity,
        ),
      );
    }
   
 await saveCartsToLocalStorage();
    // Notify listeners to update the UI
    notifyListeners();


  }
// remove from cart
    void removeFromCart(String getTable, Cart cartItem) async{
      _carts[getTable]!.remove(cartItem);
    if ( _carts[getTable]!.isEmpty) {
      _carts.remove(getTable);
    }
     await saveCartsToLocalStorage();
    // Notify listeners to update the UI
    notifyListeners();


  }
}