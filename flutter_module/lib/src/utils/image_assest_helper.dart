class ImageAssetHelper {
  static const String _basePath = 'assets/icons';
  static const String _imageBasePath = "assets/images";

  static String iconPath(String imageName) {
    return '$_basePath/$imageName';
  }

  static String imagePath(String imageName) {
    return '$_imageBasePath/$imageName';
  }
}
