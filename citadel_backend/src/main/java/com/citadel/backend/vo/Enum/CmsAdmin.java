package com.citadel.backend.vo.Enum;

public enum CmsAdmin {
    CHECKER, FINANCE, APPROVER;

    public enum AdminType {
        CHECKER, FINANCE, APPROVER
    }

    public enum Status {
        APPROVE_FINANCE, REJECT_FINANCE, PENDING_FINANCE, APPROVE_CHECKER, REJECT_CHECKER, PENDING_CHECKER, APPROVE_APPROVER, REJECT_APPROVER, PENDING_APPROVER
    }


    public enum FinanceStatus {
        APPROVE_FINANCE, REJECT_FINANCE, PENDING_FINANCE
    }

    public enum CheckerStatus {
        APPROVE_CHECKER, REJECT_CHECKER, PENDING_CHECKER
    }

    public enum ApproverStatus {
        APPROVE_APPROVER, REJECT_APPROVER, PENDING_APPROVER,
    }
}
