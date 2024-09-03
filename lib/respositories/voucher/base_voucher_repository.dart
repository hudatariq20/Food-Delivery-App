import 'package:food_delivery_service/models/voucher_model.dart';

abstract class BaseVoucherRepository {
  Future<bool> searchVoucher(String code);
  Stream<List<Voucher>> getVoucher();
}
