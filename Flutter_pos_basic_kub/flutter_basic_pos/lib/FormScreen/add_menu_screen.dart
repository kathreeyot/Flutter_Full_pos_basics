import 'package:flutter/material.dart';
import 'package:flutter_basic_pos/navbar_sidebar/nav_bar.dart';

import '../database/data_base.dart';
import '../navbar_sidebar/side_bar.dart';
import '../required data/menu_item.dart';
import 'image_picker.dart';

class AddMenuScreen extends StatefulWidget {
  const AddMenuScreen({super.key, required this.onItemAdded});
  final Function(MenuItem) onItemAdded;

  @override
  State<AddMenuScreen> createState() => _AddMenuScreenState();
}

class _AddMenuScreenState extends State<AddMenuScreen> {
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
      final newItem = MenuItem('New Item', 'Description', 0.0, null);
      menuItems.add(newItem);
      widget.onItemAdded(newItem); // Trigger the callback function
    });
    _saveMenuItems();
  }

  double _calculateTotalPrice() {
    double totalPrice = 0.0;
    for (final item in selectedItems) {
      totalPrice += item.price * item.quantity;
    }
    return totalPrice;
  }

  void _addToCart(MenuItem menuItem) {
    setState(() {
      final existingItemIndex =
          selectedItems.indexWhere((item) => item.name == menuItem.name);

      if (existingItemIndex != -1) {
        selectedItems[existingItemIndex].quantity++;
      } else {
        selectedItems.add(MenuItem(
          menuItem.name,
          menuItem.description,
          menuItem.price,
          menuItem.image,
        ));
      }
    });
  }

  void _removeFromCart(MenuItem menuItem) {
    setState(() {
      final existingItemIndex =
          selectedItems.indexWhere((item) => item.name == menuItem.name);

      if (existingItemIndex != -1) {
        selectedItems[existingItemIndex].quantity--;
        if (selectedItems[existingItemIndex].quantity <= 0) {
          selectedItems.removeAt(existingItemIndex);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Navbar(title: 'Add Menu'),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SideBar(),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 300,
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
                ),
                const Divider(),
                const Text('Selected Items'),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: selectedItems.length,
                    itemBuilder: (ctx, index) {
                      final selectedItem = selectedItems[index];
                      return ListTile(
                        title: Text(selectedItem.name),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(selectedItem.description),
                            Text(
                              'Quantity: ${selectedItem.quantity}',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                                '${(selectedItem.price * selectedItem.quantity).toStringAsFixed(2)}บาท'),
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
                ),
                const SizedBox(height: 16.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.purple),
                        child: const Text('Place Order'),
                        onPressed: () {},
                      ),
                      Text(
                        '${_calculateTotalPrice().toStringAsFixed(2)}บาท',
                        style: const TextStyle(fontSize: 18.0),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.purple),
                  onPressed: _addMenuItem,
                  child: const Text('Add Item'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
