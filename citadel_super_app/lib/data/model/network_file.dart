class NetworkFile {
  final int? id;
  final String fileName;
  final String url;

  const NetworkFile({
    this.id,
    this.fileName = 'Network File',
    this.url = '',
  });

  bool get isEmpty => url.isEmpty;
}
