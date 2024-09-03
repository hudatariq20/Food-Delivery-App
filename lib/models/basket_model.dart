import 'package:equatable/equatable.dart';
import 'package:food_delivery_service/models/delivery_time_model.dart';
import 'package:food_delivery_service/models/menu_item_model.dart';
import 'package:food_delivery_service/models/voucher_model.dart';

class Basket extends Equatable {
  final List<MenuItem> menuItems;
  final bool cutlery;
  final Voucher? voucher;
  final DeliveryTime? deliveryTime;

  Basket({
    this.menuItems = const <MenuItem>[],
    this.cutlery = false,
    this.voucher,
    this.deliveryTime,
  });

  Basket copyWith(
      {List<MenuItem>? menuItems,
      bool? cutlery,
      Voucher? voucher,
      DeliveryTime? deliveryTime}) {
    return Basket(
        menuItems: menuItems ?? this.menuItems,
        cutlery: cutlery ?? this.cutlery,
        voucher: voucher ?? this.voucher,
        deliveryTime: deliveryTime ?? this.deliveryTime);
  }

  @override
  List<Object?> get props => [menuItems, cutlery, voucher, deliveryTime];

  //convert list into map
  Map itemQuantity(items) {
    var quantity = Map();

    items.forEach((item) {
      if (!quantity.containsKey(item)) {
        quantity[item] = 1;
      } else {
        quantity[item] += 1;
      }
    });
    return quantity;
  }

  double get subtotal =>
      menuItems.fold(0, (total, current) => total + current.price);

  double total(subtotal) {
    return (voucher == null) ? subtotal + 5 : subtotal + 5 - voucher!.value;
  }

  String get subtotalString => subtotal.toStringAsFixed(2);
  String get totalString => total(subtotal).toStringAsFixed(2);
}
