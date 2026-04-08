package com.citadel.backend.entity.Products;

import com.citadel.backend.entity.AppUser;

public interface RolloverReallocationInterface {
    ProductOrder getProductOrder();
    Double getAmount();
    Product getReallocateProduct();
    AppUser getCreatedBy();
}
