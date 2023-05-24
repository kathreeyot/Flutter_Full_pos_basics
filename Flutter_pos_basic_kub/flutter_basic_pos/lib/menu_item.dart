import 'dart:io';

class MenuItem {
  String name;
  String description;
  double price;
  File? image;

  MenuItem(this.name, this.description, this.price, this.image);
}
