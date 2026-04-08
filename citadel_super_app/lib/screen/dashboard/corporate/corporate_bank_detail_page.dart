import 'package:citadel_super_app/abstract/bank_detail_base.dart';
import 'package:citadel_super_app/custom_router.dart';
import 'package:citadel_super_app/data/model/bank.dart';
import 'package:citadel_super_app/screen/dashboard/corporate/corporate_add_edit_bank_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CorporateBankDetailPage extends BaseBankDetail {
  final CommonBankDetails bank;

  CorporateBankDetailPage({super.key, required this.bank})
      : super(
            bankAccount: bank,
            onTap: (context, ref) {
              Navigator.pushReplacementNamed(
                  context, CustomRouter.corporateAddEditBank,
                  arguments: CorporateAddEditBankDetailPage(bankDetails: bank));
            });
}
