import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_service/bloc/filter/filter_bloc.dart';
import 'package:food_delivery_service/models/category_model.dart';
import 'package:food_delivery_service/models/price_model.dart';
import 'package:food_delivery_service/models/restaurant_model.dart';
import 'package:food_delivery_service/widgets/widgets.dart';

class FilterScreen extends StatelessWidget {
  const FilterScreen({
    super.key,
  });
  static const String routeName = '/filter';

  static Route route() {
    return MaterialPageRoute(
        builder: ((_) => FilterScreen()),
        settings: RouteSettings(name: routeName));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(
              Icons.close,
              color: Theme.of(context).colorScheme.primary,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Text(
              'Filters',
              style: Theme.of(context)
                  .textTheme
                  .displayMedium!
                  .copyWith(color: Theme.of(context).colorScheme.primary),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Price',
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(
                              color: Theme.of(context).colorScheme.primary)),
                  //custom price filter
                  CustomPriceFilter(),

                  Text('Categories',
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(
                              color: Theme.of(context).colorScheme.primary)),
                  //custom category filter
                  CustomCategoryFilter()
                ],
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<FilterBloc, FilterState>(
              builder: (context, state) {
                if (state is FilterLoading) {
                  return CircularProgressIndicator();
                } else if (state is FilterLoaded) {
                  return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 50),
                          shape: RoundedRectangleBorder()),
                      onPressed: () {
                        //first take out the categories and prices filtered in the custom price and category
                        var categories = state.filter.categoryFilter
                            .where((filter) => filter.value)
                            .map((filter) => filter.category.name)
                            .toList();
                        print(categories);
                        var prices = state.filter.priceFilter
                            .where((filter) => filter.value)
                            .map((filter) => filter.price.price)
                            .toList();
                        print(prices);
                        //next filter the restaurants based on those filters.
                        List<Restaurant> restaurants = Restaurant.restaurants
                            .where((restaurant) => categories.any((category) =>
                                restaurant.tags.contains(category)))
                            .where((restaurant) => prices.any((price) =>
                                restaurant.categoryPrice.contains(price)))
                            .toList();
                        Navigator.pushNamed(context, '/restaurantListing',
                            arguments: restaurants);
                      },
                      child: Text('Apply'));
                } else {
                  return Text('Something went wrong');
                }
              },
            )
          ],
        )));
  }
}
