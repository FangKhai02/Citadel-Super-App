

enum EmploymentType {
  retired,
  houseWife,
  employed,
  selfEmployed,
  unemployed,
  other;

  toKeyWord() {
    switch (this) {
      case EmploymentType.retired:
        return 'RETIRED';
      case EmploymentType.houseWife:
        return 'HOUSEWIFE';
      case EmploymentType.employed:
        return 'EMPLOYED';
      case EmploymentType.selfEmployed:
        return 'SELF_EMPLOYED';
      case EmploymentType.unemployed:
        return 'UNEMPLOYED';
      case EmploymentType.other:
        return 'OTHER';
    }
  }
}

class Employment {
  EmploymentType? employmentType;
  String? employerName;
  String? industryType;
  String? jobTitle;
  String? employerAddress;
  String? employerPostcode;
  String? employerCity;
  String? employerState;
  String? employerCountry;

  EmploymentType get getEmploymentType =>
      employmentType ?? EmploymentType.employed;
  String get getEmployerName => employerName ?? '';
  String get getIndustryType => industryType ?? '';
  String get getJobTitle => jobTitle ?? '';
  String get getEmployerAddress => employerAddress ?? '';
  String get getEmployerPostcode => employerPostcode ?? '';
  String get getEmployerCity => employerCity ?? '';
  String get getEmployerState => employerState ?? '';
  String get getEmployerCountry => employerCountry ?? '';

  Employment({
    this.employmentType,
    this.employerName,
    this.industryType,
    this.jobTitle,
    this.employerAddress,
    this.employerPostcode,
    this.employerCity,
    this.employerState,
    this.employerCountry,
  });

  Employment copyWith({
    EmploymentType? employmentType,
    String? employerName,
    String? industryType,
    String? jobTitle,
    String? employerAddress,
    String? employerPostcode,
    String? employerCity,
    String? employerState,
    String? employerCountry,
  }) {
    return Employment(
      employmentType: employmentType ?? this.employmentType,
      employerName: employerName ?? this.employerName,
      industryType: industryType ?? this.industryType,
      jobTitle: jobTitle ?? this.jobTitle,
      employerAddress: employerAddress ?? this.employerAddress,
      employerPostcode: employerPostcode ?? this.employerPostcode,
      employerCity: employerCity ?? this.employerCity,
      employerState: employerState ?? this.employerState,
      employerCountry: employerCountry ?? this.employerCountry,
    );
  }
}
