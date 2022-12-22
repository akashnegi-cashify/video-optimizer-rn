mayBe(Function exp, [dynamic defaultValue]) {
  try {
    return exp();
  } catch (e) {
    return defaultValue ?? null;
  }
}

String appendPath(String? path1, String path2) {
  if (path1 == null) {
    return path2;
  }

  if (path1.endsWith('/')) {
    return path1 + path2;
  } else {
    return '$path1/$path2';
  }
}
