class VideoUploadException implements Exception {
  final String message;

  VideoUploadException(this.message);

  @override
  String toString() {
    return message;
  }
}
