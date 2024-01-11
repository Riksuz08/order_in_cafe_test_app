import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app_cafe/components/shop.dart';
import 'package:test_app_cafe/constants/colors.dart';
import 'package:test_app_cafe/pages/home_page.dart';



void main() {
  runApp(

   ChangeNotifierProvider(
      create: (context) => Shop(), // Assuming Shop is a ChangeNotifier
      child: const MyApp(),
    ),
  );
}
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    initializeApp();
  }

  Future<void> initializeApp() async {
    // Your asynchronous initialization logic here
    await Provider.of<Shop>(context, listen: false).loadCartsFromLocalStorage();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      theme: lightMode,
    );
  }
}