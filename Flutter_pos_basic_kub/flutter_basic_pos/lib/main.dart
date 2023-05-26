import 'package:flutter_basic_pos/FormScreen/homescreen.dart';
import 'package:flutter/material.dart';

void main() => runApp(const HomeScreen());

class PosApp extends StatelessWidget {
  const PosApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant POS',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  const HomeScreen(),
    );
  }
}

