import 'package:citadel_super_app/data/vo/agent_dividend_payout_vo.dart';
import 'package:intl/intl.dart';

extension AgentDividendPayoutExtension on AgentDividendPayoutVo? {
  String get dateDisplay => this?.dividendPayoutDate == null
      ? ''
      : DateFormat('dd MMM yyyy h:mm a').format(
          DateTime.fromMillisecondsSinceEpoch(this!.dividendPayoutDate!));

  String get productNameDisplay => this?.productName ?? '';
  String get productCodeDisplay => this?.productCode ?? '';
  String get dividendAmountDisplay =>
      this?.dividendAmount == null ? '' : '+ RM${this!.dividendAmount}';
}
