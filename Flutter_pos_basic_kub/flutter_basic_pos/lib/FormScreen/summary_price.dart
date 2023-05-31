import 'package:flutter/material.dart';

import 'package:flutter_basic_pos/navbar_sidebar/nav_bar.dart';

import '../navbar_sidebar/side_bar.dart';

class SummaryPrice extends StatefulWidget {
  const SummaryPrice({super.key});

  @override
  State<SummaryPrice> createState() => _SummaryPriceState();
}

class _SummaryPriceState extends State<SummaryPrice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Navbar(title: 'Summary'),
        body: Column(children: [
          SideBar(),
        ]));
  }
}
