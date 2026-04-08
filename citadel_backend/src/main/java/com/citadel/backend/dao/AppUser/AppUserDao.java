package com.citadel.backend.dao.AppUser;

import com.citadel.backend.entity.AppUser;
import com.citadel.backend.vo.Enum.UserType;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface AppUserDao extends JpaRepository<AppUser, Long> {
    AppUser findByEmailAddressAndPassword(String email, String password);

    AppUser findByEmailAddressAndIsDeletedIsFalse(String email);

    AppUser findByEmailAddressAndIsDeletedIsFalseAndUserType(String email, UserType userType);
}
