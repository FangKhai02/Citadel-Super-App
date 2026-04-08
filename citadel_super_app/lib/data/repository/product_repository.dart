import 'package:citadel_super_app/app_folder/app_url.dart';
import 'package:citadel_super_app/data/request/product_early_redemption_request_vo.dart';
import 'package:citadel_super_app/data/request/product_order_payment_upload_request_vo.dart';
import 'package:citadel_super_app/data/request/product_purchase_request_vo.dart';
import 'package:citadel_super_app/data/request/reallocate_request_vo.dart';
import 'package:citadel_super_app/data/request/rollover_request_vo.dart';
import 'package:citadel_super_app/data/response/incremental_amount_list_response_vo.dart';
import 'package:citadel_super_app/data/response/product_bank_details_response_vo.dart';
import 'package:citadel_super_app/data/response/product_details_response_vo.dart';
import 'package:citadel_super_app/data/response/product_early_redemption_response_vo.dart';
import 'package:citadel_super_app/data/response/product_list_response_vo.dart';
import 'package:citadel_super_app/data/response/product_order_summary_response_vo.dart';
import 'package:citadel_super_app/data/response/reallocatable_product_codes_response_vo.dart';
import 'package:citadel_super_app/data/vo/product_vo.dart';
import 'package:citadel_super_app/domain/i_repository/i_product_repository.dart';
import 'package:citadel_super_app/service/base_web_service.dart';

class ProductRepository extends BaseWebService implements IProductRepository {
  @override
  Future<List<ProductVo>> getProductList() async {
    final json = await get(url: AppUrl.getProductList);
    return ProductListResponseVo.fromJson(json).productList ?? [];
  }

  @override
  Future<ProductDetailsResponseVo> getProductDetailById(int productId) async {
    final json = await get(url: AppUrl.getProductDetailById(productId));
    return ProductDetailsResponseVo.fromJson(json);
  }

  @override
  Future<ProductOrderSummaryResponseVo> purchaseProduct(
      ProductPurchaseRequestVo req, String referenceNumber) async {
    final json = await post(
        url: AppUrl.purchaseFund(referenceNumber), parameter: req.toJson());
    return ProductOrderSummaryResponseVo.fromJson(json);
  }

  @override
  Future<ProductOrderSummaryResponseVo> purchaseProductValidation(
      ProductPurchaseRequestVo req) async {
    final json =
        await post(url: AppUrl.purchaseFundValidation, parameter: req.toJson());
    return ProductOrderSummaryResponseVo.fromJson(json);
  }

  @override
  Future<ProductOrderSummaryResponseVo> purchaseProductValidation2(
      ProductPurchaseRequestVo req) async {
    final json = await post(
        url: AppUrl.purchaseFundValidation2, parameter: req.toJson());
    return ProductOrderSummaryResponseVo.fromJson(json);
  }

  @override
  Future<void> uploadPaymentReceipt(ProductOrderPaymentUploadRequestVo req,
      String referenceNumber, bool isDraft) async {
    await post(
        url: AppUrl.uploadPaymentReceipt(referenceNumber, isDraft),
        parameter: req.toJson());
  }

  @override
  Future<ProductOrderSummaryResponseVo> getPaymentReceipt(
      String referenceNumber) async {
    final json = await get(url: AppUrl.getPaymentReceipts(referenceNumber));
    return ProductOrderSummaryResponseVo.fromJson(json);
  }

  @override
  Future<void> productDraftDelete(String referenceNumber) async {
    await post(url: AppUrl.productDraftDelete(referenceNumber));
  }

  @override
  Future<ProductEarlyRedemptionResponseVo> productEarlyRedemption(
      bool isRedemption, ProductEarlyRedemptionRequestVo req) async {
    final json = await post(
        url: AppUrl.productEarlyRedemption(isRedemption),
        parameter: req.toJson());
    return ProductEarlyRedemptionResponseVo.fromJson(json);
  }

  @override
  Future<void> productRollover(
      String referenceNumber, RolloverRequestVo req) async {
    await post(
        url: AppUrl.productRollOver(referenceNumber), parameter: req.toJson());
  }

  @override
  Future<void> productReallocation(
      String referenceNumber, ReallocateRequestVo req) async {
    await post(
        url: AppUrl.productReallocate(referenceNumber),
        parameter: req.toJson());
  }

  @override
  Future<void> productFullyRedemption(String referenceNumber) async {
    await post(url: AppUrl.productFullRedemption(referenceNumber));
  }

  @override
  Future<List<String>> getReallocatableProductCodes(
      String referenceNumber) async {
    final json =
        await get(url: AppUrl.getReallocatableProductCodes(referenceNumber));
    return ReallocatableProductCodesResponseVo.fromJson(json).productCodes ??
        [];
  }

  @override
  Future<List<double>> getProductIncrementalValue(
      String referenceNumber) async {
    final json =
        await get(url: AppUrl.getProductIncrementalList(referenceNumber));
    return IncrementalAmountListResponseVo.fromJson(json).amountList ?? [];
  }

  @override
  Future<ProductBankDetailsResponseVo> getProductBankDetails(
      String productCode) async {
    final json = await get(url: AppUrl.getProductBankDetails(productCode));
    return ProductBankDetailsResponseVo.fromJson(json);
  }
}
