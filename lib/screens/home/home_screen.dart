import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_service/bloc/location/location_bloc.dart';
import 'package:food_delivery_service/models/category_model.dart';
import 'package:food_delivery_service/models/price_model.dart';
import 'package:food_delivery_service/models/promo_model.dart';
import 'package:food_delivery_service/models/restaurant_model.dart';
import 'package:food_delivery_service/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const String routeName = '/';

  static Route route() {
    return MaterialPageRoute(
        builder: ((_) => HomeScreen()),
        settings: RouteSettings(name: routeName));
  }

  @override
  Widget build(BuildContext context) {
    List<Price> prices = Price.prices;
    return Scaffold(
        appBar: CustomAppBar(),
        //backgroundColor: Theme.of(context).colorScheme.background,
        body: SingleChildScrollView(
          child: Column(
            children: [
              //to wrap a listview widget  --- categories
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 100,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: Category.categories.length,
                      itemBuilder: ((context, index) {
                        return CategoryBox(
                            category: Category.categories[index]);
                      })),
                ),
              ),

              //promo box
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 140,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: Promo.promos.length,
                      itemBuilder: ((context, index) {
                        return PromoBox(
                          promo: Promo.promos[index],
                        );
                      })),
                ),
              ),
              //One search box and one filter.
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: TextField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'What would you like to eat?',
                          suffixIcon: Icon(
                            Icons.search,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          contentPadding: const EdgeInsets.only(
                              left: 20, right: 5, top: 12.5),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.white)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.white)),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  FoodSearchBox(
                    prices: prices,
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Top Rated',
                      style: Theme.of(context).textTheme.headlineMedium,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: Restaurant.restaurants.length,
                    itemBuilder: ((context, index) {
                      return RestaurantCard(
                          restaurant: Restaurant.restaurants[index]);
                    })),
              )
            ],
          ),
        ));
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.person),
        onPressed: () {
          Navigator.pushNamed(context, '/profile');
        }, //add profile page...
      ),
      centerTitle: false,
      title: BlocBuilder<LocationBloc, LocationState>(
        builder: (context, state) {
          if (state is LocationLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is LocationLoaded) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Current Location',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: Colors.white),
                ),
                Text(
                  state.place.name,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: Colors.white),
                )
              ],
            );
          } else {
            return Text('Something went wrong');
          }
        },
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56.0);
}
