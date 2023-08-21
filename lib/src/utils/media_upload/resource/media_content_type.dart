enum MediaContentType {
  png("image/png"),
  jpeg("image/jpeg"),
  jpg("image/jpg"),
  pdf("application/pdf"),
  mp4("video/mp4");

  final String value;

  const MediaContentType(this.value);
}
