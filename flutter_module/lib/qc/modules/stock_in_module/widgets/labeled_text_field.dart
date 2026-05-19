import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';

class LabeledTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final Widget? suffixIcon;
  final TextEditingController? controller;

  const LabeledTextField({
    super.key,
    required this.label,
    required this.hintText,
    this.suffixIcon,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CshTextNew.h4(label),
        const SizedBox(height: Dimens.space_8),
        CshTextFormField(
          hintText: hintText,
          suffixIcon: suffixIcon,
          controller: controller,
        ),
      ],
    );
  }
}
