import 'package:flutter/material.dart';
import 'menu_item.dart';
import 'database.dart';
import 'image_picker.dart';
import 'navbar.dart';

void main() => runApp(HomeScreen());

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Database _database = Database();
  final ImagePickerService _imagePickerService = ImagePickerService();
  List<MenuItem> menuItems = [];
  List<MenuItem> selectedItems = [];

  @override
  void initState() {
    super.initState();
    _loadMenuItems();
  }

  Future<void> _loadMenuItems() async {
    menuItems = await _database.loadMenuItems();
    setState(() {});
  }

  Future<void> _saveMenuItems() async {
    await _database.saveMenuItems(menuItems);
  }

  Future<void> _pickImage(int index) async {
    final pickedImage = await _imagePickerService.pickImageFromGallery();
    setState(() {
      if (pickedImage != null) {
        menuItems[index].image = pickedImage;
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

  double _calculateTotalPrice() {
    double totalPrice = 0.0;
    for (final item in selectedItems) {
      totalPrice += item.price;
    }
    return totalPrice;
  }

  void _addToCart(MenuItem menuItem) {
    setState(() {
      selectedItems.add(menuItem);
    });
  }

  void _removeFromCart(MenuItem menuItem) {
    setState(() {
      selectedItems.remove(menuItem);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Navbar(title: 'Restaurant POS'),
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
                      IconButton(
                        icon: const Icon(Icons.add_shopping_cart),
                        onPressed: () {
                          _addToCart(menuItem);
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
              final selectedItem = selectedItems[index];
              return ListTile(
                title: Text(selectedItem.name),
                subtitle: Text(selectedItem.description),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('\บาท${selectedItem.price.toStringAsFixed(2)}'),
                    IconButton(
                      icon: const Icon(Icons.remove_shopping_cart),
                      onPressed: () {
                        _removeFromCart(selectedItem);
                      },
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 16.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  child: const Text('Place Order'),
                  onPressed: () {
                    // Handle order placement logic
                  },
                ),
                Text(
                  '\บาท${_calculateTotalPrice().toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 18.0),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: _addMenuItem,
            child: const Text('Add Item'),
          ),
        ],
      ),
    );
  }
}
