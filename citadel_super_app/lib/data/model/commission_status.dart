enum CommissionStatus {
  newCommission,
  success;

  CommissionStatus getStatus(String status) {
    switch (status) {
      case 'NEW':
        return CommissionStatus.newCommission;
      case 'SUCCESS':
        return CommissionStatus.success;
      default:
        return CommissionStatus.newCommission;
    }
  }
}
