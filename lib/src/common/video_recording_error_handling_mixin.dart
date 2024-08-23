import 'package:calculator_ui/calculator_ui.dart';
import 'package:camera/camera.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/cupertino.dart';

mixin VideoRecordingErrorHandlingMixin {
  void showCameraNotAvailableDialog(BuildContext context, {required String message, required VoidCallback onTryAgain}) {
    showPopup(context, title: "Camera not available!!", desc: message, barrierDismissible: false, actions: [
      CshBigButton(
        text: "Try Again",
        onPressed: () {
          onTryAgain();
        },
      )
    ]);
  }

  void showCameraInitializationErrorDialog(BuildContext context,
      {required String message, required VoidCallback onTryAgain}) {
    showPopup(context, title: "Camera Initialization Error!!", desc: message, barrierDismissible: false, actions: [
      CshBigButton(
        text: "Try Again",
        onPressed: () {
          onTryAgain();
        },
      )
    ]);
  }

  void showCameraPrepareErrorDialog(BuildContext context,
      {required String title, required String message, required VoidCallback onTryAgain}) {
    showPopup(context, title: title, desc: message, barrierDismissible: false, actions: [
      CshBigButton(
        text: "Try Again",
        onPressed: () {
          onTryAgain();
        },
      )
    ]);
  }

  void showStopVideoErrorDialog(BuildContext context, {required String message, required VoidCallback onTryAgain}) {
    showPopup(context, title: "Stop Video Error", desc: message, barrierDismissible: false, actions: [
      CshBigButton(
        text: "Try Again",
        onPressed: () {
          onTryAgain();
        },
      )
    ]);
  }

  void showInSufficientStorageDialog(BuildContext context, {required VoidCallback onProceed}) {
    showPopup(context,
        title: "Insufficient Storage",
        desc: "This device does not have enough storage to record video.",
        barrierDismissible: false,
        actions: [
          CshBigButton(
            text: "Ok",
            onPressed: () {
              onProceed();
            },
          )
        ]);
  }

  handleException(BuildContext context, {required CameraException error, required VoidCallback onRetry}) {
    switch (error.code) {
      case 'CameraAccessDenied':
        showCameraPrepareErrorDialog(context,
            title: "You have denied camera access", message: error.description.toString(), onTryAgain: () {
          Navigator.pop(context); // dismiss dialog
          onRetry();
        });
        break;
      case 'CameraAccessDeniedWithoutPrompt':
        // iOS only
        showCameraPrepareErrorDialog(context,
            title: "Please go to Settings app to enable camera access.",
            message: error.description.toString(), onTryAgain: () {
          Navigator.pop(context); // dismiss dialog
          onRetry();
        });
        break;
      case 'CameraAccessRestricted':
        // iOS only
        showCameraPrepareErrorDialog(context,
            title: "Camera access is restricted.", message: error.description.toString(), onTryAgain: () {
          Navigator.pop(context); // dismiss dialog
          onRetry();
        });
        break;
      case 'AudioAccessDenied':
        showCameraPrepareErrorDialog(context,
            title: "You have denied audio access.", message: error.description.toString(), onTryAgain: () {
          Navigator.pop(context); // dismiss dialog
          onRetry();
        });
        break;
      case 'AudioAccessDeniedWithoutPrompt':
        // iOS only
        showCameraPrepareErrorDialog(context,
            title: "Please go to Settings app to enable audio access.",
            message: error.description.toString(), onTryAgain: () {
          Navigator.pop(context); // dismiss dialog
          onRetry();
        });
        break;
      // iOS only
      case 'AudioAccessRestricted':
        showCameraPrepareErrorDialog(context,
            title: "Audio access is restricted.", message: error.description.toString(), onTryAgain: () {
          Navigator.pop(context); // dismiss dialog
          onRetry();
        });
        break;
      default:
        showCameraPrepareErrorDialog(context, title: "Error - ${error.code}", message: error.description.toString(),
            onTryAgain: () {
          Navigator.pop(context); // dismiss dialog
          onRetry();
        });
        break;
    }
  }
}
