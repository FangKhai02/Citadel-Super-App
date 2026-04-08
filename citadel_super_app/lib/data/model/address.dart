class Address {
  final String street;
  final String postCode;
  final String city;
  final String state;
  final String country;
  final Address? correspondAddress;
  final bool isSameCorrespondingAddress;

  const Address(
      {this.street = '',
      this.postCode = '',
      this.city = '',
      this.state = '',
      this.country = '',
      this.correspondAddress,
      this.isSameCorrespondingAddress = false});

  String get fullAddress =>
      isEmpty ? "" : "$street, $postCode, $city, $state, $country";

  bool get isEmpty =>
      street.isEmpty &&
      postCode.isEmpty &&
      city.isEmpty &&
      state.isEmpty &&
      country.isEmpty;

  Address.fromJson(dynamic json)
      : street = json['address'] ?? '',
        postCode = json["postCode"] ?? '',
        city = json["city"] ?? '',
        state = json["state"] ?? '',
        correspondAddress = null,
        isSameCorrespondingAddress = false,
        country = json["country"] ?? '';
}
