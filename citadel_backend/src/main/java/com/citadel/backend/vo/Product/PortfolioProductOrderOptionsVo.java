package com.citadel.backend.vo.Product;

import com.citadel.backend.utils.DateToMillisecondsSerializer;
import com.citadel.backend.vo.Enum.ProductOrderOptions;
import com.citadel.backend.vo.Enum.Status;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.Comparator;
import java.util.Date;
import java.util.List;
import java.util.Objects;

@Getter
@Setter
@NoArgsConstructor
public class PortfolioProductOrderOptionsVo {
    private String newProductOrderReferenceNumber;
    private ProductOrderOptions optionType;
    private Status optionStatus;
    private Double amount;
    private String statusString;
    @JsonSerialize(using = DateToMillisecondsSerializer.class)
    private Date createdAt;
    private Status clientSignatureStatus;
    private Status witnessSignatureStatus;

    public static PortfolioProductOrderOptionsVo getMostRecentOption(List<? extends PortfolioProductOrderOptionsInterface> optionsList) {
        if (optionsList == null || optionsList.isEmpty()) {
            return null;
        }

        PortfolioProductOrderOptionsInterface mostRecent = optionsList.stream()
                .filter(Objects::nonNull)
                .max(Comparator.comparing(PortfolioProductOrderOptionsInterface::getCreatedAt))
                .orElse(null);

        if (mostRecent == null) {
            return null;
        }

        PortfolioProductOrderOptionsVo vo = new PortfolioProductOrderOptionsVo();
        vo.setNewProductOrderReferenceNumber(mostRecent.getReferenceNumber());
        vo.setOptionType(mostRecent.getOptionType());
        vo.setOptionStatus(mostRecent.getStatus());
        vo.setAmount(mostRecent.getAmount());
        vo.setStatusString(mostRecent.getStatusString());
        vo.setCreatedAt(mostRecent.getCreatedAt());
        vo.setClientSignatureStatus(mostRecent.getClientSignatureStatus());
        vo.setWitnessSignatureStatus(mostRecent.getWitnessSignatureStatus());
        return vo;
    }
}
