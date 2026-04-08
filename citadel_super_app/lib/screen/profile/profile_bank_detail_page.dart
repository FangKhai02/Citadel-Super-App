import 'package:citadel_super_app/abstract/bank_detail_base.dart';
import 'package:citadel_super_app/custom_router.dart';
import 'package:citadel_super_app/data/model/bank.dart';
import 'package:citadel_super_app/screen/profile/add_edit_bank_detail_page.dart';
import 'package:flutter/material.dart';

class ProfileBankDetailPage extends BaseBankDetail {
  final CommonBankDetails bank;

  ProfileBankDetailPage({super.key, required this.bank, super.allowEdit})
      : super(
            bankAccount: bank,
            onTap: (context, ref) {
              Navigator.pushNamed(context, CustomRouter.addEditBankDetail,
                  arguments: AddEditBankDetailPage(bankDetails: bank));
            });
}
