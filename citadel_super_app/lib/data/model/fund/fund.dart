class Fund {
  String? fundName;
  String? description;
  String? fundImage;
  String? pdfUrl;
  bool? availability;

  Fund({
    this.fundName,
    this.description,
    this.fundImage,
    this.pdfUrl,
    this.availability,
  });

  Fund copyWith({
    String? fundName,
    String? description,
    String? fundImage,
    String? pdfUrl,
    bool? availability,
  }) {
    return Fund(
      fundName: fundName ?? this.fundName,
      description: description ?? this.description,
      fundImage: fundImage ?? this.fundImage,
      pdfUrl: pdfUrl ?? this.pdfUrl,
      availability: availability ?? this.availability,
    );
  }
}
