import 'package:citadel_super_app/data/state/app_state.dart';
import 'package:collection/collection.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

extension StringExtension on String {
  bool isNetworkImage() {
    return contains('https');
  }

  bool isImageBase64() {
    return length > 200;
  }

  int getEpochTime() {
    List<String> patterns = [
      'yyyy-MM-dd',
      'dd-MM-yyyy',
      'MM/dd/yyyy',
      'dd/MM/yyyy',
      'yyyy/MM/dd',
      'yyyy.MM.dd',
      'dd.MM.yyyy',
      'MMMM dd, yyyy',
      'MMM dd, yyyy',
      'yyyy-MM-dd HH:mm:ss',
      'dd-MM-yyyy HH:mm:ss',
      'yyyy MMMM dd',
      'MM-dd-yyyy',
    ];

    for (var pattern in patterns) {
      try {
        final result =
            DateFormat(pattern).parseStrict(this).millisecondsSinceEpoch;
        return result;
      } catch (e) {
        continue;
      }
    }

    throw FormatException("Invalid date format: $this");
  }

  bool equalsIgnoreCase(String other) {
    return toLowerCase() == other.toLowerCase();
  }

  bool nullOrEmpty() {
    return isEmpty || this == 'null';
  }

  String formatGender() {
    if (equalsIgnoreCase('M') ||
        equalsIgnoreCase('Male') ||
        equalsIgnoreCase('Lelaki')) {
      return 'Male';
    } else if (equalsIgnoreCase('F') ||
        equalsIgnoreCase('Female') ||
        equalsIgnoreCase('Perempuan')) {
      return 'Female';
    } else {
      return '';
    }
  }

  String toCamelCase() {
    if (isEmpty) return this;

    final words = split(RegExp(r'[\s_]+'));

    if (words.isEmpty) return this;
    if (words.length > 1) {
      for (int i = 0; i < words.length; i++) {
        if (words[i].isNotEmpty) {
          words[i] =
              words[i][0].toUpperCase() + words[i].substring(1).toLowerCase();
        }
      }
    } else {
      if (words[0].isNotEmpty) {
        words[0] =
            words[0][0].toUpperCase() + words[0].substring(1).toLowerCase();
      }
    }

    return words.join(' ');
  }

  String get defaultDisplay => isEmpty ? '-' : this;
}

extension StringNullableExtension on String? {
  String get defaultDisplay => this == null ? '-' : this!.defaultDisplay;
}

String getValueForKey(String searchKey, WidgetRef ref) {
  final allItems = ref.read(appProvider).allConstants ?? [];

  final match = allItems.firstWhereOrNull(
    (item) => item.key == searchKey,
  );

  return match?.value ?? '';
}

String getOptionString(String? key) {
  // REFUND, ROLLOVER, REALLOCATION, REDEMPTION, FULL_REDEMPTION, EARLY_REDEMPTION, PARTIAL_REDEMPTION
  if (key == null) return '-';

  switch (key) {
    case 'REFUND':
      return 'Refund';
    case 'ROLLOVER':
      return 'Rollover';
    case 'REALLOCATION':
      return 'Reallocation';
    case 'REDEMPTION':
      return 'Redemption';
    case 'FULL_REDEMPTION':
      return 'Full Redemption';
    case 'EARLY_REDEMPTION':
      return 'Early Redemption';
    case 'PARTIAL_REDEMPTION':
      return 'Partial Redemption';
    default:
      return '-';
  }
}
