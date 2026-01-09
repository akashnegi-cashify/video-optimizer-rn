import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';

class TRCRolePermissionWidget extends StatelessWidget {
  final Widget child;
  final Permission permission;
  final EdgeInsets padding;

  const TRCRolePermissionWidget(
      {required this.child, required this.permission, this.padding = EdgeInsets.zero, super.key});

  @override
  Widget build(BuildContext context) {
    if (PermissionController().hasPermission(permission)) {
      return Padding(
        padding: padding,
        child: child,
      );
    }

    return const SizedBox.shrink();
  }
}
