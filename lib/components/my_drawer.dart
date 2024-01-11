import 'package:flutter/material.dart';
import 'package:test_app_cafe/pages/orders_page.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return  Drawer(
      
    child: Column(children: [
      SizedBox(height: 50,),
        Padding(
          padding: const EdgeInsets.only(left:25.0),
          child: Container(
          height: 60, // Set the desired height here
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Сайдуллаев Сарвар',
                    style: TextStyle(fontSize: 20),
                  ),
                  Text('Сотрудник'),
                ],
              ),
            ],
          ),
          
              ),
        ),
        Divider(),

      Padding(
        padding: EdgeInsets.only(left: 25,right: 25),
      child: GestureDetector(
        child: ListTile(
          title: Text("Столы"),
          leading: Icon(Icons.table_bar),
        ),
        onTap: () => Navigator.pop(context),
      ),
      ),
      Padding(
        padding: EdgeInsets.only(left: 25,right: 25),
      child: GestureDetector(
        child: ListTile(
          title: Text("Заказы"),
          leading: Icon(Icons.list_outlined),
        ),
         onTap: () { 
          Navigator.pop(context);
           Navigator.push(context, MaterialPageRoute(builder: (context)=>OrdersPage()));
         
         },
      ),
      ),
    
    ]),
    );
  }
}