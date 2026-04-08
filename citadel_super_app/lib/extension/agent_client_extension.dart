import 'package:citadel_super_app/data/vo/agent_client_vo.dart';
import 'package:intl/intl.dart';

extension AgentClientExtension on AgentClientVo? {
  String get nameDisplay => this?.name ?? '';
  String get clientIdDisplay => this?.clientId ?? '';
  String get joinedDateDisplay => this?.joinedDate == null
      ? ''
      : DateFormat('dd MMM yyyy')
          .format(DateTime.fromMillisecondsSinceEpoch(this!.joinedDate!));
}
