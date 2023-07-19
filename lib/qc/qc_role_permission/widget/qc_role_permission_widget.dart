import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/qc_role_permission/qc_role_permission_helper.dart';

class QcRolePermissionWidget extends StatelessWidget {
  final Widget child;
  final QcRole role;
  final EdgeInsets padding;

  const QcRolePermissionWidget({required this.child, required this.role, this.padding = EdgeInsets.zero, super.key});

  @override
  Widget build(BuildContext context) {
    if (QcRolePermissionHelper.hasPermission(role)) {
      return Padding(
        padding: padding,
        child: child,
      );
    }
    return const SizedBox.shrink();
  }
}
