import 'package:flutter/material.dart';
import 'package:flutter_basic_pos/navbar_sidebar/nav_bar.dart';

import '../navbar_sidebar/side_bar.dart';

class AddMenuScreen extends StatefulWidget {
  const AddMenuScreen({super.key});

  @override
  State<AddMenuScreen> createState() => _AddMenuScreenState();
}

class _AddMenuScreenState extends State<AddMenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const Navbar(title: 'Add Menu'),
        body: Column(children: [
          Row(
            children: [
              SideBar(),
              Expanded(
                  child: Container(
                color: Colors.purple,
              ))
            ],
          ),
        ]));
  }
}
