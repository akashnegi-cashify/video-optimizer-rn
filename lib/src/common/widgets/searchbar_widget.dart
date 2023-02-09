import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';

class SearchbarWidget extends StatelessWidget {
  final String? hint;
  final String? initialText;
  final Function(String query) onQuery;

  const SearchbarWidget({Key? key, this.hint, required this.onQuery, this.initialText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(Dimens.space_16),
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
