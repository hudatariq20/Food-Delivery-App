import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_service/bloc/basket/basket_bloc.dart';
import 'package:food_delivery_service/models/restaurant_model.dart';
import 'package:flutter/widgets.dart';
import 'package:food_delivery_service/widgets/restaurant_information.dart';

class RestaurantDetailScreen extends StatelessWidget {
  const RestaurantDetailScreen({super.key, required this.restaurant});
  static const String routeName = '/restaurantDetail';

  static Route route({required Restaurant restaurant}) {
    return MaterialPageRoute(
        builder: ((_) => RestaurantDetailScreen(restaurant: restaurant)),
        settings: RouteSettings(name: routeName));
  }

  final Restaurant restaurant;
  @override
  Widget build(BuildContext context) {
    // Restaurant restaurant =
    //     Restaurant.restaurants[0]; //you can simple create a variable
    //in the build method and just initialize it.
    return Scaffold(
      //remove the appbar
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      bottomNavigationBar: BottomAppBar(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  shape: RoundedRectangleBorder()),
              onPressed: () {
                Navigator.pushNamed(context, '/basket');
              },
              child: Text('Basket'))
        ],
      )),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 250,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                      bottom: Radius.elliptical(
                          MediaQuery.of(context).size.width, 50)),
                  image: DecorationImage(
                      image: NetworkImage(restaurant.imageUrl),
                      fit: BoxFit.cover)),
            ),
            RestaurantInformation(
              restaurant: restaurant,
            ),
            ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                //the cards for displaying menuitems divided by tags
                itemCount: restaurant.tags.length,
                itemBuilder: ((context, index) {
                  return _buildMenuItems(restaurant, context, index);
                }))
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItems(
      //based on tags, show the menuitems.
      Restaurant restaurant,
      BuildContext context,
      int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Text(
            restaurant.tags[index],
            style: Theme.of(context)
                .textTheme
                .displaySmall!
                .copyWith(color: Theme.of(context).colorScheme.primary),
          ),
        ),
        Column(
            children: restaurant.menuitems
                .where(
                    (menuItem) => menuItem.category == restaurant.tags[index])
                .map((menuItem) => Column(
                      children: [
                        Container(
                          color: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: ListTile(
                            contentPadding: EdgeInsets.zero,
                            dense: true,
                            title: Text(
                              menuItem.name,
                              style: Theme.of(context).textTheme.displaySmall,
                            ),
                            subtitle: Text(
                              menuItem.description,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            trailing: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('\$${menuItem.price}',
                                    style:
                                        Theme.of(context).textTheme.bodyLarge),
                                BlocBuilder<BasketBloc, BasketState>(
                                  builder: (context, state) {
                                    return IconButton(
                                        icon: Icon(
                                          Icons.add_circle,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                        ),
                                        onPressed: () {
                                          context.read<BasketBloc>()
                                            ..add(AddItem(menuItem));
                                        },
                                      );
                                  },
                                )
                              ],
                            ),
                          ),
                        ),
                        Divider(
                          height: 2.0,
                        )
                      ],
                    ))
                .toList()),
      ],
    );
  }
}
