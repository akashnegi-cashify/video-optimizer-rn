import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter_trc/src/modules/elss/common_resources/elss_service.dart';
import '../modules/elss/common_models/qc_s3_details_config.dart';
import '../resources/models/s3_details_response.dart';
import '../services/s3_details.dart';
import '../utils/misc.dart';
import 'amplifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AmplifyProvider extends CshChangeNotifier {
  static AmplifyProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<AmplifyProvider>(context, listen: listen);
  }

  S3DetailsResponse? configResponse;
  QcS3DetailsResponse? qcConfigResponse;

  getS3DetailsForQcAndConfigAmplify() {
    ElssService.fetchS3Details().listen(
      (event) {
        if (event != null) {
          qcConfigResponse = event;
          Logger.log('mydebug configResponse?.cognitoPoolId', [qcConfigResponse?.bucketName, qcConfigResponse?.poolId]);
          if (!Validator.isNullOrEmpty(qcConfigResponse?.bucketName) &&
              !Validator.isNullOrEmpty(qcConfigResponse?.poolId)) {
            _setAmplifierDetails(qcConfigResponse!.bucketName!, qcConfigResponse!.poolId!);
          }
        }
      },
      onError: (error) {
        String errorMessage = ApiErrorHelper.getErrorMessage(error) ?? "Something went wrong!!";
        Logger.debug('mydebug------AmplifyProvider.getS3DetailsAndConfigureAmplify', [errorMessage]);
      },
      onDone: () {
        notifyListeners();
      },
    );
  }

  getS3DetailsForTrcAndConfigureAmplify() {
    S3DetailsService.fetchS3Details().listen((event) {
      if (event != null) {
        configResponse = event;

        Logger.log(
            'mydebug configResponse?.cognitoPoolId', [configResponse?.data?.bucketName, configResponse?.data?.poolId]);
        if (!Validator.isNullOrEmpty(configResponse?.data?.bucketName) &&
            !Validator.isNullOrEmpty(configResponse?.data?.poolId)) {
          _setAmplifierDetails(configResponse!.data!.bucketName!, configResponse!.data!.poolId!);
        }
      }
    }, onError: (error) {
      String errorMessage = ApiErrorHelper.getErrorMessage(error) ?? "Something went wrong!!";
      Logger.debug('mydebug------AmplifyProvider.getS3DetailsAndConfigureAmplify', [errorMessage]);
    }, onDone: () {
      notifyListeners();
    });
  }

  //Set amplifier details data;
  _setAmplifierDetails(String bucketName, String cognitoPoolId) {
    Amplifier().init(bucketName, cognitoPoolId);
  }

  uploadFile({
    required String fileName,
    String? folderName,
    dynamic? file,
    required Function(String) onFileUploaded,
    required Function(String) onFailed,
    Function(int currentBytes, int totalBytes)? onProgress,
  }) {
    String filePath = appendPath(folderName, fileName);

    if (file != null) {
      Amplifier().uploadFile(filePath, file, onFileUploaded, onFailed, onProgress: onProgress);
    }
  }

  String? getQcFolderName() {
    return qcConfigResponse?.folderName;
  }

  String? getFolderName() {
    return configResponse?.data?.folderName;
  }

  Future<String> getS3FileUrlFromS3Key({required String filePath, bool? fullPath = false}) async {
    String imageUrl = "";
    if (filePath.startsWith(Amplifier.PREFIX)) {
      String key = Amplifier.removePrefix(filePath);
      await Amplifier().getFileUrl(key, fullPath: fullPath).then((value) {
        imageUrl = value;
      });
    }
    notifyListeners();
    return imageUrl;
  }
}
