import 'package:cached_network_image/cached_network_image.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Widget fetchImage(String placeholder, String? url, {BoxFit? fit, bool isUseCacheImage = false}) {
  if (isUseCacheImage) {
    return CachedNetworkImage(
      imageUrl: url ?? "",
      useOldImageOnUrlChange: true,
      fit: fit,
      placeholder: (context, url) {
        return const CshShimmer(
          show: true,
        );
      },
      errorWidget: (BuildContext context, String url, dynamic error) {
        return Image.asset(
          placeholder,
          fit: fit,
        );
      },
    );
  }
  return FadeInImage.assetNetwork(
    placeholder: placeholder,
    image: url ?? "",
    fit: fit,
    placeholderErrorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) => Image.asset(placeholder),
    imageErrorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
      return Image.asset(placeholder);
    },
  );
}
