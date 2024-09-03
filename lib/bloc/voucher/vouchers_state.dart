part of 'vouchers_bloc.dart';

abstract class VouchersState extends Equatable {
  const VouchersState();
   @override
  List<Object?> get props => [];

}

 class VoucherLoading extends VouchersState {

   @override
  List<Object?> get props => [];
  }

  class VoucherLoaded extends VouchersState{
  final List<Voucher> vouchers;

  VoucherLoaded({ this.vouchers = const<Voucher>[]});

   @override
  List<Object?> get props => [vouchers];
  }

class VoucherSelected extends VouchersState{

 final Voucher voucher;

  VoucherSelected({ required this.voucher});

   @override
  List<Object?> get props => [voucher];
}
