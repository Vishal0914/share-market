
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_market/on_boarding/splash_screen.dart';
import 'logic/provider/stock_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => StockProvider(),
      child:  MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:  SplashScreen(),
    );
  }
}

