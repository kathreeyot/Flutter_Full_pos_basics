import 'package:flutter/material.dart';
import 'package:flutter_basic_pos/navbar_sidebar/navbar.dart';

class AddMenuScreen extends StatefulWidget {
  const AddMenuScreen({super.key});

  @override
  State<AddMenuScreen> createState() => _AddMenuScreenState();
}

class _AddMenuScreenState extends State<AddMenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Navbar(title: "Add Menu"),
      body: Column(children: const []),
    );
  }
}
