import 'package:flutter/material.dart';

import 'screens/home_screen.dart';

class ArFurnitureApp extends StatelessWidget {
  const ArFurnitureApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AR Furniture',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const HomeScreen(),
    );
  }
}
