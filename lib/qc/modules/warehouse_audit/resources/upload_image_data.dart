class UploadImageData {
  final String key;
  final String heading;
  String? imageUrl;

  UploadImageData(this.key, this.heading);

  static List<UploadImageData> encodeInList(Map<String, String> imageMap) {
    List<UploadImageData> uploadImageList = [];
    imageMap.forEach((key, value) {
      uploadImageList.add(UploadImageData(key, value));
    });
    return uploadImageList;
  }

  static Map<String, String> decodeInMap(List<UploadImageData> list) {
    Map<String, String> map = {};
    for (var item in list) {
      map[item.key] = item.imageUrl!;
    }
    return map;
  }
}
