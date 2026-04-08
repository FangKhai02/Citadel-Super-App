import 'package:citadel_super_app/data/model/fund/payment.dart';
import 'package:citadel_super_app/data/request/product_purchase_request_vo.dart';
import 'package:citadel_super_app/data/vo/product_order_beneficiary_request_vo.dart';
import 'package:citadel_super_app/data/vo/product_purchase_product_details_vo.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

//client purchase fund state
final purchaseFundProvider =
    StateNotifierProvider<PurchaseFundState, ProductPurchaseRequestVo>((ref) {
  return PurchaseFundState();
});

class PurchaseFundState extends StateNotifier<ProductPurchaseRequestVo> {
  PurchaseFundState() : super(ProductPurchaseRequestVo());

  String bankName = '';

  void setProductId(int productId) {
    state = state.copyWith(
        productDetails:
            (state.productDetails ?? ProductPurchaseProductDetailsVo())
                .copyWith(productId: productId));
  }

  void setInvestAmount(double investAmount) {
    state = state.copyWith(
        productDetails:
            (state.productDetails ?? ProductPurchaseProductDetailsVo())
                .copyWith(amount: investAmount));
  }

  void setDividend(double dividend) {
    state = state.copyWith(
        productDetails:
            (state.productDetails ?? ProductPurchaseProductDetailsVo())
                .copyWith(dividend: dividend));
  }

  void setInvestmentTenureMonths(int tenureMonths) {
    state = state.copyWith(
        productDetails:
            (state.productDetails ?? ProductPurchaseProductDetailsVo())
                .copyWith(investmentTenureMonth: tenureMonths));
  }

  void setPaymentMethod(PaymentMethod method) {
    state = state.copyWith(paymentMethod: method.paymentMethodKey);
  }

  void setLivingTrustEnabled(bool enabled) {
    state = state.copyWith(livingTrustOptionEnabled: enabled);
  }

  ProductPurchaseRequestVo setBankChoosen(int bankId, String bankName) {
    this.bankName = bankName;
    state = state.copyWith(clientBankId: bankId);
    return state;
  }

  void setBeneficiaries(List<ProductOrderBeneficiaryRequestVo> beneficiaries) {
    state = state.copyWith(beneficiaries: beneficiaries);
  }

  void setSubBeneficiaries(
      List<ProductOrderBeneficiaryRequestVo> subBeneficiaries) {
    List<ProductOrderBeneficiaryRequestVo> updatedBeneficiaries =
        List.from(state.beneficiaries!);
    updatedBeneficiaries[0] =
        updatedBeneficiaries[0].copyWith(subBeneficiaries: subBeneficiaries);

    state = state.copyWith(beneficiaries: updatedBeneficiaries);
  }

  void setClientId(String? clientId) {
    if (clientId != null) state = state.copyWith(clientId: clientId);
  }
}

//corporate purchase fund state
final corporatePurchaseFundProvider =
    StateNotifierProvider<CorporatePurchaseFundState, ProductPurchaseRequestVo>(
        (ref) {
  return CorporatePurchaseFundState();
});

class CorporatePurchaseFundState
    extends StateNotifier<ProductPurchaseRequestVo> {
  CorporatePurchaseFundState() : super(ProductPurchaseRequestVo());

  String bankName = '';

  void setProductId(int productId) {
    state = state.copyWith(
        productDetails:
            (state.productDetails ?? ProductPurchaseProductDetailsVo())
                .copyWith(productId: productId));
  }

  void setInvestAmount(double investAmount) {
    state = state.copyWith(
        productDetails:
            (state.productDetails ?? ProductPurchaseProductDetailsVo())
                .copyWith(amount: investAmount));
  }

  void setDividend(double dividend) {
    state = state.copyWith(
        productDetails:
            (state.productDetails ?? ProductPurchaseProductDetailsVo())
                .copyWith(dividend: dividend));
  }

  void setInvestmentTenureMonths(int tenureMonths) {
    state = state.copyWith(
        productDetails:
            (state.productDetails ?? ProductPurchaseProductDetailsVo())
                .copyWith(investmentTenureMonth: tenureMonths));
  }

  void setPaymentMethod(PaymentMethod method) {
    state = state.copyWith(paymentMethod: method.paymentMethodKey);
  }

  void setLivingTrustEnabled(bool enabled) {
    state = state.copyWith(livingTrustOptionEnabled: enabled);
  }

  ProductPurchaseRequestVo setBankChoosen(int bankId, String bankName) {
    this.bankName = bankName;
    state = state.copyWith(clientBankId: bankId);
    return state;
  }

  void setBeneficiaries(List<ProductOrderBeneficiaryRequestVo> beneficiaries) {
    state = state.copyWith(beneficiaries: beneficiaries);
  }

  void setSubBeneficiaries(
      List<ProductOrderBeneficiaryRequestVo> subBeneficiaries) {
    List<ProductOrderBeneficiaryRequestVo> updatedBeneficiaries =
        List.from(state.beneficiaries!);
    updatedBeneficiaries[0] =
        updatedBeneficiaries[0].copyWith(subBeneficiaries: subBeneficiaries);

    state = state.copyWith(beneficiaries: updatedBeneficiaries);
  }

  void setCorporateId(String corporateId) {
    state = state.copyWith(corporateClientId: corporateId);
  }
}
