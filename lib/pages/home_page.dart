import 'package:flutter/material.dart';
import 'package:test_app_cafe/components/my_drawer.dart';
import 'package:test_app_cafe/components/my_table.dart';
import 'package:test_app_cafe/constants/colors.dart';
import 'package:test_app_cafe/pages/choose_products.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:test_app_cafe/components/shop.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
 
    return Scaffold(
    backgroundColor: Theme.of(context).colorScheme.background,
    appBar: AppBar(title: 
    Text(
      "С Т O Л Ы",
      style: TextStyle(
        color: Colors.white),),
        backgroundColor: lightMode.colorScheme.primary,
        centerTitle: true,elevation: 2,
        ),
    drawer: MyDrawer(),
    body:Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Вип комнаты",style: TextStyle(fontSize: 20),),
                Text("Выберите комнату",style: TextStyle(fontSize: 14),),

              ],
            ),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                child: Container(
                  width: MediaQuery.of(context).size.width*0.45,
                  height: 100,
                 
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                     color: Colors.amber,
                  ),
                  child: Center(child: Text('Vip 1',style: TextStyle(color: Colors.white,fontSize: 25),),)
                ),
                onTap: () {
                  
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ChooseProducts(getTable: "Vip 1",)));
                  } ,
              ),

              GestureDetector(
                child: Container(
                  width: MediaQuery.of(context).size.width*0.45,
                  height: 100,
                 
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                     color: Colors.amber,
                  ),
                   child: Center(child: Text('Vip 2',style: TextStyle(color: Colors.white,fontSize: 25),),)
                ),
                onTap: () {
      
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ChooseProducts(getTable: "Vip 2",)));
                } ,
              )
            ],
          ),
          SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Основной зал",style: TextStyle(fontSize: 20),),
                Text("Выберите стол",style: TextStyle(fontSize: 14),),

              ],
            ),
           Expanded(
             child: GridView.count(
                       // Create a grid with 2 columns. If you change the scrollDirection to
                       // horizontal, this produces 2 rows.
                       crossAxisCount: 4,
                       // Generate 100 widgets that display their index in the List.
                       children: List.generate(20, (index) {
              return Padding(padding: EdgeInsets.all(4),child: MyTable(number: index+1),);
                       }),
                     ),
           ),
        ],
      ),
    ),
    );
  }
}