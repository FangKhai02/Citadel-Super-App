class WealthSource {
  final double? annualIncomeDeclared;
  final String sourceOfIncome;

  bool get isEmpty => sourceOfIncome.isEmpty && annualIncomeDeclared == null;

  String get annualIncomeDeclaredDisplay => annualIncomeDeclared != null
      ? "RM${annualIncomeDeclared!.toStringAsFixed(2)}"
      : '';

  WealthSource({this.annualIncomeDeclared, this.sourceOfIncome = ''});

  WealthSource.fromJson(dynamic json)
      : annualIncomeDeclared = json["annualIncomeDeclared"] as double?,
        sourceOfIncome = json["sourceOfIncome"] ?? '';
}
