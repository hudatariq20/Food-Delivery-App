import 'package:flutter/material.dart';
import 'package:food_delivery_service/models/restaurant_model.dart';
import 'package:food_delivery_service/widgets/restaurant_tags.dart';

class RestaurantInformation extends StatelessWidget {
  final Restaurant restaurant;
  const RestaurantInformation({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            restaurant.name,
            style: Theme.of(context)
                .textTheme
                .displaySmall!
                .copyWith(color: Theme.of(context).colorScheme.primary),
          ),
          SizedBox(
            height: 10,
          ),
          RestaurantTags(restaurant: restaurant),
          SizedBox(
            height: 10,
          ),
          Text(
              '${restaurant.distance}km - \$${restaurant.deliveryFee} Delivery fee',
              style: Theme.of(context).textTheme.bodyLarge),
          SizedBox(height: 10,),
          Text('Restaurant Information', style: Theme.of(context).textTheme.displaySmall,),
          SizedBox(height: 10,),
          Text('lorep usmlkmdcmkpwojem  ckonsokv roemgplmlskdmfls jknlskdfkljsksnfloskn  slkdcnsklnvdlskvn', 
           style: Theme.of(context).textTheme.bodyLarge)
        ],
      ),
    );
  }
}
