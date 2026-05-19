import 'package:cached_network_image/cached_network_image.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';

Widget fetchImage(String placeholder, String? url, {BoxFit? fit}) {
  return CachedNetworkImage(
    imageUrl: url ?? "",
    useOldImageOnUrlChange: true,
    fit: fit,
    placeholder: (context, url) {
      return const CshShimmer(show: true);
    },
    errorWidget: (BuildContext context, String url, dynamic error) {
      return Image.asset(
        placeholder,
        fit: fit,
      );
    },
  );
}
