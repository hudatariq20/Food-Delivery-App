import 'package:flutter/material.dart';
import 'package:food_delivery_service/models/restaurant_model.dart';
import 'package:food_delivery_service/widgets/restaurant_tags.dart';

class RestaurantCard extends StatelessWidget {
  final Restaurant restaurant;
  const RestaurantCard({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (() {
        Navigator.pushNamed(context, '/restaurantDetail',
            arguments: restaurant);
      }),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 150,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  image: DecorationImage(
                      image: NetworkImage(restaurant.imageUrl),
                      fit: BoxFit.cover)),
            ),
            Positioned(
              top: 10,
              right: 10,
              child: Container(
                height: 30,
                width: 60,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5.0)),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    '${restaurant.deliveryTime} mins',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ),
            ),
          ]),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  restaurant.name,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                SizedBox(
                  height: 5,
                ),
                //  Text('${restaurant.tags}'), show tags as string not list of strings
                RestaurantTags(restaurant: restaurant),
                SizedBox(
                  height: 5,
                ),
                Text(
                    '${restaurant.distance}km - \$${restaurant.deliveryFee} delivery Fee',
                    style: Theme.of(context).textTheme.bodyLarge)
              ],
            ),
          )
        ],
      ),
    );
  }
}
