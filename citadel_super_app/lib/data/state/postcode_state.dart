import 'dart:convert';

import 'package:citadel_super_app/data/model/postcode.dart';
import 'package:citadel_super_app/generated/assets.gen.dart';
import 'package:collection/collection.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final postcodeProvider =
    StateNotifierProvider<PostcodeState, Postcode>((ref) => PostcodeState());

class PostcodeState extends StateNotifier<Postcode> {
  PostcodeState() : super(Postcode(postcodes: [], stateIds: []));

  Future<void> initFromJson(BuildContext context) async {
    final postcodeJson = await rootBundle.loadString(Assets.json.postcode);
    state = Postcode.fromJson(jsonDecode(postcodeJson));
  }

  Map<String, String> autoPopulateFromPostCode({
    required String postcode,
  }) {
    Map<String, String> resultMap = {
      'city': '',
      'state': '',
    };

    Postcodes? matchingPostcode = state.postcodes
        ?.firstWhereOrNull((element) => element.postcode == postcode);
    if (matchingPostcode != null) {
      StateIds? matchingState = state.stateIds?.firstWhereOrNull(
          (element) => element.stateId == matchingPostcode.stateId);
      resultMap['city'] = matchingPostcode.cityName ?? '';
      resultMap['state'] = matchingState?.stateName ?? '';
    }

    return resultMap;
  }
}
