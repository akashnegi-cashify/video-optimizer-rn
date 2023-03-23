import 'dart:async';
import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/utils/image_assest_helper.dart';
import '../l10n.dart';
import 'misc.dart';

typedef OnRefreshCallback = Future<void> Function();

abstract class PaginatedListState<TItem, TStatefulWidget extends StatefulWidget> extends State<TStatefulWidget> {
  int _pageNo = -1;
  List<TItem> _items = [];
  bool isLoading = true;
  bool _isMoreDataToLoad = true;
  int pageSize;
  double maxExtent = -1;
  int initialScrollOffset;
  String? _errorMessage;
  bool isAddMoveToTopFeature;

  var scrollController = ScrollController();

  bool _showMoveToTopButton = false;

  PaginatedListState({this.initialScrollOffset = 10, this.pageSize = 10, this.isAddMoveToTopFeature = false});

  set pageNo(int value) {
    _pageNo = value;
  }

  int get pageNo {
    return _pageNo;
  }

  List<TItem> get items {
    return _items;
  }

  set items(List<TItem> value) {
    items = value;
  }

  @override
  void initState() {
    super.initState();
    scheduleMicrotask(() {
      _requestData();
    });
  }

  void resetAndRefreshScreen({int? pageNumber}) {
    _items = [];
    _pageNo = pageNumber ?? -1;
    _requestData();
  }

  _withChangeListener(Widget child) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scrollInfo) {
        if (isAddMoveToTopFeature) {
          if (scrollInfo.metrics.pixels > scrollInfo.metrics.viewportDimension) {
            setState(() {
              _showMoveToTopButton = true;
            });
          } else {
            setState(() {
              _showMoveToTopButton = false;
            });
          }
        }
        if (!isLoading && isScrollPositionMeet(scrollInfo, initialScrollOffset, maxExtent) && _isMoreDataToLoad) {
          maxExtent = scrollInfo.metrics.maxScrollExtent;
          _requestData();
        }
        return true;
      },
      child: child,
    );
  }

  Widget iterate(
    Widget Function(TItem item, int index) builder, {
    Widget Function()? onNoDataFound,
    Widget Function(String errorMessage)? onError,
    Widget? separator,
    OnRefreshCallback? onRefresh,
    EdgeInsets? padding,
  }) {
    return _withChangeListener(
      _getRenderView(builder,
          onNoDataFound: onNoDataFound, onRefresh: onRefresh, separator: separator, onError: onError, padding: padding),
    );
  }

  Widget _getRenderView(
    Widget Function(TItem item, int index) builder, {
    Widget Function()? onNoDataFound,
    OnRefreshCallback? onRefresh,
    Widget? separator,
    Widget Function(String errorMessage)? onError,
    EdgeInsets? padding,
  }) {
    Logger.log('_getRenderView', [items.length, isLoading, onNoDataFound]);
    if (items == null) {
      return onNoDataFound != null ? onNoDataFound() : _noDataView();
    }

    if (!Validator.isNullOrEmpty(_errorMessage) && _pageNo < 1) {
      return onError != null ? onError(_errorMessage!) : _noDataView();
    }

    if (items.isEmpty) {
      if (isLoading == true) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else {
        return onNoDataFound != null ? onNoDataFound() : _noDataView();
      }
    }
    if (onRefresh != null) {
      return RefreshIndicator(
        onRefresh: () async {
          onRefresh();
          resetAndRefreshScreen();
        },
        child: _buildListView(builder, separator, padding),
      );
    } else {
      return _buildListView(builder, separator, padding);
    }
  }

  _buildListView(Widget Function(TItem item, int index) builder, Widget? separator, EdgeInsets? padding) {
    var body = ListView.separated(
        itemCount: items.length,
        controller: scrollController,
        padding: padding,
        physics: const AlwaysScrollableScrollPhysics(),
        itemBuilder: (_, index) => builder(items[index], index),
        separatorBuilder: (BuildContext context, int index) {
          if (separator != null) {
            return separator;
          }
          return const SizedBox.shrink();
        });
    if (isAddMoveToTopFeature) {
      return _buildWithScaffold(body);
    } else {
      return body;
    }
  }

  _noDataView() {
    var l10n = L10n(context);
    ThemeData theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(Dimens.space_16),
      child: Container(
        constraints: const BoxConstraints.expand(),
        child: Text(
          _errorMessage ?? l10n.noDataFound,
          style: theme.primaryTextTheme.subtitle1,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  void _requestData() {
    if (mounted) {
      setState(() {
        isLoading = true;
      });
    }

    requestApi(++pageNo, onSuccess: (List<TItem>? list) {
      if (mounted) {
        setState(() {
          _isMoreDataToLoad = list!.length == pageSize;
          _items.addAll(list);
          isLoading = false;
        });
      }
    }, onError: (String errorMessage) {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  void setErrorMessage(String? errorMessage) {
    setState(() {
      _errorMessage = errorMessage;
    });
  }

  void requestApi(
    int pageNo, {
    Function(List<TItem>? list)? onSuccess,
    Function(String errorMessage)? onError,
  });

  Widget _buildWithScaffold(Widget body) {
    return Scaffold(
      floatingActionButton: _showMoveToTopButton
          ? InkResponse(
              onTap: () {
                scrollController.animateTo(0, duration: Duration(milliseconds: 300), curve: Curves.easeIn);
              },
              child: Image.asset(
                ImageAssetHelper.imagePath("ic_fab_button.png"),
                height: Dimens.space_44,
                width: Dimens.space_44,
              ),
            )
          : null,
      body: body,
    );
  }
}
