import 'package:citadel_super_app/data/model/address.dart';
import 'package:citadel_super_app/data/response/existing_client_response_vo.dart';

extension ExistingClientExtension on ExistingClientResponseVo {
  Address get addressModel => Address(
        street: personalDetails?.address ?? '',
        postCode: personalDetails?.postcode ?? '',
        city: personalDetails?.city ?? '',
        state: personalDetails?.state ?? '',
        country: personalDetails?.country ?? '',
      );

  String? get proofDocFile => personalDetails?.proofOfAddressFile;

  String? get pepDocFile =>
      pepDeclaration?.pepDeclarationOptions?.supportingDocument;

  String getPepRelationship() {
    final relationship =
        pepDeclaration?.pepDeclarationOptions?.relationship ?? '';

    switch (relationship) {
      case 'SELF':
        return 'Self';
      case 'FAMILY':
        return 'Immediate Family Member';
      case 'ASSOCIATE':
        return 'Close Associate';
      default:
        return '';
    }
  }
}
