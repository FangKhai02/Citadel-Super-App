package com.citadel.backend.dao;

import com.citadel.backend.entity.AppUser;
import com.citadel.backend.entity.UserDetail;
import com.citadel.backend.vo.Enum.UserType;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface UserDetailDao extends JpaRepository<UserDetail, Long> {
    UserDetail findByIdentityCardNumber(String identityCardNumber);

    List<UserDetail> findAllByIdentityCardNumber(String identityCardNumber);

    @Query("SELECT u FROM UserDetail u " +
            "WHERE u.identityCardNumber = :identityCardNumber " +
            "AND u.appUserId IS NOT NULL " +
            "AND u.appUserId.userType = :userType " +
            "AND u.appUserId.isDeleted = false")
    UserDetail checkExistingUser(@Param("identityCardNumber") String identityCardNumber,
                                 @Param("userType") UserType userType);

    UserDetail findByAppUserId(AppUser appUserId);
}
