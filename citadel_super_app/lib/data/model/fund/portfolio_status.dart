enum PortfolioStatus {
  pending,
  failed,
  success,
  cancelled,
  expired,
  invalid,
  unknown,
  open,
  reversed,
  processing,
  active,
  inReview,
  draft,
  completed,
  agreement,
  rejected,
  matured,
  pendingPayment,
  secondSignee,
  withdrawn;

  PortfolioStatus getStatus(String status) {
    switch (status) {
      case 'ACTIVE':
        return PortfolioStatus.active;
      case 'IN_REVIEW':
        return PortfolioStatus.inReview;
      case 'DRAFT':
        return PortfolioStatus.draft;
      case 'COMPLETED':
        return PortfolioStatus.completed;
      case 'AGREEMENT':
        return PortfolioStatus.agreement;
      case 'REJECTED':
        return PortfolioStatus.rejected;
      case 'MATURED':
        return PortfolioStatus.matured;
      case 'WITHDRAWN':
        return PortfolioStatus.withdrawn;
      case 'PENDING':
        return PortfolioStatus.pending;
      case 'FAILED':
        return PortfolioStatus.failed;
      case 'SUCCESS':
        return PortfolioStatus.success;
      case 'CANCELLED':
        return PortfolioStatus.cancelled;
      case 'EXPIRED':
        return PortfolioStatus.expired;
      case 'INVALID':
        return PortfolioStatus.invalid;
      case 'UNKNOWN':
        return PortfolioStatus.unknown;
      case 'OPEN':
        return PortfolioStatus.open;
      case 'REVERSED':
        return PortfolioStatus.reversed;
      case 'PROCESSING':
        return PortfolioStatus.processing;
      case 'PENDING_PAYMENT':
        return PortfolioStatus.pendingPayment;
      case 'SECOND_SIGNEE':
        return PortfolioStatus.secondSignee;
      default:
        return PortfolioStatus.active;
    }
  }
}
