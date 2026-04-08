class Postcode {
  List<StateIds>? stateIds;
  List<Postcodes>? postcodes;

  Postcode({this.stateIds, this.postcodes});

  Postcode.fromJson(dynamic json) {
    if (json["stateIds"] != null) {
      stateIds = [];
      json["stateIds"].forEach((v) {
        stateIds?.add(StateIds.fromJson(v));
      });
    }
    if (json["postcodes"] != null) {
      postcodes = [];
      json["postcodes"].forEach((v) {
        postcodes?.add(Postcodes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (stateIds != null) {
      map["stateIds"] = stateIds?.map((v) => v.toJson()).toList();
    }
    if (postcodes != null) {
      map["postcodes"] = postcodes?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Postcodes {
  String? postcode;
  String? cityName;
  String? stateId;

  Postcodes({this.postcode, this.cityName, this.stateId});

  Postcodes.fromJson(dynamic json) {
    postcode = json["postcode"];
    cityName = json["cityName"];
    stateId = json["stateId"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["postcode"] = postcode;
    map["cityName"] = cityName;
    map["stateId"] = stateId;
    return map;
  }
}

class StateIds {
  String? stateId;
  String? stateName;

  StateIds({this.stateId, this.stateName});

  StateIds.fromJson(dynamic json) {
    stateId = json["stateId"];
    stateName = json["stateName"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["stateId"] = stateId;
    map["stateName"] = stateName;
    return map;
  }
}
