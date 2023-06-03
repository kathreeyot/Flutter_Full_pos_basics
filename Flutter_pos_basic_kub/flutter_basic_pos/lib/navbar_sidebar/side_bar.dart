import 'package:flutter/material.dart';
import 'package:flutter_basic_pos/FormScreen/add_menu_screen.dart';
import 'package:flutter_basic_pos/FormScreen/check_bill.dart';
import 'package:flutter_basic_pos/FormScreen/home_screen.dart';
import 'package:flutter_basic_pos/FormScreen/order_screen.dart';
import 'package:flutter_basic_pos/FormScreen/summary_price.dart';

class SideBar extends StatelessWidget {
  const SideBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60, // Set the width of the side menu as per your requirement
      color: Colors.black38, // Set the background color of the side menu
      height: 500,
      // Add your menu items here
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
              leading: const Icon(Icons.home),
              iconColor: Colors.white,
              title: const Text(''),
              textColor: Colors.white,
              onTap: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => const HomeScreen())))),
          ListTile(
              leading: const Icon(Icons.add_circle),
              iconColor: Colors.white,
              title: const Text(''),
              textColor: Colors.white,
              onTap: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: ((context) =>  AddMenuScreen(onItemAdded: (MenuItem ) {  },))))),
          ListTile(
              leading: const Icon(Icons.account_balance_wallet),
              iconColor: Colors.white,
              title: const Text(''),
              textColor: Colors.white,
              onTap: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => const CheckBill())))),
          ListTile(
              leading: const Icon(Icons.app_registration),
              iconColor: Colors.white,
              title: const Text(''),
              textColor: Colors.white,
              onTap: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => const OrderScreen())))),
          ListTile(
              leading: const Icon(Icons.account_balance),
              iconColor: Colors.white,
              title: const Text(''),
              textColor: Colors.white,
              onTap: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => const SummaryPrice())))),
        ],
      ),
    );
  }
}
