import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_headers/qc_general_header/widgets/qc_general_header.dart';
import 'package:flutter_trc/src/utils/media_upload/media_optimiser_utils.dart';
import 'package:flutter_trc/src/utils/media_upload/resource/media_content_type.dart';

import 'logging_service.dart';

class LogScreen extends StatelessWidget {
  const LogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const QcGeneralHeader(
        "Application Logs",
        showBackBtn: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: FutureBuilder(
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              String? logs = snapshot.data?.trim();
              return Column(
                children: [
                  Text(Validator.isNullOrEmpty(logs) ? "No logs found" : logs!),
                  const SizedBox(height: Dimens.space_24),
                  if (!Validator.isNullOrEmpty(logs))
                    CshBigButton(
                      text: "Send Log file",
                      onPressed: () {
                        // LoggingService.clearLog();
                        _sendLogFile(context);
                      },
                    ),
                ],
              );
            },
            future: LoggingService.getLogs(),
          ),
        ),
      ),
    );
  }

  _sendLogFile(BuildContext context) {
    if (LoggingService.logFile != null) {
      CshLoading().showLoading(context);
      MediaUploadUtil()
          .uploadMediaWithType(
              mediaFile: LoggingService.logFile!, fileName: "cops_video_logs.txt", contentType: MediaContentType.txt)
          .then((value) {
        CshLoading().hideLoading(context);
        Navigator.pop(context);
        LoggingService.clearLog();
        CshSnackBar.success(context: context, message: "Log file sent successfully");
      }, onError: (error) {
        CshLoading().hideLoading(context);
        CshSnackBar.error(context: context, message: error.toString());
      });
    }
  }
}
