import 'package:equatable/equatable.dart';
import 'package:food_delivery_service/models/price_model.dart';

class PriceFilter extends Equatable {
  final int id;
  final Price price;
  final bool value;

  PriceFilter(
      {required this.id, required this.price, required this.value});

  PriceFilter copyWith({int? id, Price? category, bool? value}) {
    return PriceFilter(
        id: id ?? this.id,
        price: category ?? this.price,
        value: value ?? this.value);
  }

  @override
  List<Object?> get props => [id, price, value];

  static List<PriceFilter> filters = Price.prices
      .map((price) =>
          PriceFilter(id: price.id, price: price, value: false))
      .toList();
}
