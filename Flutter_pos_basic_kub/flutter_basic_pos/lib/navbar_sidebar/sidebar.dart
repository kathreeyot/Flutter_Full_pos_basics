import 'package:flutter/material.dart';
import 'package:flutter_basic_pos/FormScreen/homescreen.dart';

class SideBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Sidebar',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            title: Text('ยอดที่ได้วันนี้'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return HomeScreen();
              }));
            },
          ),
        ],
      ),
    );
  }
}
