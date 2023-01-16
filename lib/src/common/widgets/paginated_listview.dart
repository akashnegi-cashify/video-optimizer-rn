import 'dart:async';

import 'package:core/core.dart';
import 'package:flutter/material.dart';

typedef OnRefreshCallback = Future<void> Function();

@Deprecated('Use PaginatedListView instead'
    'This feature was deprecated to use MVVM architecture')
abstract class PaginatedListState<TItem, TStatefulWidget extends StatefulWidget> extends State<TStatefulWidget> {
  int _pageNo = 0;
  List<TItem?> _items = [];
  bool isLoading = true;
  bool _isMoreDataToLoad = true;
  int pageSize;
  double maxExtent = -1;
  double initialScrollOffset;

  PaginatedListState({this.initialScrollOffset = 10, this.pageSize = 10});

  set pageNo(int value) {
    _pageNo = value;
  }

  int get pageNo {
    return _pageNo;
  }

  List<TItem?> get items {
    return _items;
  }

  set items(List<TItem?> items) {
    setState(() {
      _items = items;
    });
  }

  @override
  void initState() {
    super.initState();
    scheduleMicrotask(() {
      _requestData();
    });
  }

  void resetAndRefreshScreen() {
    _items = [];
    _pageNo = 0;
    _requestData();
  }

  _withChangeListener(Widget child) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scrollInfo) {
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
    Widget Function(TItem? item, int index) builder, {
    Widget Function()? onNoDataFound,
    OnRefreshCallback? onRefresh,
  }) {
    return _withChangeListener(
      _getRenderView(builder, onNoDataFound: onNoDataFound, onRefresh: onRefresh),
    );
  }

  Widget _getRenderView(Widget Function(TItem? item, int index) builder,
      {Widget Function()? onNoDataFound, OnRefreshCallback? onRefresh}) {
    Logger.log('_getRenderView', [items.length, isLoading, onNoDataFound]);
    // if (items == null) {
    //   return onNoDataFound != null ? onNoDataFound() : _noDataView();

    // }

    if (items.isEmpty) {
      if (isLoading == true) {
        return Container();
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
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: items.length,
          itemBuilder: (_, index) => builder(items[index], index),
        ),
      );
    } else {
      return ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: items.length,
        itemBuilder: (_, index) => builder(items[index], index),
      );
    }
  }

  _noDataView() {
    return const Text(
      "No Result found",
    );
    // return Padding(
    //   padding: EdgeInsets.all(Dimens.space_16),
    //   child: Container(
    //     // constraints: BoxConstraints.expand(),
    //     child: Text(
    //       l10n.dataNotFound,
    //       style: theme.accentTextTheme.bodyText2,
    //       textAlign: TextAlign.start,
    //     ),
    //   ),
    // );
  }

  void _requestData() {
    setState(() {
      isLoading = true;
    });

    requestApi(++pageNo, onSuccess: (List<TItem>? list) {
      setState(() {
        _isMoreDataToLoad = list!.length == pageSize;
        _items.addAll(list);
        isLoading = false;
      });
    }, onError: (String? errorMessage) {
      setState(() {
        isLoading = false;
      });
    });
  }

  void requestApi(
    int pageNo, {
    Function(List<TItem>? list)? onSuccess,
    Function(String? errorMessage)? onError,
  });
}

bool isScrollPositionMeet(ScrollNotification scrollInfo, double initialScrollOffset, double maxExtent) {
  return scrollInfo.metrics.pixels > (initialScrollOffset + maxExtent);
}
