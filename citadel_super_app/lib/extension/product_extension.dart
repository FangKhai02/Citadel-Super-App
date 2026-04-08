import 'package:citadel_super_app/data/vo/product_vo.dart';

extension ProductExtension on ProductVo? {
  String get nameDisplay => this?.name ?? '';

  String get productDescriptionDisplay => this?.productDescription ?? '';

  String get productCatalogueUrlDisplay => this?.productCatalogueUrl ?? '';

  String get imageOfProductUrlDisplay => this?.imageOfProductUrl ?? '';

  // int get priorityDisplay => this?.priority ?? 0;

  bool get isSoldOutDisplay => this?.isSoldOut ?? false;
}
