import 'package:flutter/material.dart';
import 'package:food_delivery_service/models/price_model.dart';
import 'package:food_delivery_service/models/restaurant_model.dart';
import 'package:food_delivery_service/screens/edit_basket/edit_basket_screen.dart';
import 'package:food_delivery_service/screens/home/home_screen.dart';
import 'package:food_delivery_service/screens/profile/profile_screen.dart';
import 'package:food_delivery_service/screens/screens.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    print('the route name is ${settings.name}');
    switch (settings.name) {
      case '/':
        return HomeScreen.route();
      case '/home':
        return HomeScreen.route();
      case '/location':
        return LocationScreen.route();
      case '/basket':
        return Basket.route();
      case '/edit-basket':
        return EditBasket.route();
      case '/checkout':
        return CheckoutScreen.route();
      case '/deliverytime':
        return DeliveryTimeScreen.route();
      case '/filter':
        return FilterScreen.route();
      case '/restaurantDetail':
        return RestaurantDetailScreen.route(
            restaurant: settings.arguments as Restaurant);
      case '/restaurantListing':
        return RestaurantListingScreen.route(
            restaurants: settings.arguments as List<Restaurant>);
      case '/voucher':
        return VoucherScreen.route();
      case '/profile':
        return ProfileScreen.route();
        break;
      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(
        builder: ((_) => Scaffold(
              appBar: AppBar(title: Text('error')),
            )),
        settings: RouteSettings(name: '/error'));
  }
}
