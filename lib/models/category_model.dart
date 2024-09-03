import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Category extends Equatable {
  final int id;
  final String name;
  final Image image;

  Category({required this.id, required this.name, required this.image});

  @override
  // TODO: implement props
  List<Object?> get props => [id,name,image];
  
  static List<Category> categories = [
    Category(
      id: 1,
      name: 'Drinks',
    //  description: 'This is a test description',
      image: Image.asset('assets/juice.png'),
    //  index: 0,
    ),
    Category(
      id: 2,
      name: 'Pizza',
    //  description: 'This is a test description',
      image: Image.asset('assets/pizza.png'),
    //  index: 1,
    ),
    Category(
      id: 3,
      name: 'Burgers',
    // description: 'This is a test description',
      image: Image.asset('assets/burger.png'),
     //index: 2,
    ),
    Category(
      id: 4,
      name: 'Desserts',
      //description: 'This is a test description',
      image: Image.asset('assets/pancake.png'),
      //index: 3,
    ),
    Category(
      id: 5,
      name: 'Salads',
    //  description: 'This is a test description',
      image: Image.asset('assets/avocado.png'),
     // index: 4,
    ),
  ];
}
