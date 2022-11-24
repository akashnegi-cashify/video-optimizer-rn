class ImageAssetHelper {
  static const String _basePath = 'assets/icons';

  static String imagePath(String imageName) {
    return '$_basePath/$imageName';
  }
}
