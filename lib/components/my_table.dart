import 'package:flutter/material.dart';
import 'package:test_app_cafe/constants/colors.dart';
import 'package:test_app_cafe/pages/choose_products.dart';

class MyTable extends StatelessWidget {
  final int number;
  const MyTable({super.key, required this.number});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Stack(
        alignment: Alignment.center,
        children: [
      Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.amber.shade400,
        ),
      ),
      Text(
        number.toString(), // Your number here
        style: TextStyle(
          color: Colors.white, // Choose the color for the number
          fontSize: 24, // Choose the font size for the number
          fontWeight: FontWeight.bold, // Choose the font weight for the number
        ),
      ),
        ],
      ),
      onTap: () {
      
        Navigator.push(context, MaterialPageRoute(builder: (context)=>ChooseProducts(getTable: "Cтол $number")));
      } ,
    );

  }
}