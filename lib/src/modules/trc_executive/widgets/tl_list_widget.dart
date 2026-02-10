import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/common/widgets/my_search_bar_widget.dart';
import 'package:flutter_trc/src/modules/trc_executive/models/tl_list_response.dart';
import 'package:flutter_trc/src/modules/trc_executive/providers/tl_list_provider.dart';

import '../l10n.dart';

class TlListWidget extends StatefulWidget {
  /// Called when user selects a TL. Caller should update state and pop the sheet if needed.
  final void Function(TlListData tl) onTlSelected;

  const TlListWidget({super.key, required this.onTlSelected});

  @override
  State<TlListWidget> createState() => _TlListWidgetState();
}

class _TlListWidgetState extends State<TlListWidget> {
  List<TlListData> _allList = [];
  String _searchQuery = '';
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadTlList();
  }

  void _loadTlList() {
    setState(() {
      _loading = true;
      _error = null;
    });
    final provider = TlListProvider.of(context, listen: false);
    provider.getTlList(1, 500).then((list) {
      if (mounted) {
        setState(() {
          _allList = list;
          _loading = false;
          _error = null;
        });
      }
    }, onError: (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
          _loading = false;
        });
      }
    });
  }

  List<TlListData> get _filteredList {
    if (_searchQuery.trim().isEmpty) return _allList;
    final q = _searchQuery.trim().toLowerCase();
    return _allList.where((e) {
      return (e.name?.toLowerCase().contains(q) ?? false) ||
          (e.id?.toLowerCase().contains(q) ?? false);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var l10n = L10n(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(Dimens.space_16, Dimens.space_16, Dimens.space_16, 0),
          child: MySearchBarWidget(
            hintText: l10n.searchByName,
            onQuery: (query) {
              setState(() => _searchQuery = query);
            },
          ),
        ),
        Expanded(
          child: _loading
              ? const Center(child: CircularProgressIndicator())
              : _error != null
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.all(Dimens.space_16),
                        child: Text(
                          _error!,
                          style: theme.primaryTextTheme.displaySmall,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Dimens.space_16,
                        vertical: Dimens.space_12,
                      ),
                      itemCount: _filteredList.length,
                      separatorBuilder: (_, __) => const SizedBox(height: Dimens.space_12),
                      itemBuilder: (context, index) {
                        final item = _filteredList[index];
                        return InkWell(
                          onTap: () => widget.onTlSelected(item),
                          child: CshCard(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CshTextNew.subTitle1(item.id ?? ""),
                                const SizedBox(height: Dimens.space_4),
                                CshTextNew.subTitle1(item.name ?? ""),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
        ),
      ],
    );
  }
}
