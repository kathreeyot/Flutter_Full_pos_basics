import 'package:flutter/material.dart';
import 'package:flutter_basic_pos/navbar_sidebar/side_bar.dart';

import '../navbar_sidebar/nav_bar.dart';
import '../required data/menu_item.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Navbar(title: 'Main'),
      body: Column(
        children: [SideBar()],
      ),
    );
  }
}
