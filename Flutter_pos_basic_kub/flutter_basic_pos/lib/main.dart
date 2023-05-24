import 'dart:convert';
import 'dart:io';
import 'package:flutter_basic_pos/menu_item.dart';
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
      home: const PosHomePage(),
    );
  }
}

class PosHomePage extends StatefulWidget {
  const PosHomePage({super.key});

  @override
  _PosHomePageState createState() => _PosHomePageState();
}

class _PosHomePageState extends State<PosHomePage> {
  SharedPreferences? _preferences;
  List<MenuItem> menuItems = [];
  List<MenuItem> selectedItems = [];

  @override
  void initState() {
    super.initState();
    _loadMenuItems();
  }

  Future<void> _loadMenuItems() async {
    _preferences = await SharedPreferences.getInstance();
    final List<String>? savedItems = _preferences!.getStringList('menuItems');
    if (savedItems != null) {
      setState(() {
        menuItems = savedItems
            .map((item) => MenuItem.fromMap(jsonDecode(item)))
            .toList();
      });
    }
  }

  Future<void> _saveMenuItems() async {
    final List<String> items =
        menuItems.map((item) => jsonEncode(item.toMap())).toList();
    await _preferences!.setStringList('menuItems', items);
  }

  Future<void> _pickImage(int index) async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedImage != null) {
        menuItems[index].image = File(pickedImage.path);
      }
    });
  }

  void _editMenuItem(MenuItem menuItem) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String editedName = menuItem.name;
        String editedDescription = menuItem.description;
        double editedPrice = menuItem.price;

        return AlertDialog(
          title: const Text('Edit Menu Item'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Name'),
                onChanged: (value) {
                  editedName = value;
                },
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Description'),
                onChanged: (value) {
                  editedDescription = value;
                },
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  editedPrice = double.tryParse(value) ?? 0.0;
                },
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    child: const Text('Pick Image'),
                    onPressed: () {
                      _pickImage(menuItems.indexOf(menuItem));
                    },
                  ),
                ],
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text('Save'),
              onPressed: () {
                setState(() {
                  menuItem.name = editedName;
                  menuItem.description = editedDescription;
                  menuItem.price = editedPrice;
                });
                Navigator.of(context).pop();
                _saveMenuItems();
              },
            ),
          ],
        );
      },
    );
  }

  void _deleteMenuItem(MenuItem menuItem) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Menu Item'),
          content: const Text('Are you sure you want to delete this item?'),
          actions: [
            ElevatedButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text('Delete'),
              onPressed: () {
                setState(() {
                  menuItems.remove(menuItem);
                });
                Navigator.of(context).pop();
                _saveMenuItems();
              },
            ),
          ],
        );
      },
    );
  }

  void _addMenuItem() {
    setState(() {
      menuItems.add(MenuItem('New Item', 'Description', 0.0, null));
    });
    _saveMenuItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurant POS'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: menuItems.length,
              itemBuilder: (ctx, index) {
                final menuItem = menuItems[index];
                return ListTile(
                  leading: menuItem.image != null
                      ? CircleAvatar(
                          backgroundImage: FileImage(menuItem.image!),
                        )
                      : const Icon(Icons.image),
                  title: Text(menuItem.name),
                  subtitle: Text(menuItem.description),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(menuItem.price.toString()),
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          _editMenuItem(menuItem);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          _deleteMenuItem(menuItem);
                        },
                      ),
                    ],
                  ),
                  
                );
              },
            ),
          ),
          const Divider(),
          const Text('Selected Items'),
          ListView.builder(
            shrinkWrap: true,
            itemCount: selectedItems.length,
            itemBuilder: (ctx, index) {
              return ListTile(
                title: Text(selectedItems[index].name),
                subtitle: Text(selectedItems[index].description),
                trailing:
                    Text('\$${selectedItems[index].price.toStringAsFixed(2)}'),
              );
            },
          ),
          ElevatedButton(
            child: const Text('Place Order'),
            onPressed: () {
              // Handle order placement logic
            },
          ),
          ElevatedButton(
            onPressed: _addMenuItem,
            child: const Text('Add Item'),
          ),
        ],
      ),
    );
  }
}
