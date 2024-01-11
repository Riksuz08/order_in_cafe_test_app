import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app_cafe/components/shop.dart'; // Assuming this is where your Shop class is defined
import 'package:test_app_cafe/constants/colors.dart';
import 'package:test_app_cafe/models/cart.dart';
import 'package:test_app_cafe/pages/choose_products.dart'; // Assuming this is the model for your Cart class

class OrdersPage extends StatefulWidget {
  const OrdersPage({Key? key}) : super(key: key);

  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(
          "Заказы",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: lightMode.colorScheme.primary,
        centerTitle: true,
        elevation: 2,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white,),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Consumer<Shop>(
        builder: (context, shop, child) {
          Map<String, List<Cart>> tableCarts = shop.getCarts();

          return ListView.builder(
            itemCount: tableCarts.length,
            itemBuilder: (context, index) {
              String tableName = tableCarts.keys.elementAt(index);
              List<Cart> cartItems = tableCarts[tableName] ?? [];

              return GestureDetector(
                onTap: ()=>  Navigator.push(context, MaterialPageRoute(builder: (context)=>ChooseProducts(getTable: tableName))),
                child: Container(
                  margin: EdgeInsets.all(8),
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tableName,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(height: 8),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: cartItems.length,
                        itemBuilder: (context, index) {
                          Cart cartItem = cartItems[index];
                
                          return ListTile(
                            title: Text(cartItem.name),
                            subtitle: Text('${cartItem.price} руб. x ${cartItem.quantity}'),
                            // You can customize this ListTile to display other information about the cart item
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
