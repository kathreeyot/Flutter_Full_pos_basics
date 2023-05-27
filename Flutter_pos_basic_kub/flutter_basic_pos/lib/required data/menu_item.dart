import 'dart:io';

class MenuItem {
  String name;
  String description;
  double price;
  File? image;
  int quantity; 

  MenuItem(this.name, this.description, this.price, this.image, {this.quantity = 1});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'price': price,
      'image': image?.path,
    };
  }

  factory MenuItem.fromMap(Map<String, dynamic> map) {
    return MenuItem(
      map['name'],
      map['description'],
      map['price'],
      map['image'] != null ? File(map['image']) : null,
    );
  }
}