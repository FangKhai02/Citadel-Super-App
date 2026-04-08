package com.citadel.backend.vo.Enum;

import com.citadel.backend.vo.Interface.EnumWithValue;
import lombok.Getter;

@Getter
public enum Relationship implements EnumWithValue {
    SELF("Self"),
    FAMILY("Family"),
    ASSOCIATE("Associate"),
    CHILD("Child"),
    GUARDIAN("Guardian"),
    PARENTS("Parents"),
    PARTNER("Partner"),
    SPOUSE("Spouse"),
    GRANDPARENT("Grandparent"),
    FRIEND("Friend"),
    FIANCE("Fiance"),
    SIBLING("Sibling"),
    NIECE("Niece"),
    NEPHEW("Nephew"),
    GRAND_DAUGHTER("Grand Daughter"),
    GRAND_SON("Grand Son"),
    GOD_PARENT("God Parent"),
    MOTHER_IN_LAW("Mother In Law"),
    FATHER_IN_LAW("Father In Law"),
    SON_IN_LAW("Son In Law"),
    DAUGHTER_IN_LAW("Daughter In Law"),
    ADMINISTRATOR("Administrator");

    public final String value;
    Relationship(String value) {
        this.value = value;
    }
}
