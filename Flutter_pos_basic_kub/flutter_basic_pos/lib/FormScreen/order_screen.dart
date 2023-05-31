import 'package:flutter/material.dart';
import 'package:flutter_basic_pos/navbar_sidebar/nav_bar.dart';

import '../navbar_sidebar/side_bar.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Navbar(title: 'Order Screen'),
        body: Column(children: [
          SideBar(),
        ]));
  }
}
