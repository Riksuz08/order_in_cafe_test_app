import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app_cafe/components/shop.dart';
import 'package:test_app_cafe/models/food.dart';
import 'package:hive_flutter/hive_flutter.dart';

class FoodTile extends StatelessWidget {
  final Food food;
  final String table;

  const FoodTile({Key? key, required this.food, required this.table})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final shop = context.read<Shop>();
        shop.addToCart(table, food, 1);
        print(shop.getCarts());

      },
      child: Consumer<Shop>(
        builder: (context, shop, child) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(20),
            ),
            margin: EdgeInsets.only(left: 10, bottom: 10),
            padding: EdgeInsets.all(25),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    food.imagePath,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 10,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(food.name, style: TextStyle(fontSize: 20)),
                    Text(food.price.toString() + ' руб.'),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.yellow),
                        Text(food.rating),
                      ],
                    )
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
