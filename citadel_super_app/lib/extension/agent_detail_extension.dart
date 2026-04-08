import 'package:citadel_super_app/data/vo/agent_vo.dart';
import 'package:citadel_super_app/extension/int_extension.dart';

extension AgentDetailExtension on AgentVo? {
  String get agentNameDisplay => this?.agentName ?? '';

  String get agentIdDisplay => this?.agentId ?? '';

  String get agentReferralCodeDisplay => this?.referralCode ?? '';

  String get agentRoleDisplay => getFullAgentRoleName();

  String get agencyNameDisplay => this?.agencyName ?? '';

  String get agentTypeDisplay => this?.agentType ?? '';

  String get agencyIdDisplay => this?.agencyId ?? '';

  String get recruitmentManagerIdDisplay => this?.recruitManagerId ?? '';

  String get recruitmentManagerNameDisplay => this?.recruitManagerName ?? '';

  String get joinedDateDisplay =>
      (this?.joinedDate ?? 0).toDateFormat('dd MMM yyyy');

  bool get isNew =>
      (agentIdDisplay.isEmpty &&
          agentRoleDisplay.isEmpty &&
          agencyNameDisplay.isEmpty &&
          recruitmentManagerIdDisplay.isEmpty) ||
      this == null;

  String getFullAgentRoleName() {
    switch (this?.agentRole ?? '') {
      case 'SVP':
        return 'Senior Vice President';
      case 'VP':
        return 'Vice President';
      case 'AVP':
        return 'Assistant Vice President';
      case 'SM':
        return 'Senior Manager';
      case 'P2P':
        return 'Peer to Peer';
      case 'MGR':
        return 'Manager';
      default:
        return '-';
    }
  }
}
