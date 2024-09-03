import 'package:flutter/material.dart';
import 'package:food_delivery_service/models/restaurant_model.dart';
import 'package:food_delivery_service/widgets/restaurant_card.dart';

class RestaurantListingScreen extends StatelessWidget {
  const RestaurantListingScreen({super.key, required this.restaurants});
  final List<Restaurant> restaurants;
  static const String routeName = '/restaurantListing';

  static Route route({required List<Restaurant> restaurants}) {
    return MaterialPageRoute(
        builder: ((_) => RestaurantListingScreen(restaurants: restaurants)),
        settings: RouteSettings(name: routeName));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Restaurant')),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
              itemCount: restaurants.length,
              itemBuilder: ((context, index) {
                return RestaurantCard(restaurant: restaurants[index]);
              })),
        ));
  }
}
