class Banks {
  Banks({
    this.bankList,
  });

  List<Bank>? bankList;

  Banks.fromJson(dynamic json) {
    if (json["bankList"] != null) {
      bankList = [];
      json["bankList"].forEach((v) {
        bankList?.add(Bank.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (bankList != null) {
      map["bankList"] = bankList?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Bank {
  String? bankName;
  String? swiftCode;
  String? bankAddress;
  String? bankPostcode;
  String? bankCity;
  String? bankState;
  String? bankCountry;

  Bank(
      {this.bankName,
      this.swiftCode,
      this.bankAddress,
      this.bankPostcode,
      this.bankCity,
      this.bankState,
      this.bankCountry});

  Bank.fromJson(dynamic json) {
    bankName = json["bank_name"];
    swiftCode = json["swift_code"];
    bankAddress = json["bank_address"];
    bankPostcode = json["bank_postcode"];
    bankCity = json["bank_city"];
    bankState = json["bank_state"];
    bankCountry = json["bank_country"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["bank_name"] = bankName;
    map["swift_code"] = swiftCode;
    map["bank_address"] = bankAddress;
    map["bank_postcode"] = bankPostcode;
    map["bank_city"] = bankCity;
    map["bank_state"] = bankState;
    map["bank_country"] = bankCountry;
    return map;
  }
}
