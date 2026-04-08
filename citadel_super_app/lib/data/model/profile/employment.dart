import '../address.dart';

class Employment {
  final String type;
  final String employerName;
  final String industryType;
  final String jobTitle;
  final Address employerAddress;

  bool get isEmpty =>
      type.isEmpty &&
      employerName.isEmpty &&
      industryType.isEmpty &&
      jobTitle.isEmpty &&
      employerAddress.isEmpty;

  Employment({
    this.type = '',
    this.employerName = '',
    this.industryType = '',
    this.jobTitle = '',
    Address? employerAddress,
  }) : employerAddress = employerAddress ?? const Address();

  Employment.fromJson(dynamic json)
      : type = json['employmentType'] ?? '',
        employerName = json['employerName'] ?? '',
        industryType = json['industryType'] ?? '',
        jobTitle = json['jobTitle'] ?? '',
        employerAddress = Address.fromJson(json['employerAddress'] ?? {});
}
