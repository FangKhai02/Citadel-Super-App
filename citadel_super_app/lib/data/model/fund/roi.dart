class Roi {
  String? returnFromPlacement;
  int? tenureYear;

  Roi({
    this.returnFromPlacement,
    this.tenureYear,
  });

  Roi copyWith({
    String? returnFromPlacement,
    int? tenureYear,
  }) {
    return Roi(
      returnFromPlacement: returnFromPlacement ?? this.returnFromPlacement,
      tenureYear: tenureYear ?? this.tenureYear,
    );
  }
}
