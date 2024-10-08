part of 'basket_bloc.dart';

abstract class BasketEvent extends Equatable {
  const BasketEvent();
  @override
  List<Object?> get props => [];
}

class StartBasket extends BasketEvent {
  const StartBasket();
  @override
  List<Object?> get props => [];
}

class AddItem extends BasketEvent {
  final MenuItem item;

  const AddItem(this.item);
  @override
  List<Object?> get props => [item];
}

class RemoveItem extends BasketEvent {
  final MenuItem item;

  const RemoveItem(this.item);
  @override
  List<Object?> get props => [item];
}

class RemoveAllItems extends BasketEvent {
  final MenuItem item;

  const RemoveAllItems(this.item);
  @override
  List<Object?> get props => [item];
}

class ToggleSwitch extends BasketEvent {
  const ToggleSwitch();
  @override
  List<Object?> get props => [];
}

class AddVoucher extends BasketEvent {
  final Voucher voucher;

  const AddVoucher(this.voucher);
  @override
  List<Object?> get props => [voucher];
}

class AddDeliveryTime extends BasketEvent{
  final DeliveryTime deliveryTime;

  const AddDeliveryTime(this.deliveryTime);
  @override
  List<Object?> get props => [deliveryTime];

}
