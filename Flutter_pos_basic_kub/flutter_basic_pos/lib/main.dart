import 'dart:convert';
import 'dart:io';
import 'package:flutter_basic_pos/FormScreen/homescreen.dart';
import 'package:flutter_basic_pos/required%20data/menu_item.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(const PosApp());

class PosApp extends StatelessWidget {
  const PosApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant POS',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  HomeScreen(),
    );
  }
}

