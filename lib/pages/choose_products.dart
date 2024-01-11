import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app_cafe/components/food_tile.dart';
import 'package:test_app_cafe/components/shop.dart';
import 'package:test_app_cafe/models/food.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../constants/colors.dart';

class ChooseProducts extends StatefulWidget {
  final String getTable;

  const ChooseProducts({Key? key, required this.getTable}) : super(key: key);

  @override
  State<ChooseProducts> createState() => _ChooseProductsState();
}

class _ChooseProductsState extends State<ChooseProducts> {
  @override
  Widget build(BuildContext context) {
    final shop = context.read<Shop>();
    final foodMenu = shop.foodMenu;
    final drinkMenu=shop.drinkMenu;
    final cart = shop.getCarts()[widget.getTable] ?? [];
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(
          "Выберите вкусненькое",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: lightMode.colorScheme.primary,
        centerTitle: true,
        elevation: 2,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.95,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.amber,
                ),
                child: Center(
                  child: Text(
                    widget.getTable,
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),
              Consumer<Shop>(
                builder: (context, shop, child) {
                  final cart = shop.getCarts()[widget.getTable] ?? [];
                  int totalPrice() {
                    int total = 0;
                    for (int i = 0; i < cart.length; i++) {
                      total += cart[i].price * cart[i].quantity;
                    }
                    return total;
                  }

                  return Column(
                    children: [
                      Visibility(
                        visible: cart.isEmpty ? false : true,
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          child: Row(
                            children: [
                              Text(
                                'Корзина',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[800],
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 72 * cart.length.toDouble(),
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: cart.length,
                          itemBuilder: (context, index) => Container(
                            padding: EdgeInsets.all(4),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          cart[index].name,
                                          style: TextStyle(fontSize: 18),
                                        ),
                                        Text(
                                          (cart[index].price *
                                              cart[index].quantity)
                                              .toString() + ' руб.',
                                          style: TextStyle(fontSize: 11),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                          icon: Icon(Icons.remove),
                                          onPressed: () {
                                            if (cart[index].quantity > 1) {
                                              setState(() {
                                                cart[index].quantity--;
                                                
                                              });
                                              Provider.of<Shop>(context, listen: false).saveCartsToLocalStorage();
                                            } else if (cart[index].quantity ==
                                                1) {
                                              shop.removeFromCart(
                                                  widget.getTable, cart[index]);
                                            }
                                            Provider.of<Shop>(context, listen: false).saveCartsToLocalStorage();
                                          },
                                        ),
                                        Text(
                                          cart[index].quantity.toString(),
                                          style: TextStyle(fontSize: 18),
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.add),
                                          onPressed: () {
                                            setState(() {
                                              cart[index].quantity++;
                                           
                                            });
                                               Provider.of<Shop>(context, listen: false).saveCartsToLocalStorage();
                                          },
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: cart.isEmpty ? false : true,
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'Общая сумма: ' +
                                    totalPrice().toString() +
                                    " руб.",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[800],
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Text(
                  'Блюда',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                    fontSize: 18,
                  ),
                ),
              ),
              SizedBox(height: 15),
              Container(
                height: 150, // Set a fixed height for your horizontal list
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: foodMenu.length,
                  itemBuilder: (context, index) =>
                      FoodTile(food: foodMenu[index], table: widget.getTable),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Text(
                  'Напитки',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                    fontSize: 18,
                  ),
                ),
              ),
              SizedBox(height: 15),
              Container(
                height: 150, // Set a fixed height for your horizontal list
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: drinkMenu.length,
                  itemBuilder: (context, index) =>
                      FoodTile(food: drinkMenu[index], table: widget.getTable),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
