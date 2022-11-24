import 'package:core_widgets/core_widgets.dart';

enum ProjectActionType {
  homePage("home");

  final String val;

  const ProjectActionType(this.val);

  static ProjectActionType? valueFromString(String? str) {
    return firstWhere(ProjectActionType.values, (element) => element?.val == str);
  }

  static AbstractAction? getAction(ActionResponse actionResponse, ActionCallback? listener) {
    Map<String, dynamic>? data = actionResponse.actionData;
    if (actionResponse.actionType == null) {
      return null;
    }
    switch (ProjectActionType.valueFromString(actionResponse.actionType)) {
      case ProjectActionType.homePage:
        return CallToAction(extraData: data, callback: listener);
      default:
        return null;
    }
  }
}
