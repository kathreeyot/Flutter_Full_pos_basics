import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() => runApp(PosApp());

class PosApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant POS',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PosHomePage(),
    );
  }
}

class PosHomePage extends StatefulWidget {
  @override
  _PosHomePageState createState() => _PosHomePageState();
}

class _PosHomePageState extends State<PosHomePage> {
  List<MenuItem> menuItems = [
    MenuItem('Burger', 'A delicious burger', 9.99, null),
    MenuItem('Pizza', 'Freshly baked pizza', 12.99, null),
    MenuItem('Salad', 'Healthy salad', 7.99, null),
  ];

  List<MenuItem> selectedItems = [];

  Future<void> _pickImage(int index) async {
    final pickedImage = await ImagePicker().getImage(source: ImageSource.gallery);
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
          title: Text('Edit Menu Item'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Name'),
                onChanged: (value) {
                  editedName = value;
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Description'),
                onChanged: (value) {
                  editedDescription = value;
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  editedPrice = double.tryParse(value) ?? 0.0;
                },
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    child: Text('Pick Image'),
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
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text('Save'),
              onPressed: () {
                setState(() {
                  menuItem.name = editedName;
                  menuItem.description = editedDescription;
                  menuItem.price = editedPrice;
                });
                Navigator.of(context).pop();
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
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Restaurant POS'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: menuItems.length,
              itemBuilder: (ctx, index) {
                return ListTile(
                  leading: menuItems[index].image != null
                      ? CircleAvatar(
                          backgroundImage: FileImage(menuItems[index].image!),
                        )
                      : Icon(Icons.image),
                  title: Text(menuItems[index].name),
                  subtitle: Text(menuItems[index].description),
                  trailing: Text('\$${menuItems[index].price.toStringAsFixed(2)}'),
                  onTap: () {
                    _editMenuItem(menuItems[index]);
                  },
                );
              },
            ),
          ),
          Divider(),
          Text('Selected Items'),
          ListView.builder(
            shrinkWrap: true,
            itemCount: selectedItems.length,
            itemBuilder: (ctx, index) {
              return ListTile(
                title: Text(selectedItems[index].name),
                subtitle: Text(selectedItems[index].description),
                trailing: Text('\$${selectedItems[index].price.toStringAsFixed(2)}'),
              );
            },
          ),
          ElevatedButton(
            child: Text('Place Order'),
            onPressed: () {
              // Handle order placement logic
            },
          ),
          ElevatedButton(
            child: Text('Add Item'),
            onPressed: _addMenuItem,
          ),
        ],
      ),
    );
  }
}

class MenuItem {
  String name;
  String description;
  double price;
  File? image;

  MenuItem(this.name, this.description, this.price, this.image);
}
