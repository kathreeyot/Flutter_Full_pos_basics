import 'package:flutter/material.dart';

import 'package:flutter_basic_pos/navbar_sidebar/nav_bar.dart';

class CheckBill extends StatefulWidget {
  const CheckBill({super.key});

  @override
  State<CheckBill> createState() => _CheckBillState();
}

class _CheckBillState extends State<CheckBill> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: Navbar(title: "Check Bill"),
      body: Column(children: [],),
    );
  }
}