import 'package:flutter/material.dart';
import 'package:food_delivery_service/models/price_model.dart';

class FoodSearchBox extends StatelessWidget {
  final List<Price> prices;
  const FoodSearchBox({super.key, required this.prices});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(5.0)),
        child: IconButton(
          icon: Icon(
            Icons.menu,
            color: Theme.of(context).colorScheme.primary,
          ),
          onPressed: () {
            Navigator.pushNamed(
              context,
              '/filter',
              arguments: prices
            );
          },
        ),
      ),
    );
  }
}
