import 'dart:convert';
import 'dart:typed_data';

import 'package:citadel_super_app/data/vo/niu_apply_signee_vo.dart';

class NiuApplySignee implements NiuApplySigneeVo {
  @override
  String? fullName;

  @override
  String? nric;

  @override
  String? signature;

  Future<Uint8List?>? signatureBytes;

  @override
  int? signedDate;

  NiuApplySignee(
      {this.fullName, this.nric, this.signatureBytes, this.signedDate});

  Future<NiuApplySigneeVo?> get vo async {
    final result = await signatureBytes;
    if (result == null) {
      return null;
    }

    return NiuApplySigneeVo(
        fullName: fullName,
        nric: nric,
        signature: base64Encode(result),
        signedDate: signedDate);
  }

  @override
  $NiuApplySigneeVoCopyWith<NiuApplySigneeVo> get copyWith =>
      throw UnimplementedError();

  @override
  Map<String, dynamic> toJson() {
    throw UnimplementedError();
  }
}
