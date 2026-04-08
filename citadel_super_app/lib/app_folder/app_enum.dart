enum SecureTagAction {
  approve, reject;

  String get toServer {
    switch(this) {
      case SecureTagAction.approve:
        return "APPROVE";
      case SecureTagAction.reject:
        return "REJECT";
    }
  }
}