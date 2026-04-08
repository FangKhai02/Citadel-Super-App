class Document {
  final int? id;
  final String fileName;
  final String base64EncodeStr;

  const Document({
    this.id,
    this.fileName = '',
    this.base64EncodeStr = '',
  });

  bool get isEmpty => fileName.isEmpty && base64EncodeStr.isEmpty;

  Document.fromJson(dynamic json)
      : id = json['id'],
        fileName = json['fileName'] ?? '',
        base64EncodeStr = json["base64EncodeStr"] ?? '';
}
