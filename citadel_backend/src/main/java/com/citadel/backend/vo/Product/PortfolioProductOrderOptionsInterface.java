package com.citadel.backend.vo.Product;

import com.citadel.backend.vo.Enum.ProductOrderOptions;
import com.citadel.backend.vo.Enum.Status;

import java.util.Date;

public interface PortfolioProductOrderOptionsInterface {
    String getReferenceNumber();
    ProductOrderOptions getOptionType();
    Status getStatus();
    Double getAmount();
    String getStatusString();
    Date getCreatedAt();
    Status getClientSignatureStatus();
    Status getWitnessSignatureStatus();
}
