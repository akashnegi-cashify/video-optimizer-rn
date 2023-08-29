import 'dart:async';
import 'dart:io';

import 'package:core/core.dart';
import 'package:ffmpeg_kit_flutter_video/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter_video/ffmpeg_kit_config.dart';
import 'package:ffmpeg_kit_flutter_video/return_code.dart';
import 'package:ffmpeg_kit_flutter_video/session.dart';
import 'package:flutter_trc/src/common/utils/video_util.dart';
import 'package:path_provider/path_provider.dart';

extension FileUtil on File {
  Future<File> addTimeStamp() async {
    Logger.debug('mydebug-----addTimeStamp', [path]);
    if (path.split(".").last != "mp4") {
      return Future.error("Only support mp4 format");
    }

    File fontFile = await VideoUtil.assetToFile(VideoUtil.FONT_ASSET_1);
    Logger.debug('mydebug-----addTimeStamp font file path', [fontFile.path]);

    var completer = Completer<File>();
    // final flutterFFmpeg = FlutterFFmpeg();

    // await FFmpegKitConfig.init();
    final outputPath = "${(await getTemporaryDirectory()).path}/${DateTime.now().millisecondsSinceEpoch}.mp4";
    Logger.debug('mydebug-----addTimeStamp', [path, outputPath]);

    var tempTime = DateTime.now();
    tempTime = tempTime.subtract(Duration(hours: 2));

    String command =
        "-i $path -vf drawtext=text='%{localtime}':x=10:y=10:fontsize=24:fontcolor=white:fontfile='${fontFile.path}' -c:a copy $outputPath";
    // String command = '-i $path -vf "drawtext=text=\'Hello World\':fontsize=50:fontcolor=white:x=100:y=100" $outputPath';
    // String command = "-i $path -vf \"drawtext=text='My text starting at 640x360':x=640:y=360:fontsize=24:fontcolor=white\" -c:a copy output.mp4";
    // String command =
    //     "-i $path -vf drawtext=text='%{localtime}':x=20:y=20:fontsize=50:fontcolor=red:fontfile='${fontFile.path}' -c:v mpeg4 $outputPath"; // Working
    // String command = "-i $path -vf drawtext=text='Hello':x=20:y=20:fontfile='${fontFile.path}' -c:v mpeg4 $outputPath"; // Working
    // String command = "-i $path -vf scale=640:480 $outputPath"; // Working
    // String command = "-i $path -c:v mpeg4 $outputPath"; // Working
    await FFmpegKitConfig.init();
    // await FFmpegKitConfig.setFontDirectory(fontFile.path);

    await FFmpegKitConfig.enableLogs();
    FFmpegKitConfig.enableLogCallback(
      (log) {
        print("mydebug------logs----------${log.getMessage()}");
      },
    );

    var dateTime1 = DateTime.now();

    // FFprobeKit.executeAsync(
    //         "-v quiet -show_entries format_tags=creation_time -of default=noprint_wrappers=1:nokey=1 $path")
    //     .then((value) {
    //   Logger.debug('mydebug-----addTimeStamp probekit value', [value.getArguments().toString()]);
    // });

    // FFprobeKit.getMediaInformationAsync(path).then((session) async {
    //   final information = await session.getMediaInformation();
    //   final date = session.getCreateTime();
    //   Logger.debug('mydebug-----addTimeStamp-----------', [date, information]);
    //
    //   if (information == null) {
    //
    //     // CHECK THE FOLLOWING ATTRIBUTES ON ERROR
    //     final state = FFmpegKitConfig.sessionStateToString(await session.getState());
    //     final returnCode = await session.getReturnCode();
    //     final failStackTrace = await session.getFailStackTrace();
    //     Logger.debug('mydebug-----addTimeStamp-----------', [returnCode, failStackTrace]);
    //     final duration = await session.getDuration();
    //     final output = await session.getOutput();
    //
    //   }
    // });

    FFmpegKit.executeAsync(command, (Session secondSession) async {
      final secondState = FFmpegKitConfig.sessionStateToString(await secondSession.getState());
      final secondReturnCode = await secondSession.getReturnCode();
      final secondFailStackTrace = await secondSession.getFailStackTrace();

      if (ReturnCode.isSuccess(secondReturnCode)) {
        var dateTime2 = DateTime.now();
        print("Burn subtitles completed successfully; playing video.${dateTime2.difference(dateTime1)}");

        completer.complete(File(outputPath));
      } else if (ReturnCode.isCancel(secondReturnCode)) {
        print("Burn subtitles operation cancelled");
      } else {
        print("Burn subtitles failed with state $secondState and rc $secondReturnCode.$secondFailStackTrace");
      }
    }).then((session) => print(session.getSessionId()));

    // FFmpegKit.executeAsync(command).then((session) async {
    //   final returnCode = await session.getReturnCode();
    //
    //   if (ReturnCode.isSuccess(returnCode)) {
    //     Logger.debug('mydebug-----addTimeStamp success', [returnCode]);
    //     completer.complete(File(outputPath));
    //     // SUCCESS
    //   } else if (ReturnCode.isCancel(returnCode)) {
    //     Logger.debug('mydebug-----addTimeStamp cancel', [returnCode]);
    //     completer.completeError("canceled");
    //
    //     // CANCEL
    //   } else {
    //     Logger.debug('mydebug-----addTimeStamp else', [returnCode]);
    //     completer.completeError("Error");
    //     // ERROR
    //   }
    // }, onError: (error, stackTrace) {
    //   Logger.debug('mydebug-----addTimeStamp', [error]);
    //   Logger.debug('mydebug-----addTimeStamp', [stackTrace]);
    // });

    // final command =
    //     '-i ${path} -vf drawtext="text=\'%{pts\:gmtime\:1584109442\,strftime\\\:\\\'%H\\\\\\\\:%M\\\\\\\\:%S\\\'\\\}\'" $outputPath';

    // final result = await flutterFFmpeg.execute(command);

    // if (result == 0) {
    //   print('Timestamp added to video successfully');
    //   completer.complete(File(outputPath));
    // } else {
    //   print('Error adding timestamp to video');
    //   completer.completeError("Error adding timestamp to video");
    // }
    return completer.future;
  }

  logFileSize() {
    Logger.debug('mydebug-----filesize---', [(lengthSync() / (1024 * 1024))]);
  }
}
