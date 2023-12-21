import 'dart:io';

import 'package:disk_space/disk_space.dart';
import 'package:path_provider/path_provider.dart';

class DiskUtil {
  static Future<double?> getDeviceStorageInfo({bool isGb = false}) async {
    double? diskSpace = 0;

    diskSpace = await DiskSpace.getFreeDiskSpace;
    if (diskSpace != null && isGb) diskSpace = diskSpace / (1024);

    return diskSpace;
  }

  static Future<double?> getTotalDeviceStorageInfo() async {
    double? diskSpace = 0;

    diskSpace = await DiskSpace.getTotalDiskSpace;

    return diskSpace;
  }

  static Future<Map<Directory, double?>?> getDevicesDirectoriesStorageInfo() async {
    List<Directory> directories = [];
    Map<Directory, double?> directorySpace = {};

    if (Platform.isIOS) {
      directories = [await getApplicationDocumentsDirectory()];
    } else if (Platform.isAndroid) {
      directories = await getExternalStorageDirectories(type: StorageDirectory.movies).then(
        (list) async => list ?? [await getApplicationDocumentsDirectory()],
      );
    }

    for (var directory in directories) {
      double? space = await DiskSpace.getFreeDiskSpaceForPath(directory.path);
      directorySpace.addEntries([MapEntry(directory, space ?? 0.0)]);
    }
    return directorySpace;
  }
}
