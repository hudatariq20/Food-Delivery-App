import 'package:equatable/equatable.dart';
import 'menu_item_model.dart';

class Restaurant extends Equatable {
  final int id;
  final String imageUrl;
  final String name;
  final List<String> tags;
  final List<MenuItem> menuitems;
  final int deliveryTime;
  final double deliveryFee;
  final double distance;
  final String categoryPrice;

  Restaurant(
      {required this.id,
      required this.imageUrl,
      required this.name,
      required this.tags,
      required this.menuitems,
      required this.deliveryTime,
      required this.deliveryFee,
      required this.distance,
      required this.categoryPrice});

  @override
  List<Object?> get props =>
      [id, imageUrl, name, tags, deliveryTime, deliveryFee, distance];

  static List<Restaurant> restaurants = [
    Restaurant(
        id: 1,
        imageUrl:
            'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2970&q=80',
        name: 'Golden Ice Gelato Artigonale',
        menuitems: MenuItem.menuItems
            .where((menuitem) => menuitem.restaurantId == 1)
            .toList(),
        tags: MenuItem.menuItems
            .where((menuItem) => menuItem.restaurantId == 1)
            .map((menuitem) => menuitem.category)
            .toSet()
            .toList(),
        categoryPrice: '\$',
        deliveryTime: 30,
        deliveryFee: 2.99,
        distance: 0.1),
    Restaurant(
        id: 2,
        imageUrl:
            'https://images.unsplash.com/photo-1508424757105-b6d5ad9329d0?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=3024&q=80',
        name: 'Panini del Laghitti',
        menuitems: MenuItem.menuItems
            .where((menuitem) => menuitem.restaurantId == 2)
            .toList(),
        tags: MenuItem.menuItems
            .where((menuItem) => menuItem.restaurantId == 2)
            .map((menuitem) => menuitem.category)
            .toSet()
            .toList(),
        categoryPrice: '\$',
        deliveryTime: 30,
        deliveryFee: 2.99,
        distance: 0.1),
    Restaurant(
        id: 3,
        imageUrl:
            'https://images.unsplash.com/photo-1508424757105-b6d5ad9329d0?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=3024&q=80',
        name: 'Tandori Bites',
        menuitems: MenuItem.menuItems
            .where((menuitem) => menuitem.restaurantId == 3)
            .toList(),
        tags: MenuItem.menuItems
            .where((menuItem) => menuItem.restaurantId == 3)
            .map((menuitem) => menuitem.category)
            .toSet()
            .toList(),
        categoryPrice: '\$',
        deliveryTime: 30,
        deliveryFee: 2.99,
        distance: 0.1),
    Restaurant(
        id: 4,
        imageUrl:
            'https://images.unsplash.com/photo-1466978913421-dad2ebd01d17?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=3174&q=80',
        name: 'Burgers',
        menuitems: MenuItem.menuItems
            .where((menuitem) => menuitem.restaurantId == 4)
            .toList(),
        tags: MenuItem.menuItems
            .where((menuItem) => menuItem.restaurantId == 4)
            .map((menuitem) => menuitem.category)
            .toSet()
            .toList(),
        categoryPrice: '\$',
        deliveryTime: 30,
        deliveryFee: 2.99,
        distance: 0.1)
  ];
}
