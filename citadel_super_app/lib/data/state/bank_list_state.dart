import 'dart:convert';

import 'package:citadel_super_app/data/model/banks.dart';
import 'package:citadel_super_app/generated/assets.gen.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final bankListProvider =
    StateNotifierProvider<BankListState, Banks>((ref) => BankListState());

class BankListState extends StateNotifier<Banks> {
  BankListState() : super(Banks(bankList: []));

  Future<void> initFromJson(BuildContext context) async {
    final bankJson = await rootBundle.loadString(Assets.json.bank);
    state = Banks.fromJson(jsonDecode(bankJson));
  }

  Bank? getObjectByBankName({String? bankName}) {
    if (bankName == null) return null;

    return state.bankList?.firstWhereOrNull((element) =>
        element.bankName?.toLowerCase().trim() ==
        bankName.toLowerCase().trim());
  }
}
