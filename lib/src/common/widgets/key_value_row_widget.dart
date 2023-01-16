import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';

class KeyValueRowWidget extends StatelessWidget {
  final String title;
  final String value;

  const KeyValueRowWidget({Key? key, required this.title, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [CshTextNew.bodyText2(title), CshTextNew.h3(value)],
    );
  }
}
