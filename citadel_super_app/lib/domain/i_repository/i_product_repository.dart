import 'package:citadel_super_app/data/request/product_early_redemption_request_vo.dart';
import 'package:citadel_super_app/data/request/product_order_payment_upload_request_vo.dart';
import 'package:citadel_super_app/data/request/product_purchase_request_vo.dart';
import 'package:citadel_super_app/data/request/reallocate_request_vo.dart';
import 'package:citadel_super_app/data/request/rollover_request_vo.dart';
import 'package:citadel_super_app/data/response/product_bank_details_response_vo.dart';
import 'package:citadel_super_app/data/response/product_details_response_vo.dart';
import 'package:citadel_super_app/data/response/product_early_redemption_response_vo.dart';

abstract class IProductRepository {
  Future<void> getProductList();

  Future<ProductDetailsResponseVo> getProductDetailById(int productId);

  Future<void> purchaseProduct(
      ProductPurchaseRequestVo req, String referenceNumber);

  Future<void> purchaseProductValidation(ProductPurchaseRequestVo req);

  Future<void> purchaseProductValidation2(ProductPurchaseRequestVo req);

  Future<void> uploadPaymentReceipt(ProductOrderPaymentUploadRequestVo req,
      String referenceNumber, bool isDraft);

  Future<void> getPaymentReceipt(String referenceNumber);

  Future<void> productDraftDelete(String referenceNumber);

  Future<ProductEarlyRedemptionResponseVo> productEarlyRedemption(
      bool isRedemption, ProductEarlyRedemptionRequestVo req);

  Future<void> productRollover(String referenceNumber, RolloverRequestVo req);

  Future<void> productReallocation(
      String referenceNumber, ReallocateRequestVo req);

  Future<void> productFullyRedemption(String referenceNumber);

  Future<List<String>> getReallocatableProductCodes(String referenceNumber);

  Future<List<double>> getProductIncrementalValue(String referenceNumber);

  Future<ProductBankDetailsResponseVo> getProductBankDetails(
      String productCode);
}
