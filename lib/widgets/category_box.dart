import 'package:flutter/material.dart';
import 'package:food_delivery_service/models/restaurant_model.dart';

import '../models/category_model.dart';

class CategoryBox extends StatelessWidget {
  final Category category;
  const CategoryBox({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final List<Restaurant> restaurants = Restaurant.restaurants
        .where((restaurant) => restaurant.tags.contains(category.name))
        .toList();
    return InkWell(
      onTap: (() {
        Navigator.pushNamed(context, '/restaurantListing',
            arguments: restaurants);
      }),
      child: Container(
        width: 100,
        margin: EdgeInsets.only(right: 5.0),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(5.0)),
        child: Stack(
          children: [
            //image
            Positioned(
              top: 10,
              left: 10,
              child: Container(
                  width: 80,
                  height: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: Colors.white),
                  child: category.image),
            ),
            //text
            Padding(
              padding: const EdgeInsets.all(8.0), //so doesn't touch the bottom
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    category.name,
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .copyWith(color: Colors.white),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
