import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class MySearchBarWidget extends StatefulWidget {
  final String? hintText;
  final Function(String query) onQuery;
  final bool showPrefixIcon;
  final bool showSuffixClearIcon;
  final Widget? prefixIcon;
  final bool isAutoFocus;
  final bool showBorder;

  const MySearchBarWidget({
    super.key,
    required this.onQuery,
    this.hintText,
    this.showPrefixIcon = true,
    this.showSuffixClearIcon = true,
    this.prefixIcon,
    this.isAutoFocus = false,
    this.showBorder = true,
  });

  @override
  State<MySearchBarWidget> createState() => _MySearchBarWidgetState();
}

class _MySearchBarWidgetState extends State<MySearchBarWidget> {
  final TextEditingController _searchController = TextEditingController();
  final TextInputDebounce _timer = TextInputDebounce();
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return CshTextFormField(
      controller: _searchController,
      focusNode: _focusNode,
      maxLines: 1,
      isBorderAllowed: widget.showBorder,
      autofocus: widget.isAutoFocus,
      counterText: "",
      maxLength: 50,
      suffixIcon: Validator.isTrue(widget.showSuffixClearIcon) && !Validator.isNullOrEmpty(_searchController.text)
          ? widget.prefixIcon ??
              CshIcon(FeatherIcons.x, iconSize: MobileIconSize.small, onClick: () {
                _searchController.clear();
                widget.onQuery("");
              })
          : null,
      prefixIcon: Validator.isTrue(widget.showPrefixIcon)
          ? widget.prefixIcon ?? CshIcon(FeatherIcons.search, iconSize: MobileIconSize.small)
          : null,
      hintText: widget.hintText ?? "Search",
      onChanged: (data) {
        setState(() {});
        _timer.start(() {
          widget.onQuery(data.trim());
        });
      },
    );
  }

  void requestFocus() {
    FocusScope.of(context).requestFocus(_focusNode);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _timer.stop();
    super.dispose();
  }
}
