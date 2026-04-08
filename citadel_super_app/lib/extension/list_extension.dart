import 'package:flutter/widgets.dart';

extension ListExtension<T> on List<T> {
  Widget whenList(
      {required Widget Function(List<T>) hasData, Widget Function()? noData}) {
    if (isEmpty) {
      return noData?.call() ?? const SizedBox();
    }

    return hasData(this);
  }
}
