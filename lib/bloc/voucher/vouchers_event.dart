// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'vouchers_bloc.dart';

abstract class VouchersEvent extends Equatable {}

class LoadVoucher extends VouchersEvent {
  @override
  List<Object?> get props => [];
}

class UpdateVouchers extends VouchersEvent {
  final List<Voucher> vouchers;
  UpdateVouchers({this.vouchers = const <Voucher>[]});

  @override
  List<Object?> get props => [vouchers];
}

class SelectVoucher extends VouchersEvent {
  final Voucher voucher;

  SelectVoucher({required this.voucher});
  

  @override
  List<Object?> get props => [voucher];
}
