import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';

class SearchbarWidget extends StatelessWidget {
  final String? hint;
  final String? initialText;
  final Function(String query) onQuery;
  final EdgeInsets margin;

  const SearchbarWidget(
      {Key? key,
      this.hint,
      required this.onQuery,
      this.initialText,
      this.margin = const EdgeInsets.all(Dimens.space_16)})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimens.space_4),
          border: Border.all(color: Theme.of(context).secondaryHeaderColor)),
      child: SearchBarWidget(
        initialText: initialText,
        hintText: hint,
        onQuery: onQuery,
      ),
    );
  }
}
