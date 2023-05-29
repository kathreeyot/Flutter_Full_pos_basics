import 'package:flutter/material.dart';
import '../FormScreen/addmenu.screen.dart';

class SideBar extends StatelessWidget {
  const SideBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
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
            title: const Text("Add Menu"),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const AddMenuScreen();
              }));
            },
          ),
        ],
      ),
    );
  }
}
