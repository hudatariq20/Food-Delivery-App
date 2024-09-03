import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food_delivery_service/bloc/voucher/vouchers_bloc.dart';
import 'package:food_delivery_service/models/basket_model.dart';
import 'package:food_delivery_service/models/delivery_time_model.dart';
import 'package:food_delivery_service/models/menu_item_model.dart';
import 'package:food_delivery_service/models/voucher_model.dart';
import 'package:food_delivery_service/respositories/voucher/voucher_repository.dart';
part 'basket_event.dart';
part 'basket_state.dart';

class BasketBloc extends Bloc<BasketEvent, BasketState> {
  final VouchersBloc _vouchersBloc;
  late StreamSubscription streamSubscription;
  BasketBloc({required VouchersBloc vouchersBloc})
      : _vouchersBloc = vouchersBloc,
        super(BasketLoading()) {
    on<StartBasket>(_onStartBasket);
    on<AddItem>(_onAddItem);
    on<RemoveItem>(_onRemoveItem);
    on<ToggleSwitch>(_onToggleSwitch);
    on<RemoveAllItems>(_onRemoveAllItems);
    on<AddVoucher>(_onAddVoucher);
    on<AddDeliveryTime>(_onAddDeliveryTime);

    streamSubscription = vouchersBloc.stream.listen((state) {
      if (state is VoucherSelected) {
        add(AddVoucher(state.voucher));
      }
    });
  }

  void _onStartBasket(StartBasket event, Emitter<BasketState> emit) async {
    emit(BasketLoading());
    try {
      await Future<void>.delayed(const Duration(seconds: 1));
      emit(BasketLoaded(basket: Basket()));
    } catch (_) {}
  }

  void _onAddItem(AddItem event, Emitter<BasketState> emit) {
    final state = this.state;
    if (state is BasketLoaded) {
      try {
        emit(BasketLoaded(
          basket: state.basket.copyWith(
              menuItems: List.from(state.basket.menuItems)..add(event.item)),
        ));
      } catch (_) {}
    }
  }

  void _onRemoveItem(RemoveItem event, Emitter<BasketState> emit) {
    final state = this.state;
    if (state is BasketLoaded) {
      try {
        emit(BasketLoaded(
            basket: state.basket.copyWith(
                menuItems: List.from(state.basket.menuItems)
                  ..remove(event.item))));
      } catch (_) {}
    }
  }

  void _onToggleSwitch(ToggleSwitch event, Emitter<BasketState> emit) {
    final state = this.state;
    if (state is BasketLoaded) {
      emit(BasketLoaded(
          basket: state.basket.copyWith(cutlery: !state.basket.cutlery)));
    }
  }

  void _onRemoveAllItems(RemoveAllItems event, Emitter<BasketState> emit) {
    final state = this.state;
    if (state is BasketLoaded) {
      try {
        emit(BasketLoaded(
            basket: state.basket.copyWith(
                menuItems: List.from(state.basket.menuItems)
                  ..removeWhere((item) => item == event.item))));
      } catch (_) {}
    }
  }

  void _onAddVoucher(AddVoucher event, Emitter<BasketState> emit) {
    final state = this.state;
    if (state is BasketLoaded) {
      try {
        emit(BasketLoaded(
            basket: state.basket.copyWith(voucher: event.voucher)));
      } catch (_) {}
    }
  }

  void _onAddDeliveryTime(AddDeliveryTime event, Emitter<BasketState> emit) {
    final state = this.state;
    if (state is BasketLoaded) {
      try {
        emit(BasketLoaded(
            basket: state.basket.copyWith(deliveryTime: event.deliveryTime)));
      } catch (_) {}
    }
  }
}
