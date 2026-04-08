import 'package:citadel_super_app/screen/agent_action/component/consent_request_widget.dart';

import '../data/vo/agent_secure_tag_vo.dart';

extension AgentSecureTagVoExtension on AgentSecureTagVo? {
  ConsentStatus? get consentStatus {
    switch (this?.status ?? '') {
      case 'PENDING_APPROVAL':
        return ConsentStatus.pending;
      case 'APPROVED':
        return ConsentStatus.approved;
      case 'REJECTED':
        return ConsentStatus.rejected;
      case 'EXPIRED':
        return ConsentStatus.expired;
    }

    return null;
  }
}
