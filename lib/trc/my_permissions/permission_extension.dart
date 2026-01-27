import 'package:core_widgets/core_widgets.dart';

extension MyPermission on PermissionController {
  hasPermissionModule(Permission permission) {
    if (Validator.isListNullOrEmpty(permission.permissions)) {
      return false;
    }

    var item = userPermissions?.modules?.firstWhere((element) => element.moduleKey == permission.module);
    if (Validator.isListNullOrEmpty(item?.permissionList)) {
      return true;
    }
    for (var detail in item!.permissionList!) {
      if (permission.permissions!.contains(detail.permissionKey) &&
          ((detail.selected == true || detail.groupPermission == true))) {
        return true;
      }
    }
    return false;
  }

  List<PermissionDetail>? getAllPermission(String moduleName) {
    var item = userPermissions?.modules?.firstWhere((element) => element.moduleKey == moduleName);
    return item?.permissionList;
  }
}
