enum MediaContentType {
  png("image/png"),
  jpeg("image/jpeg"),
  jpg("image/jpg"),
  pdf("application/pdf"),
  webp("image/webp"),
  mp4("video/mp4"),
  txt("text/plain"),;

  final String value;

  const MediaContentType(this.value);

  static MediaContentType fromValue(String value) {
    return MediaContentType.values.firstWhere((e) => e.value.split("/").last == value.toLowerCase());
  }
}
