import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food_delivery_service/models/voucher_model.dart';
import 'package:food_delivery_service/respositories/voucher/voucher_repository.dart';
import 'package:meta/meta.dart';

part 'vouchers_event.dart';
part 'vouchers_state.dart';

class VouchersBloc extends Bloc<VouchersEvent, VouchersState> {
  final VoucherRepository _voucherRepository;
  StreamSubscription? _streamSubscription;
  VouchersBloc({required VoucherRepository voucherRepository})
      : _voucherRepository = voucherRepository,
        super(VoucherLoading()) {
    on<LoadVoucher>(_onLoadVoucher);
    on<SelectVoucher>(_onSelectVoucher);
    on<UpdateVouchers>(_onUpdateVoucher);

  }

  void _onLoadVoucher(LoadVoucher event, Emitter<VouchersState> emit) {
    _streamSubscription?.cancel();
    _streamSubscription = _voucherRepository.getVoucher().listen((vouchers) {
      add(UpdateVouchers(vouchers: vouchers));
    });
  }

  void _onSelectVoucher(SelectVoucher event, Emitter<VouchersState> emit) {
    emit(VoucherSelected(voucher: event.voucher)); //pass new voucher as an input.
  }

  void _onUpdateVoucher(UpdateVouchers event, Emitter<VouchersState> emit) {
    emit(VoucherLoaded(vouchers: event.vouchers));
  }
}
