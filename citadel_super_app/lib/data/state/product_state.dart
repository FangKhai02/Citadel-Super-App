import 'package:citadel_super_app/data/repository/product_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final productFutureProvider = FutureProvider.autoDispose((ref) async {
  final list = await ProductRepository().getProductList();
  // list.sort((a, b) => a.priority?.compareTo(b.priority ?? 0) ?? 0);
  return list;
});

final productDetailFutureProvider =
    FutureProvider.autoDispose.family((ref, int productId) async {
  return await ProductRepository().getProductDetailById(productId);
});

final paymentReceiptsFutureProvider =
    FutureProvider.autoDispose.family((ref, String referenceNumber) async {
  return await ProductRepository().getPaymentReceipt(referenceNumber);
});

final productOrderRefProvider = StateProvider<String?>((ref) => null);

final productBankDetailsFutureProvider =
    FutureProvider.autoDispose.family((ref, String productCode) async {
  return await ProductRepository().getProductBankDetails(productCode);
});
