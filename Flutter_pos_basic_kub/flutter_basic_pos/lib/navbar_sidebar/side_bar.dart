import 'package:flutter/material.dart';
import 'package:flutter_basic_pos/FormScreen/add_menu_screen.dart';
import 'package:flutter_basic_pos/FormScreen/check_bill.dart';
import 'package:flutter_basic_pos/FormScreen/order_screen.dart';
import 'package:flutter_basic_pos/FormScreen/summary_price.dart';

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
              color: Colors.red,
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
              title: const Text('Add Menu'),
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AddMenuScreen()))),
          ListTile(
            title: const Text('Check Bill'),
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => const CheckBill())),
          ),
          ListTile(
            title: const Text('Order Screen'),
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => const OrderScreen())),
          ),
          ListTile(
            title: const Text('Summary'),
            onTap: () => Navigator.pop(context,
                MaterialPageRoute(builder: (context) => const SummaryPrice())),
          )
        ],
      ),
    );
  }
}
