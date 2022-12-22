import 'dart:io';
import 'package:core/core.dart';
import 'package:s3_file_uploader/s3_file_uploader.dart';
import 'package:s3_file_uploader_interface/s3_file_uploader_interface.dart';
import 'amplify_configuration.dart';

class Amplifier {
  static const String PREFIX = '/public/';

  init(String bucketName, String poolId) async {
    S3FileUploaderPlatform.instance = S3FileUploader();
    bool isConfigured = await S3FileUploaderPlatform.instance.configure(amplifyconfig(bucketName, poolId));
    Logger.log(isConfigured == true ? 'S3FileUploader configured successfully!' : 'S3FileUploader failed to configure');
  }

  uploadFile(String filePath, File file, Function(String) onFileUploaded, Function(String) onFailed,
      {Function(int currentBytes, int totalBytes)? onProgress}) {
    Logger.log('Amplifier.uploadFile', filePath);
    S3FileUploaderPlatform.instance.uploadFile(filePath, file, onProgress: (int currentBytes, int totalBytes) {
      if (onProgress != null) {
        onProgress(currentBytes, totalBytes);
      }
    }).then((value) {
      Logger.log('url----', value);

      onFileUploaded('$PREFIX$value');
    }, onError: (e) {
      if (e is String) {
        onFailed(e);
      }
    });
  }

  Future<String> getFileUrl(String key, {bool? fullPath}) async {
    String url = await S3FileUploaderPlatform.instance.getUrl(key);
    if (fullPath == true) {
      return url;
    }

    if (url.contains('?')) {
      url = url.split("?").first;
    }
    return url;
  }

  Future<File?> downloadFile(String key, String filePath) async {
    File? file = await S3FileUploaderPlatform.instance.downloadFile(key, filePath);
    return file;
  }

  static getFileName() {
    String date = DateTime.now().toString();
    return date.replaceAll(RegExp(r' '), '_');
  }

  static String removePrefix(String imagePath) {
    if (imagePath.startsWith(PREFIX)) {
      return imagePath.replaceFirst(RegExp(PREFIX), '');
    }
    return imagePath;
  }

  static String fileNameFromPath(String? path) {
    if (path == null) {
      return getFileName();
    }

    if (path.contains('/')) {
      return path.split('/').last;
    }
    return path;
  }
}
