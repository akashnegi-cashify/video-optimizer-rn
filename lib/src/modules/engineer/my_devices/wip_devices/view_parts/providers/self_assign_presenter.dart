import 'package:core_widgets/core_widgets.dart';
import 'package:flutter_trc/src/modules/engineer/l10n.dart';
import 'package:flutter_trc/src/modules/engineer/my_devices/wip_devices/view_parts/models/replace_part_request.dart';
import 'package:flutter_trc/src/modules/engineer/my_devices/wip_devices/view_parts/widgets/self_assign_part_widget.dart';

import '../../../../resources/engineer_api_service.dart';

class SelfAssignPresenter {
  final ViewAction actions;

  SelfAssignPresenter(this.actions);

  void replacePart(ReplacePartRequest data, L10n l10n) {
    EngineerAPIService.replacePart(data).listen((event) {
      if (event?.isSuccess == true) {
        actions.onReplacePartSuccess();
      } else {
        actions.onError(event?.errorMsg ?? l10n.somethingWentWrong);
      }
    }, onError: (error, stacktrace) {
      actions.onError(ApiErrorHelper.getErrorMessage(error) ?? l10n.somethingWentWrong);
    });
  }
}
