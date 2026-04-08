class Agent {
  final String name;
  final String agencyName;
  final String mobileNumber;

  Agent({this.name = '', this.agencyName = '', this.mobileNumber = ''});

  Agent.fromJson(dynamic json)
      : name = json['name'] ?? '',
        agencyName = json['agencyName'] ?? '',
        mobileNumber = json['mobileNumber'] ?? '';

  bool get isEmpty =>
      name.isEmpty && agencyName.isEmpty && mobileNumber.isEmpty;
}
