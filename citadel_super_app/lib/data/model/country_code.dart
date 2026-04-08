class CountryCode {
  CountryCode({
    this.countryCodes,
  });

  List<CountryCodes>? countryCodes;

  CountryCode.fromJson(dynamic json) {
    if (json["countryCodes"] != null) {
      countryCodes = [];
      json["countryCodes"].forEach((v) {
        countryCodes?.add(CountryCodes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (countryCodes != null) {
      map["countryCodes"] = countryCodes?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class CountryCodes {
  String? countryCode;
  String? countryName;
  String? diallingCode;

  CountryCodes({this.countryCode, this.countryName, this.diallingCode});

  CountryCodes.fromJson(dynamic json) {
    countryCode = json["country_code"];
    countryName = json["country_name"];
    diallingCode = json["dialling_code"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["country_code"] = countryCode;
    map["country_name"] = countryName;
    map["dialling_code"] = diallingCode;
    return map;
  }
}
